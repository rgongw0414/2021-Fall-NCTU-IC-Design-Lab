//synopsys translate_off
// `include "/usr/cad/synopsys/synthesis/cur/dw/sim_ver/DW_fp_mac.v"
// `include "/usr/cad/synopsys/synthesis/cur/dw/sim_ver/DW_fp_mult.v"
// `include "/usr/cad/synopsys/synthesis/cur/dw/sim_ver/DW_fp_sub.v"
// `include "/usr/cad/synopsys/synthesis/cur/dw/sim_ver/DW_fp_sum3.v"
// `include "/usr/cad/synopsys/synthesis/cur/dw/sim_ver/DW_fp_cmp.v"
// synopsys translate_on

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
// Weight1, Weight2, Data_point, Target parameters
localparam WEIGHT1_SIZE  = 12; // weight1_0 to weight1_11, where {weight1_0, weight1_1, weight1_2, weight1_3} is for h^1_0; {weight1_4, weight1_5, weight1_6, weight1_7} is for h^1_1; {weight1_8, weight1_9, weight1_10, weight1_11} is for h^1_2
localparam WEIGHT1_WIDTH = $clog2(WEIGHT1_SIZE); // 12 weights for weight1
localparam WEIGHT2_SIZE  = 3; // {weight2_0, weight2_1, weight2_2} for h^2_0 = y^2_0
localparam WEIGHT2_WIDTH = $clog2(WEIGHT2_SIZE); // 3 weights for weight2
localparam INPUT_DIM     = 4; // Input layer contains 4 neuron: 4 data for data_point
localparam INPUT_WIDTH   = $clog2(INPUT_DIM); 
localparam TARGET_DIM    = 1; // Output layer contains 1 neuron
localparam TARGET_WIDTH  = $clog2(TARGET_DIM); 

// IEEE floating point paramenters
localparam inst_sig_width       = 23;
localparam inst_exp_width       = 8;
localparam inst_ieee_compliance = 0;
localparam inst_arch            = 2;

// FSM parameters
localparam FSM_SIZE    = 3; // 3 states: S_RESET, S_INPUT, S_CALCULATE
localparam FSM_WIDTH   = $clog2(FSM_SIZE); // 3 states: S_RESET, S_INPUT, S_CALCULATE
localparam S_RESET     = 0;
localparam S_INPUT     = 1;
localparam S_CALCULATE = 2; // forward, backward, update while epoch < 25; go to S_INPUT to get new weights when epoch >= 25

localparam EPOCH_MAX   = 25;
localparam EPOCH_WIDTH = $clog2(EPOCH_MAX); // 25 epochs
localparam CNT_MAX     = 7;
localparam CNT_WIDTH   = $clog2(CNT_MAX); // Each forward/backward/update takes 7 cycles, cnt_max = 7

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
// registers for weight1, weight2, data_point, target
reg  [inst_sig_width+inst_exp_width:0] weight1_r   [WEIGHT1_WIDTH-1:0], weight2_r [WEIGHT2_WIDTH-1:0]; // stores the 12 weights for weight1 and 3 weights for weight2
reg  [inst_sig_width+inst_exp_width:0] data_point_r[INPUT_WIDTH-1:0],   target_r  [TARGET_WIDTH-1:0];  // stores the 4 data for data_point and 1 data for target
reg  [WEIGHT1_WIDTH-1:0] idx; // index for storing the given data into arrays

// DW_fp_mac parameters
reg  [inst_sig_width+inst_exp_width:0] mac1_a, mac1_b, mac1_c, mac2_a, mac2_b, mac2_c, mac3_a, mac3_b, mac3_c;
wire [inst_sig_width+inst_exp_width:0] mac1_out, mac2_out, mac3_out, mac1_status, mac2_status, mac3_status;

