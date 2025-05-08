`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
	`include "NN.v"
`elsif GATE
	`include "../02_SYN/Netlist/NN_SYN.v"
`endif

module TESTBED();
	parameter inst_sig_width = 23;
	parameter inst_exp_width = 8;
	parameter inst_ieee_compliance = 0;
	parameter inst_arch = 2;
	
	wire clk, rst_n, in_valid_d, in_valid_t, in_valid_w1, in_valid_w2;
	wire [inst_sig_width+inst_exp_width:0] data_point, target;
	wire [inst_sig_width+inst_exp_width:0] weight1, weight2;
	wire out_valid;
	wire [inst_sig_width+inst_exp_width:0] out;	

initial begin
	`ifdef RTL
		$fsdbDumpfile("NN.fsdb");
		$fsdbDumpvars(0, "+mda");
	`elsif GATE
		$fsdbDumpfile("NN_SYN.fsdb");
		$sdf_annotate("../02_SYN/Netlist/NN_SYN.sdf", I_NN);      
		$fsdbDumpvars(0, "+mda");
	`endif
end

NN I_NN
(
	// Input signals
	.clk(clk),
	.rst_n(rst_n),
	.in_valid_d(in_valid_d),
	.in_valid_t(in_valid_t),
	.in_valid_w1(in_valid_w1),
	.in_valid_w2(in_valid_w2),
	.data_point(data_point),
	.target(target),
	.weight1(weight1),
	.weight2(weight2),
	// Output signals
	.out_valid(out_valid),
	.out(out)
);


PATTERN I_PATTERN
(
	// Input signals
	.clk(clk),
	.rst_n(rst_n),
	.in_valid_d(in_valid_d),
	.in_valid_t(in_valid_t),
	.in_valid_w1(in_valid_w1),
	.in_valid_w2(in_valid_w2),
	.data_point(data_point),
	.target(target),
	.weight1(weight1),
	.weight2(weight2),
	// Output signals
	.out_valid(out_valid),
	.out(out)
);

endmodule
