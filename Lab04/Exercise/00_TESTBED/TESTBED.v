`timescale 1ns/1ps
`include "PATTERN.v"
`ifdef RTL
	`include "NN.v"
`elsif GATE
	`include "../02_SYN/Netlist/NN_SYN.v"
`endif

//synopsys translate_off
`include "DW_fp_mac.v"
`include "DW_fp_mult.v"
`include "DW_fp_sub.v"
`include "DW_fp_sum3.v"
`include "DW_fp_cmp.v"

`include "DW_fp_div.v"

// synopsys translate_on

module TESTBED();
	parameter inst_sig_width = 23;
	parameter inst_exp_width = 8;
	parameter inst_ieee_compliance = 0;
	parameter inst_arch = 2;

	// Training parameters
	parameter EPOCH_MAX     = 24; // 25 epochs
	parameter EPOCH_WIDTH   = $clog2(EPOCH_MAX); 
	parameter DATASET_MAX   = 99; // 100 data points for training
	parameter DATASET_WIDTH = $clog2(DATASET_MAX); // 100 data points for training
	
	wire clk, rst_n, in_valid_d, in_valid_t, in_valid_w1, in_valid_w2;
	wire [EPOCH_WIDTH-1:0]   epoch;
	wire [DATASET_WIDTH-1:0] dataset_index; // index for dataset: 0 ~ 99
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
	.epoch(epoch),
	.dataset_index(dataset_index),
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
	.epoch(epoch),
	.dataset_index(dataset_index),
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