// DW_fp_mult parameters
reg  [inst_sig_width+inst_exp_width:0] mult1_a, mult1_b, mult2_a, mult2_b, mult3_a, mult3_b, mult4_a, mult4_b;
wire [inst_sig_width+inst_exp_width:0] mult1_out, mult2_out, mult3_out, mult4_out, mult1_status, mult2_status, mult3_status, mult4_status;

// DW_fp_sub parameters
reg  [inst_sig_width+inst_exp_width:0] sub1_a, sub1_b, sub2_a, sub2_b, sub3_a, sub3_b;
wire [inst_sig_width+inst_exp_width:0] sub1_out, sub2_out, sub3_out, sub1_status, sub2_status, sub3_status;

// DW_fp_sum3 parameters
reg  [inst_sig_width+inst_exp_width:0] sum3_a, sum3_b, sum3_c;
wire [inst_sig_width+inst_exp_width:0] sum3_out, sum3_status;

// FSM
reg  [FSM_WIDTH-1:0]   curr_state;
wire [FSM_WIDTH-1:0]   next_state;
reg  [EPOCH_WIDTH-1:0] epoch;
reg  [CNT_WIDTH-1:0]   cnt; // cnt for pipeline stage

//---------------------------------------------------------------------
//   DesignWare
//---------------------------------------------------------------------
// DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC1 (.a(mac1_a), .b(mac1_b), .c(mac1_out), .rnd(3'b000), .z(mac1_out), .status(mac1_status));
// DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC2 (.a(mac2_a), .b(mac2_b), .c(mac2_out), .rnd(3'b000), .z(mac2_out), .status(mac2_status));
// DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC3 (.a(mac3_a), .b(mac3_b), .c(mac3_out), .rnd(3'b000), .z(mac3_out), .status(mac3_status));
// DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL1 (.a(mult1_a), .b(mult1_b), .rnd(3'b000), .z(mult1_out), .status(mult1_status));
// DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL2 (.a(mult2_a), .b(mult2_b), .rnd(3'b000), .z(mult2_out), .status(mult2_status));
// DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL3 (.a(mult3_a), .b(mult3_b), .rnd(3'b000), .z(mult3_out), .status(mult3_status));
// DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL4 (.a(mult4_a), .b(mult4_b), .rnd(3'b000), .z(mult4_out), .status(mult4_status));
// DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB1 (.a(sub1_a), .b(sub1_b), .rnd(3'b000), .z(sub1_out), .status(sub1_status));
// DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB2 (.a(sub2_a), .b(sub2_b), .rnd(3'b000), .z(sub2_out), .status(sub2_status));
// DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB3 (.a(sub3_a), .b(sub3_b), .rnd(3'b000), .z(sub3_out), .status(sub3_status));
// DW_fp_sum3 #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUM3 (.a(sum3_a), .b(sum3_b), .c(sum3_c), .rnd(3'b000), .z(sum3_out), .status(sum3_status));
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

//---------------------------------------------------------------------
// Always block
//---------------------------------------------------------------------

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out <= 0;
		out_valid <= 0;
	end
end

//------------------------------------------
// FSM
//------------------------------------------
// always @(posedge clk or negedge rst_n) begin
// 	if (!rst_n) begin
// 		curr_state <= S_RESET;
// 	end else begin
// 		curr_state <= next_state;
// 	end
// end

// always @(*) begin
// 	case (curr_state)
// 		S_RESET: begin
// 			if (in_valid_w1 || in_valid_d) begin
// 				next_state = S_INPUT;
// 			end 
// 			else begin
// 				next_state = S_RESET;
// 			end
// 		end
// 		S_INPUT: begin
// 			if (cnt == CNT_MAX) begin
// 				next_state = S_CALCULATE;
// 			end 
// 			else begin
// 				next_state = S_INPUT;
// 			end
// 		end
// 		S_CALCULATE: begin
// 			if (epoch == EPOCH_MAX) begin
// 				next_state = S_INPUT;
// 			end 
// 			else begin
// 				next_state = S_CALCULATE;
// 			end
// 		end
// 		default: next_state = S_RESET;
// 	endcase
// end

endmodule
