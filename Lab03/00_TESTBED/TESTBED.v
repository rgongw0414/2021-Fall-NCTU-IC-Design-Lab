
//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory OASIS
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   2021 ICLAB fall Course
//   Lab02			: Sequential circuit Knight's Tour
//   Author         : Echin-Wang (echinwang861025@gmail.com)
//
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : TESTBED.sv
//   Module Name : TESTBED
//   Release version : v1.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`include "PATTERN.v"

module TESTBED();

wire clk;
wire rst_n;

wire in_valid, out_valid;
wire in;
wire [1:0] out;


MAZE U_MAZE(
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in(in),
	.out_valid(out_valid),
	.out(out)
);

PATTERN U_PATTERN(
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in(in),
	.out_valid(out_valid),
	.out(out)
);

initial begin
	`ifdef RTL
		// $dumpfile("tb.vcd");         // Name of the VCD file to be generated
  		// $dumpvars(0, TESTBED);            // Dump all variables in the testbench hierarchy 'tb'
		$fsdbDumpfile("MAZE.fsdb");
		$fsdbDumpvars(0, "+mda");
	`endif
	`ifdef GATE
		$sdf_annotate("../02_SYN/Netlist/MAZE_SYN.sdf", U_MAZE);
		$fsdbDumpfile("MAZE_SYN.fsdb");
		$fsdbDumpvars();
	`endif
end

endmodule
