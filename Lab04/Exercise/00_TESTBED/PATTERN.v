`ifdef RTL
	`timescale 1ns/10ps
	`include "NN.v"  
	`define CYCLE_TIME 19.7
`endif
`ifdef GATE
	`timescale 1ns/10ps
	`include "../02_SYN/Netlist/NN_SYN.v"
	`define CYCLE_TIME 19.7
`endif

module PATTERN(
	// Output signals
	clk,
	rst_n,
	epoch, 
	dataset_index,
	in_valid_d,
	in_valid_t,
	in_valid_w1,
	in_valid_w2,
	data_point,
	target,
	weight1,
	weight2,
	// Input signals
	out_valid,
	out
);

//---------------------------------------------------------------------
//   PARAMETER
//---------------------------------------------------------------------
// IEEE 754 floating point parameters
parameter inst_sig_width       = 23;
parameter inst_exp_width       = 8;
parameter inst_ieee_compliance = 0;
parameter inst_arch            = 2;

// Testbench parameters
parameter EPOCH_MAX     = 24; // 25 epochs
parameter EPOCH_WIDTH   = $clog2(EPOCH_MAX); 
parameter DATASET_MAX   = 99; // 100 data points for training
parameter DATASET_WIDTH = $clog2(DATASET_MAX); // 100 data points for training

parameter PATTERN_NUM = 100;
parameter INPUT_DIM   = 4;
parameter HIDDEN_DIM  = 3;
parameter EPOCHS      = 25;
parameter DATA_SIZE   = 100;
parameter CYCLE_LIMIT = 300;
parameter gap         = 2; // gap between weight and data input

wire [inst_sig_width+inst_exp_width:0] TOLERANCE;
// assign TOLERANCE = 32'h38d1b717; // Error tolerance: |(y_pred - target) / target| < 0.0001 in hex
assign TOLERANCE = 32'h3a03126f;
// 32'h38d1b717: 0.0001
// 32'h3a03126f: 0.0005
//================================================================
//   INPUT AND OUTPUT DECLARATION                         
//================================================================
output reg clk, rst_n, in_valid_d, in_valid_t, in_valid_w1, in_valid_w2;

// Loop variables
output reg [EPOCH_WIDTH-1:0]   epoch;
output reg [DATASET_WIDTH-1:0] dataset_index; 

output reg [inst_sig_width+inst_exp_width:0] data_point, target;
output reg [inst_sig_width+inst_exp_width:0] weight1, weight2;
input out_valid;
input [inst_sig_width+inst_exp_width:0] out;

//================================================================
// wires & registers
//================================================================
reg  [inst_sig_width+inst_exp_width:0] k, l; // Loop variables
reg  [inst_sig_width+inst_exp_width:0] out_gold, div1_out_abs;
wire [inst_sig_width+inst_exp_width:0] sub1_out, div1_out; // mult1_out
wire under_tolerance;

