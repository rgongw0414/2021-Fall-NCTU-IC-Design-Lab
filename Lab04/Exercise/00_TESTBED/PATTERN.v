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
parameter inst_sig_width = 23;
parameter inst_exp_width = 8;
parameter inst_ieee_compliance = 0;
parameter inst_arch = 2;

// Testbench parameters
parameter PATTERN_NUM = 250;
parameter INPUT_DIM   = 4;
parameter HIDDEN_DIM  = 3;
parameter INITIAL_LR  = 0.000001;
parameter EPOCHS      = 25;
parameter DATA_SIZE   = 100;
parameter CYCLE_LIMIT = 300;

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
wire [inst_sig_width+inst_exp_width:0] out_abs_diff;
reg  [inst_sig_width+inst_exp_width:0] out_gold;
assign out_abs_diff = ((out_gold - out) / out_gold > 0) ? (out_gold - out) / out_gold : (out - out_gold) / out_gold;

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
	rst_n    = 1'b1;	
	force clk    = 0;
	total_cycles = 0;
	reset_task;
	
	input_file  = $fopen("../00_TESTBED/input_ignore.txt","r");
	target_file = $fopen("../00_TESTBED/target_ignore.txt","r");
	weight1_file = $fopen("../00_TESTBED/weight1_ignore.txt","r");
	weight2_file = $fopen("../00_TESTBED/weight2_ignore.txt","r");
  	output_file = $fopen("../00_TESTBED/output_ignore.txt","r");
	if (input_file == 0) begin
		$display("Error: Cannot open input file!");
		$finish;
	end
	if (target_file == 0) begin
		$display("Error: Cannot open target file!");
		$finish;
	end
	if (weight1_file == 0) begin
		$display("Error: Cannot open weight1 file!");
		$finish;
	end
	if (weight2_file == 0) begin
		$display("Error: Cannot open weight2 file!");
		$finish;
	end
	if (output_file == 0) begin
		$display("Error: Cannot open output file!");
		$finish;
	end
    @(negedge clk);

	for (patcount = 1; patcount <= PATTERN_NUM; patcount = patcount + 1) begin
		weights_task;
		for (i = 0; i < EPOCHS; i = i + 1) begin // epoch_0 ~ epoch_24
			for (j = 0; j < DATA_SIZE; j = j + 1) begin // data_0 ~ data_99
				input_data; // read input data and target data
				wait_out_valid;
				check_ans;
			end
		end
		$display("\033[0;34mPASS PATTERN NO.%4d,\033[m \033[0;32m Cycles: %3d\033[m", patcount, cycles);
	end
	#(1000);
	YOU_PASS_task;
	$finish;
end

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
	gap = 2;
	repeat(gap)@(negedge clk);
	in_valid_w1 = 'b1;
	in_valid_w2 = 'b1;
	for (i = 0; i < INPUT_DIM*HIDDEN_DIM; i = i + 1) begin
		weight1_desc = $fscanf(weight1_file, "%h", weight1);
		if (weight1_desc == 0) begin
			$display("Error: Failed to read weight input data!");
			$finish;
		end
		if (i < HIDDEN_DIM) begin
			weight2_desc = $fscanf(weight2_file, "%h", weight2);
			if (weight2_desc == 0) begin
				$display("Error: Failed to read weight input data!");
				$finish;
			end
		end
		else if (i == HIDDEN_DIM) begin
			in_valid_w2 = 'b0;
		end
		@(negedge clk);
	end
	in_valid_w1 = 'b0;
	weight1 = 'bx;
	weight2 = 'bx;
end endtask

task input_data; begin
	gap = 2;
	repeat(gap)@(negedge clk);
	in_valid_d = 'b1;
	in_valid_t = 'b1;
	for (i = 0; i < INPUT_DIM; i = i + 1) begin
		in_desc = $fscanf(input_file, "%h", data_point);
		if (in_desc == 0) begin
			$display("Error: Failed to read maze input data!");
			$finish;
		end

		if (i == 1) begin
			in_valid_t = 'b0;
		end
		else begin
			target_desc  = $fscanf(target_file, "%h", target);
			if (target_desc == 0) begin
				$display("Error: Failed to read target input data!");
				$finish;
			end
		end
		@(negedge clk);
	end
	in_valid_d = 'b0;
	in_valid_t = 'b0;
	data_point = 'bx;
	target = 'bx;
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
		out_desc = $fscanf(output_file, "%d", out_gold);
		if (out_desc == 0) begin
			$display("Error: Failed to read maze output golden_step_num!");
			$finish;
		end
		if (out_abs_diff >= 0.0001) begin // Fail, if abs(out_gold - out) / out_gold > 0.0001
			$display("--------------------------------------------------------------------------------------------------------------------------------------------");
			$display("                                                                   FAIL! WRONG OUTPUT!                                                      ");
			$display("                                                                     Pattern NO.%03d                                                        ", patcount);
			$display("	                                                               y_pred = %f, y_gold = %f                                                   ", out, out_gold);
			$display("	                                                                  out_abs_diff = %f                                                       ", out_abs_diff);
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
