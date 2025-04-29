//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory OASIS
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : PATTERN.v
//   Module Name : PATTERN
//   Release version : v1.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################
`ifdef RTL
	`timescale 1ns/10ps
	`include "MAZE.v"
	`define CYCLE_TIME 10.0
`endif
`ifdef GATE
	`timescale 1ns/10ps
	`include "MAZE_SYN.v"
	`define CYCLE_TIME 10.0
`endif

module PATTERN(
   clk,
   rst_n,
   in_valid,
   in,
   out_valid,
   out
);

output reg clk, rst_n, in_valid;
output reg in;
input out_valid;
input [1:0] out;

//================================================================
// wires & registers
//================================================================

reg [288:0] maze;
// reg [8:0] golden_step_num;
// reg [1:0] golden_out, prev_out; // 0: >, 1: v, 2: <, 3: ^
// reg [289*3:0] golden_all_out;
reg [4:0] curr_x, curr_y;
//================================================================
// parameters & integer
//================================================================

integer total_cycles;
integer patcount;
integer cycles;
integer in_desc, out_desc, i, input_file, output_file;
integer gap;

parameter PATNUM=500;
// parameter PATNUM=10000;
parameter cycle_limit=3000;
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
	in_valid = 1'b0;
	in       =  'dx;
	
	force clk    = 0;
	total_cycles = 0;
	reset_task;
	
	input_file=$fopen("../00_TESTBED/input_ignore.txt","r");
  	// output_file=$fopen("../00_TESTBED/output_ignore.txt","r");
	// input_file=$fopen("../00_TESTBED/input.txt","r");
  	// output_file=$fopen("../00_TESTBED/output.txt","r");
	if (input_file == 0) begin
		$display("Error: Cannot open input file!");
		$finish;
	end
	// if (output_file == 0) begin
	// 	$display("Error: Cannot open output file!");
	// 	$finish;
	// end
    @(negedge clk);

	for (patcount = 0; patcount < PATNUM; patcount = patcount + 1) begin
		input_data;
		wait_out_valid;
		check_ans;
		$display("\033[0;34mPASS PATTERN NO.%4d,\033[m \033[0;32m Cycles: %3d\033[m", patcount ,cycles);
	end
	#(1000);
	YOU_PASS_task;
	$finish;
end

task reset_task; 
	#(10); rst_n = 0;
	#(10);
	if ((out !== 0) || (out_valid !== 0)) begin
		$display("--------------------------------------------------------------------------------------------------------------------------------------------");
		$display("                                                                        FAIL!                                                               ");
		$display("                                                  Output signal should be 0 after initial RESET at %8t                                      ", $time);
		$display("--------------------------------------------------------------------------------------------------------------------------------------------");
		#(100);
	    $finish ;
	end
	#(10);  rst_n = 1 ;
	#(3.0); release clk;
endtask

task input_data; 
	gap = $urandom_range(2, 4);
	repeat(gap)@(negedge clk);
	in_valid = 'b1;
	in_desc  = $fscanf(input_file, "%b", maze);
	if (in_desc == 0) begin
		$display("Error: Failed to read maze input data!");
		$finish;
	end
	for (i = 0; i < 17*17; i = i + 1) begin
		in = maze[288 - i];
		@(negedge clk);
	end
	in_valid = 'b0;
	in       = 'bx; 
endtask

task wait_out_valid; 
	cycles = 0;
	while (out_valid === 0) begin
		cycles = cycles + 1;
		if (cycles == cycle_limit) begin
			display("--------------------------------------------------------------------------------------------------------------------------------------------");
			display("                                                                                                                                            ");
			display("                                                     The execution latency are over %2d cycles                                              ", cycle_limit);
			display("                                                                                                                                            ");
			display("--------------------------------------------------------------------------------------------------------------------------------------------");
			repeat(2)@(negedge clk);
			$finish;
		end
		@(negedge clk);
	end
	total_cycles = total_cycles + cycles; 
endtask

task check_ans; 
	// out_desc = $fscanf(output_file, "%d", golden_step_num);
	// if (out_desc == 0) begin
	// 	$display("Error: Failed to read maze output golden_step_num!");
	// 	$finish;
	// end
	curr_x = 0; curr_y = 0;
	i = 0;
    while (out_valid === 1) begin
		// out_desc = $fscanf(output_file, "%d", golden_out);
		// if (out_desc == 0) begin
		// 	$display("Error: Failed to read maze output golden_out!");
		// 	$finish;
		// end
		// golden_all_out[i*2 +: 2] = golden_out;
		if      (out === 0) curr_y = curr_y + 1;
		else if (out === 1) curr_x = curr_x + 1;
		else if (out === 2) curr_y = curr_y - 1;
		else if (out === 3) curr_x = curr_x - 1;
		if (maze[288 - (curr_x*17+curr_y)] === 0) begin // Hit Wall Detection
			display("--------------------------------------------------------------------------------------------------------------------------------------------");
			display("                                                                   FAIL! YOU HIT WALL!                                                      ");
			display("                                                                     Pattern NO.%03d                                                        ", patcount);
			display("                                                        (curr_x, curr_y) = (%2d,%2d), step = %3d                                            ", curr_x, curr_y, i);
			display("--------------------------------------------------------------------------------------------------------------------------------------------");
			@(negedge clk);
			$finish;
		end
		i = i + 1;
		@(negedge clk);
    end
	if (!(curr_x === 16 && curr_y == 16)) begin // Walk teminated, but not at (16, 16)
		display("--------------------------------------------------------------------------------------------------------------------------------------------");
		display("                                                                         FAIL!                                                              ");
		display("                                                                   Pattern NO.%03d                                                          ", patcount);
		display("	                                             Output position should be (16, 16) instead of (%d, %d)                                      ", curr_x, curr_y);
		display("--------------------------------------------------------------------------------------------------------------------------------------------");
		@(negedge clk);
		$finish;
	end
endtask

task YOU_PASS_task;
	display("----------------------------------------------------------------------------------------------------------------------");
	display("                                                  Congratulations!                						               ");
	display("                                           You have passed all patterns!          						               ");
	display("                                           Your execution cycles = %5d cycles   						               ", total_cycles);
	display("                                           Your clock period = %.1f ns        					                       ", `CYCLE_TIME);
	display("                                           Your total latency = %.1f ns         						               ", total_cycles*`CYCLE_TIME);
	display("----------------------------------------------------------------------------------------------------------------------");
	$finish;
endtask
endmodule