// dummy signals
// wire [7:0] dummy1, dummy2, dummy3, dummy9, dummy10;
// wire dummy4, dummy5, dummy6;
// wire [inst_sig_width+inst_exp_width:0] dummy7, dummy8;
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB1_P (.a(out_gold), .b(out), .rnd(3'b000), .z(sub1_out), .status());
DW_fp_div  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) DIV1_P (.a(sub1_out), .b(out_gold), .rnd(3'b000), .z(div1_out), .status());
DW_fp_cmp  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) CMP1_P (.a(div1_out_abs), .b(TOLERANCE), .altb(under_tolerance), .agtb(), .aeqb(), .unordered(), .z0(), .z1(), .status0(), .status1(), .zctr(1'b0));

always@(*) begin
	if (out_gold == 32'h0000_0000) begin // prevent div by 0
		div1_out_abs = (sub1_out[31] == 0) ? sub1_out : {1'b0, sub1_out[30:0]}; // take abs value
	end
	else begin
		div1_out_abs = (div1_out[31] == 0) ? div1_out : {1'b0, div1_out[30:0]}; // take abs value
	end
end

//=================================================================
// Integers
//=================================================================
integer total_cycles;
integer patcount;
integer cycles;
integer input_file, output_file, target_file, weight1_file, weight2_file;
integer in_desc, out_desc, target_desc, weight1_desc, weight2_desc;
integer pat_no;

//================================================================
// clock
//================================================================
always	#(`CYCLE_TIME/2.0) clk = ~clk;
initial	clk = 0;

//================================================================
// initial
//================================================================
initial begin
	// Initialize input signals
	rst_n        = 1'b1;
	in_valid_w1  = 1'b0;
	in_valid_w2  = 1'b0;
	in_valid_d   = 1'b0;
	in_valid_t   = 1'b0;
	data_point   =  'dx;
	target       =  'dx;
	weight1      =  'dx;
	weight2      =  'dx;

	force clk    = 0;
	total_cycles = 0;
	reset_task;
	
	weight1_file = $fopen("../00_TESTBED/weight1_ignore.txt", "r");
	weight2_file = $fopen("../00_TESTBED/weight2_ignore.txt", "r");
	input_file   = $fopen("../00_TESTBED/input_ignore.txt", "r");
	target_file  = $fopen("../00_TESTBED/target_ignore.txt", "r");
  	output_file  = $fopen("../00_TESTBED/output_ignore.txt", "r");
	if (weight1_file == 0) begin
		$display("Error: Cannot open weight1 file!");
		fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
	end
	if (weight2_file == 0) begin
		$display("Error: Cannot open weight2 file!");
		fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
	end
	if (input_file == 0) begin
		$display("Error: Cannot open input file!");
		fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
	end
	if (target_file == 0) begin
		$display("Error: Cannot open target file!");
		fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
	end
	if (output_file == 0) begin
		$display("Error: Cannot open output file!");
		fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
	end
    @(negedge clk);

	epoch = 0;
	dataset_index = 0;
	pat_no = 0;

	for (patcount = 0; patcount < (PATTERN_NUM * EPOCHS * DATA_SIZE); patcount = patcount + 1) begin
		// 1. weights_task every (EPOCHS * DATA_SIZE)
		if (patcount % (EPOCHS * DATA_SIZE) == 0) begin
			weights_task; // pull in_valid_w1 and in_valid_w2 high
			repeat(gap) @(negedge clk);
		end

		// 2. input/check every iteration
		input_data;
		wait_out_valid;
		check_ans;

		// 3. Update epoch/dataset_index
		dataset_index = dataset_index + 1;

		if (dataset_index == DATA_SIZE) begin
			dataset_index = 0;
			epoch = epoch + 1;
		end

		if (epoch == EPOCHS) begin
			pat_no = pat_no + 1;
			epoch = 0;
		end
	end
	#(1000);
	fclose_all(weight1_file, weight2_file, input_file, target_file, output_file);
	YOU_PASS_task;
end

task fclose_all;
    input integer weight1_file;
    input integer weight2_file;
    input integer input_file;
    input integer target_file;
    input integer output_file;

    begin
        if (weight1_file) $fclose(weight1_file);
        if (weight2_file) $fclose(weight2_file);
        if (input_file)   $fclose(input_file);
        if (target_file)  $fclose(target_file);
        if (output_file)  $fclose(output_file);
    end
endtask

task reset_task; begin
	#(10); rst_n = 0;
	#(10);
	if ((out !== 0) || (out_valid !== 0)) begin
		$display("--------------------------------------------------------------------------------------------------------------------------------------------");
		$display("                                                                        FAIL!                                                               ");
		$display("                                                  Output signal should be 0 after initial RESET at %8t                                      ", $time);
		$display("--------------------------------------------------------------------------------------------------------------------------------------------");
		#(100);
	    fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
	end
	#(10);  rst_n = 1;
	#(3.0); release clk;
end endtask

task weights_task; begin
	in_valid_w1 = 'b1;
	in_valid_w2 = 'b1;
	for (k = 0; k < INPUT_DIM*HIDDEN_DIM; k = k + 1) begin
		weight1_desc = $fscanf(weight1_file, "%h", weight1);
		if (weight1_desc == 0) begin
			$display("Error: Failed to read weight1!");
			fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
		end
		if (k < HIDDEN_DIM) begin
			weight2_desc = $fscanf(weight2_file, "%h", weight2);
			if (weight2_desc == 0) begin
				$display("Error: Failed to read weight2!");
				fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
			end
		end
		else if (k == HIDDEN_DIM) begin
			in_valid_w2 = 'b0;
			weight2     = 'bx;
		end
		// $display("weight1 = %h, weight2 = %h", weight1, weight2);
		@(negedge clk);
	end
	in_valid_w1 = 'b0;
	weight1 = 'bx;
	weight2 = 'bx;
end endtask

task input_data; begin
	in_valid_d = 'b1;
	in_valid_t = 'b1;
	for (l = 0; l < INPUT_DIM; l = l + 1) begin
		in_desc = $fscanf(input_file, "%h", data_point);
		if (in_desc == 0) begin
			$display("Error: Failed to read input layer data!");
			fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
		end

		if (l >= 1) begin
			in_valid_t = 'b0;
			target     = 'bx;
		end
		else begin
			target_desc = $fscanf(target_file, "%h", target);
			if (target_desc == 0) begin
				$display("Error: Failed to read target input data!");
				fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
			end
		end
		// $display("data_point = %h, target = %h", data_point, target);
		@(negedge clk);
	end
	out_desc = $fscanf(output_file, "%h", out_gold); // Read ealry, so that check_ans don't have to wait for it (can read it right away)
	if (out_desc == 0) begin
		$display("Error: Failed to read y_gold!");
		fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
	end
	in_valid_d = 'b0;
	in_valid_t = 'b0;
	data_point = 'bx;
end endtask

task wait_out_valid; begin
	cycles = 0;
	while (out_valid === 0) begin
		cycles = cycles + 1;
		if (cycles == CYCLE_LIMIT) begin
			$display("--------------------------------------------------------------------------------------------------------------------------------------------");
			$display("                                                                                                                                            ");
			$display("                                                     The execution latency are over %2d cycles                                              ", CYCLE_LIMIT);
			$display("                                                                                                                                            ");
			$display("--------------------------------------------------------------------------------------------------------------------------------------------");
			repeat(2)@(negedge clk);
			fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
		end
		@(negedge clk);
	end
	total_cycles = total_cycles + cycles; 
end endtask

task check_ans; begin
    while (out_valid === 1) begin
		$display("out = %h, out_gold = %h, div1_out_abs = %h = %.6f", out, out_gold, div1_out_abs, $bitstoshortreal(div1_out_abs));
		if (out !== out_gold && !under_tolerance) begin // Fail, if abs(out_gold - out) / out_gold > 0.0001
			$display("--------------------------------------------------------------------------------------------------------------------------------------------");
			$display("                                                                 FAIL! WRONG OUTPUT!                                                        ");
			$display("                                                         Pattern NO.%1d Epoch NO.%1d Data NO.%1d                                            ", pat_no, epoch, dataset_index);
			$display("	                                                 y_pred = %h, y_gold = %h                                                                 ", out, out_gold);
			$display("	                                                 y_pred = %.2e, y_gold = %.2e                                                             ", $bitstoshortreal(out), $bitstoshortreal(out_gold));
			$display("	                                 Error = |(y_gold-y_pred)/y_gold| = %.2e > Tolerance = %.2e                                               ", $bitstoshortreal(div1_out_abs), $bitstoshortreal(TOLERANCE));
			$display("--------------------------------------------------------------------------------------------------------------------------------------------");
			@(negedge clk);
			fclose_all(weight1_file, weight2_file, input_file, target_file, output_file); $finish;
		end
		else begin
			$display("\033[0;34mPASS PATTERN NO.%03d, EPOCH_%02d, DATA_%03d\033[m \033[0;32m Cycles:%2d\033[m",
				pat_no, epoch, dataset_index, cycles);
		end
		@(negedge clk);
    end
	@(negedge clk);
end endtask

task YOU_PASS_task; begin
	$display("----------------------------------------------------------------------------------------------------------------------");
	$display("                                                  Congratulations!                						            ");
	$display("                                           You have passed all patterns!          						            ");
	$display("                                           Your execution cycles = %5d cycles   						                ", total_cycles);
	$display("                                           Your clock period = %.1f ns        					                    ", `CYCLE_TIME);
	$display("                                           Your total latency = %.1f ns         						                ", total_cycles*`CYCLE_TIME);
	$display("----------------------------------------------------------------------------------------------------------------------");
	$finish;
end endtask
endmodule
