`ifdef RTL
	`timescale 1ns/10ps
	`include "NN.v"  
	`define CYCLE_TIME 20.0
`endif
`ifdef GATE
	`timescale 1ns/10ps
	`include "../02_SYN/Netlist/NN_SYN.v"
	`define CYCLE_TIME 20.0
`endif

`include "DW_fp_mult.v"
`include "DW_fp_sub.v"
`include "DW_fp_div.v"
`include "DW_fp_cmp.v"

module PATTERN(
	// Output signals
	clk,
	rst_n,
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
parameter PATTERN_NUM = 100;
parameter INPUT_DIM   = 4;
parameter HIDDEN_DIM  = 3;
parameter EPOCHS      = 25;
parameter DATA_SIZE   = 100;
parameter CYCLE_LIMIT = 300;

wire [inst_sig_width+inst_exp_width:0] NEG_ONE, TOLERANCE; // Error tolerance: |(y_pred - target) / target| < 0.0001
assign NEG_ONE   = 32'hbf800000; // -1.0 in hex
assign TOLERANCE = 32'h38d1b717; // 0.0001 in hex

//================================================================
//   INPUT AND OUTPUT DECLARATION                         
//================================================================
output reg clk, rst_n, in_valid_d, in_valid_t, in_valid_w1, in_valid_w2;
output reg [inst_sig_width+inst_exp_width:0] data_point, target;
output reg [inst_sig_width+inst_exp_width:0] weight1, weight2;
input out_valid;
input [inst_sig_width+inst_exp_width:0] out;

//================================================================
// wires & registers
//================================================================
reg  [inst_sig_width+inst_exp_width:0] out_gold;
wire [inst_sig_width+inst_exp_width:0] sub1_out, div1_out, mult1_out, div1_out_abs;
wire under_tolerance;
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB1_P (.a(out_gold), .b(out), .rnd(3'b000), .z(sub1_out), .status());
DW_fp_div  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) DIV1_P (.a(sub1_out), .b(out_gold), .rnd(3'b000), .z(div1_out), .status());
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL1_P (.a(div1_out), .b(NEG_ONE), .rnd(3'b000), .z(mult1_out), .status());
assign div1_out_abs = (div1_out[31] == 0) ? div1_out : mult1_out;
DW_fp_cmp  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) CMP1_P (.a(div1_out_abs), .b(TOLERANCE), .altb(under_tolerance), .agtb(), .aeqb(), .unordered(), .z0(), .z1(), .status0(), .status1(), .zctr(1'b0));

//=================================================================
// Integers
//=================================================================
integer total_cycles;
integer patcount;
integer cycles;
integer input_file, output_file, target_file, weight1_file, weight2_file;
integer in_desc, out_desc, target_desc, weight1_desc, weight2_desc;
integer gap;
integer i, j, k, l, m, n; // Loop variables

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
		$finish;
	end
	if (weight2_file == 0) begin
		$display("Error: Cannot open weight2 file!");
		$finish;
	end
	if (input_file == 0) begin
		$display("Error: Cannot open input file!");
		$finish;
	end
	if (target_file == 0) begin
		$display("Error: Cannot open target file!");
		$finish;
	end
	if (output_file == 0) begin
		$display("Error: Cannot open output file!");
		$finish;
	end
    @(negedge clk);

	for (patcount = 1; patcount <= PATTERN_NUM; patcount = patcount + 1) begin
		if (patcount == 1) repeat(2)@(negedge clk);
		else                        @(negedge clk);
		weights_task;
		for (i = 0; i < EPOCHS; i = i + 1) begin // epoch_0 ~ epoch_24
			for (j = 0; j < DATA_SIZE; j = j + 1) begin // data_0 ~ data_99
				if (i == 0 && j == 0) repeat(gap)@(negedge clk);
				else                             @(negedge clk);
				input_data; // read input data and target data
				wait_out_valid;
				check_ans;
				$display("\033[0;34mPASS PATTERN NO.%3d, EPOCH_%1d, DATA_%1d\033[m \033[0;32m Cycles: %3d\033[m", patcount, i+1, j+1, cycles);
			end
		end
	end
	#(1000);
	YOU_PASS_task;
	fclose_all(weight1_file, weight2_file, input_file, target_file, output_file);
	$finish;
end

task fclose_all;
    input integer weight1_file;
    input integer weight2_file;
    input integer input_file;
    input integer target_file;
    input integer output_file;

    begin
        if (weight1_file)  $fclose(weight1_file);
        if (weight2_file)  $fclose(weight2_file);
        if (input_file)    $fclose(input_file);
        if (target_file)   $fclose(target_file);
        if (output_file)   $fclose(output_file);
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
	    $finish;
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
			$finish;
		end
		if (k < HIDDEN_DIM) begin
			weight2_desc = $fscanf(weight2_file, "%h", weight2);
			if (weight2_desc == 0) begin
				$display("Error: Failed to read weight2!");
				$finish;
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
			$finish;
		end

		if (l >= 1) begin
			in_valid_t = 'b0;
			target     = 'bx;
		end
		else begin
			target_desc = $fscanf(target_file, "%h", target);
			if (target_desc == 0) begin
				$display("Error: Failed to read target input data!");
				$finish;
			end
		end
		// $display("data_point = %h, target = %h", data_point, target);
		@(negedge clk);
	end
	out_desc = $fscanf(output_file, "%h", out_gold); // Read ealry, so that check_ans don't have to wait for it (can read it right away)
	if (out_desc == 0) begin
		$display("Error: Failed to read y_gold!");
		$finish;
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
			$finish;
		end
		@(negedge clk);
	end
	total_cycles = total_cycles + cycles; 
end endtask

task check_ans; begin
    while (out_valid === 1) begin
		$strobe("out = %h, out_gold = %h, div1_out_abs = %h = %.6f", out, out_gold, div1_out_abs, $bitstoshortreal(div1_out_abs));
		if (out !== out_gold && !under_tolerance) begin // Fail, if abs(out_gold - out) / out_gold > 0.0001
			$display("--------------------------------------------------------------------------------------------------------------------------------------------");
			$display("                                                                   FAIL! WRONG OUTPUT!                                                      ");
			$display("                                                           Pattern NO.%1d Epoch NO.%1d Data NO.%1d                                          ", patcount, i, j);
			$display("	                                                 y_pred = %.6f, y_gold = %.6f                                                             ", $bitstoshortreal(out), $bitstoshortreal(out_gold));
			$display("	                                                 y_pred = %h, y_gold = %h                                                                 ", out, out_gold);
			$display("	                                             Error b/w golden = %.4f > tolerance = %.4f                                                   ", $bitstoshortreal(div1_out_abs), TOLERANCE);
			$display("--------------------------------------------------------------------------------------------------------------------------------------------");
			@(negedge clk);
			$finish;
		end
		@(negedge clk);
    end
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
