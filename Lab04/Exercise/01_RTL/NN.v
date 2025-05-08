
module NN(
	// Input signals
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
	// Output signals
	out_valid,
	out
);

//---------------------------------------------------------------------
//   PARAMETER
//---------------------------------------------------------------------

// IEEE floating point paramenters
parameter inst_sig_width = 23;
parameter inst_exp_width = 8;
parameter inst_ieee_compliance = 0;
parameter inst_arch = 2;

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input  clk, rst_n, in_valid_d, in_valid_t, in_valid_w1, in_valid_w2;
input [inst_sig_width+inst_exp_width:0] data_point, target;
input [inst_sig_width+inst_exp_width:0] weight1, weight2;
output reg	out_valid;
output reg [inst_sig_width+inst_exp_width:0] out;

//---------------------------------------------------------------------
//   WIRE AND REG DECLARATION
//---------------------------------------------------------------------
// DW_fp_mac parameters
reg  [inst_sig_width+inst_exp_width:0] mac1_a, mac1_b, mac1_c, mac2_a, mac2_b, mac2_c, mac3_a, mac3_b, mac3_c;
wire [inst_sig_width+inst_exp_width:0] mac1_out, mac2_out, mac3_out;

// DW_fp_mult parameters
reg  [inst_sig_width+inst_exp_width:0] mult1_a, mult1_b, mult2_a, mult2_b, mult3_a, mult3_b;
wire [inst_sig_width+inst_exp_width:0] mult1_out, mult2_out, mult3_out, mult4_out;

// DW_fp_sub parameters
reg  [inst_sig_width+inst_exp_width:0] sub1_a, sub1_b, sub2_a, sub2_b, sub3_a, sub3_b;
wire [inst_sig_width+inst_exp_width:0] sub1_out, sub2_out, sub3_out;

// DW_fp_sum3 parameters
reg  [inst_sig_width+inst_exp_width:0] sum3_a, sum3_b, sum3_c;
wire [inst_sig_width+inst_exp_width:0] sum3_out;

//---------------------------------------------------------------------
//   DesignWare
//---------------------------------------------------------------------
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC1 (.a(add_a), .b(mult_out), .c(0), .rnd(3'b000), .z(add_out));
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC2 (.a(add_a), .b(mult_out), .c(0), .rnd(3'b000), .z(add_out));
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC3 (.a(add_a), .b(mult_out), .c(0), .rnd(3'b000), .z(add_out));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL1 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL2 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL3 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL4 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB1 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB2 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB3 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_sum3 #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUM3 (.a(mult_a), .b(mult_b), .c(0), .rnd(3'b000), .z(mult_out));
// DW_fp_cmp  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) CMP1 (.a(mult_a), .b(mult_b), .eq(mult_out), .lt(mult_out), .gt(mult_out));

//---------------------------------------------------------------------
//  MODULE DECLARATION
//---------------------------------------------------------------------

// synopsys dc_script_begin
//
// set_implementation rtl DW_fp_mac
// set_implementation rtl DW_fp_mult
// set_implementation rtl DW_fp_sub
// set_implementation rtl DW_fp_sum3
// set_implementation rtl DW_fp_cmp
//
// synopsys dc_script_end

endmodule
