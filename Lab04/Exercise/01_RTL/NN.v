//synopsys translate_off
`include "DW_fp_mac.v"
`include "DW_fp_mult.v"
`include "DW_fp_sub.v"
`include "DW_fp_sum3.v"
`include "DW_fp_cmp.v"
// synopsys translate_on

// `define DW_SUPPRESS_WARN

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
localparam WEIGHT1_SIZE  = 12; // w^1_0 to w^1_11, where {w^1_0, w^1_1, w^1_2, w^1_3} is for h^1_0; {w^1_4, w^1_5, w^1_6, w^1_7} is for h^1_1; {w^1_8, w^1_9, w^1_10, w^1_11} is for h^1_2
localparam WEIGHT1_WIDTH = $clog2(WEIGHT1_SIZE); // 12 weights for weight1
localparam WEIGHT2_SIZE  = 3; // {w^2_0, w^2_1, w^2_2} for h^2_0 = y^2_0
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

// ANN parameters
localparam EPOCH_MAX   = 24; // 25 epochs
localparam EPOCH_WIDTH = $clog2(EPOCH_MAX); 

// Pipeline parameters
localparam CNT_MAX     = 7;  // Each forward/backward/update takes 7 cycles, cnt_max = 7
localparam CNT_WIDTH   = $clog2(CNT_MAX); 
localparam FP_ZERO     = {inst_exp_width+inst_sig_width+1{1'b0}}; // 0.0 in IEEE 754 format 
localparam LR_SIZE      = 7; // 7 learning rates for every 4 epochs


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
wire [inst_sig_width+inst_exp_width:0] LR;
reg  [$clog2(LR_SIZE)-1:0] LR_index; // index for learning rate
reg update_en; // enable signal for update

//------------------------
// Registers for Pipeline
//------------------------
reg [inst_sig_width+inst_exp_width:0] LRs0, LRs1, LRs2, LRs3, LRdelta2; // LR*s0, LR*s1, LR*s2, LR*s3, LR*delta2
reg [inst_sig_width+inst_exp_width:0] y0, y1, y2; // y^1_0, y^1_1, y^1_2
reg [inst_sig_width+inst_exp_width:0] delta10, delta11, delta12; // delta^1_0, delta^1_1, delta^1_2
reg [inst_sig_width+inst_exp_width:0] delta2; // delta2 = y_pred - target

// registers for weight1, weight2, data_point, target
// reg [inst_sig_width+inst_exp_width:0] weight1_arr  [WEIGHT1_WIDTH-1:0], weight2_arr [WEIGHT2_WIDTH-1:0]; // stores the 12 weights for weight1 and 3 weights for weight2
reg [inst_sig_width+inst_exp_width:0] w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11; // stores the 12 weights for weight1
reg [inst_sig_width+inst_exp_width:0] w20, w21, w22; // stores the 3 weights for weight2

// reg [inst_sig_width+inst_exp_width:0] data_point_r [INPUT_WIDTH-1:0],     target_r  [TARGET_WIDTH-1:0];  // stores the 4 data for data_point and 1 data for target
reg [inst_sig_width+inst_exp_width:0] s0, s1, s2, s3; // stores the 4 data for data_point
reg [inst_sig_width+inst_exp_width:0] target_r; // stores the 1 data for target


// DW_fp_mac parameters
reg  [inst_sig_width+inst_exp_width:0] mac1_a, mac1_b, mac1_c, mac2_a, mac2_b, mac2_c, mac3_a, mac3_b, mac3_c;
wire [inst_sig_width+inst_exp_width:0] mac1_out, mac2_out, mac3_out;

// DW_fp_mult parameters
reg  [inst_sig_width+inst_exp_width:0] mult1_a, mult1_b, mult2_a, mult2_b, mult3_a, mult3_b, mult4_a, mult4_b;
wire [inst_sig_width+inst_exp_width:0] mult1_out, mult2_out, mult3_out, mult4_out;

// DW_fp_sub parameters
reg  [inst_sig_width+inst_exp_width:0] sub1_a, sub1_b, sub2_a, sub2_b, sub3_a, sub3_b;
wire [inst_sig_width+inst_exp_width:0] sub1_out, sub2_out, sub3_out;
reg  [inst_sig_width+inst_exp_width:0] sub1_out_r, sub2_out_r, sub3_out_r;

// DW_fp_sum3 parameters
reg  [inst_sig_width+inst_exp_width:0] sum1_a, sum1_b, sum1_c;
wire [inst_sig_width+inst_exp_width:0] sum1_out;
reg  [inst_sig_width+inst_exp_width:0] sum1_out_r;

// DW_fp_cmp parameters
wire h0_is_pos, h1_is_pos, h2_is_pos; // flag for checking if h^1_i is positive or negative

// FSM
reg [FSM_WIDTH-1:0]   curr_state, next_state;
reg [EPOCH_WIDTH-1:0] epoch;
reg [CNT_WIDTH-1:0]   cnt; // cnt for pipeline stage

//---------------------------------------------------------------------
//   DesignWare
//---------------------------------------------------------------------
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC1 (.a(mac1_a), .b(mac1_b), .c(mac1_c), .rnd(3'b000), .z(mac1_out), .status());
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC2 (.a(mac2_a), .b(mac2_b), .c(mac2_c), .rnd(3'b000), .z(mac2_out), .status());
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC3 (.a(mac3_a), .b(mac3_b), .c(mac3_c), .rnd(3'b000), .z(mac3_out), .status());
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL1 (.a(mult1_a), .b(mult1_b), .rnd(3'b000), .z(mult1_out), .status());
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL2 (.a(mult2_a), .b(mult2_b), .rnd(3'b000), .z(mult2_out), .status());
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL3 (.a(mult3_a), .b(mult3_b), .rnd(3'b000), .z(mult3_out), .status());
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL4 (.a(mult4_a), .b(mult4_b), .rnd(3'b000), .z(mult4_out), .status());
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB1 (.a(sub1_a), .b(sub1_b), .rnd(3'b000), .z(sub1_out), .status());
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB2 (.a(sub2_a), .b(sub2_b), .rnd(3'b000), .z(sub2_out), .status());
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB3 (.a(sub3_a), .b(sub3_b), .rnd(3'b000), .z(sub3_out), .status());
DW_fp_sum3 #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUM1 (.a(sum1_a), .b(sum1_b), .c(sum1_c), .rnd(3'b000), .z(sum1_out), .status());

// compare mac1_out, mac2_out, mac3_out with 0.0 to check if they are positive or negative
DW_fp_cmp #(inst_sig_width, inst_exp_width, inst_ieee_compliance)  CMP1 (.a(mac1_out), .b(FP_ZERO), .altb(), .agtb(h0_is_pos), .aeqb(), .unordered(), .z0(), .z1(), .status0(), .status1(), .zctr(1'b0));
DW_fp_cmp #(inst_sig_width, inst_exp_width, inst_ieee_compliance)  CMP2 (.a(mac2_out), .b(FP_ZERO), .altb(), .agtb(h1_is_pos), .aeqb(), .unordered(), .z0(), .z1(), .status0(), .status1(), .zctr(1'b0));
DW_fp_cmp #(inst_sig_width, inst_exp_width, inst_ieee_compliance)  CMP3 (.a(mac3_out), .b(FP_ZERO), .altb(), .agtb(h2_is_pos), .aeqb(), .unordered(), .z0(), .z1(), .status0(), .status1(), .zctr(1'b0));

// synopsys dc_script_begin
//
// set_implementation rtl DW_fp_mac
// set_implementation rtl DW_fp_mult
// set_implementation rtl DW_fp_sub
// set_implementation rtl DW_fp_sum3
// set_implementation rtl DW_fp_cmp
//
// synopsys dc_script_end

//----------------------------------------------------------------------
// Module declaration 
//---------------------------------------------------------------------
CURRENT_LR #(.inst_sig_width(inst_sig_width), .inst_exp_width(inst_exp_width), .LR_SIZE(LR_SIZE)) CURR_LR (.rst_n(rst_n), .LR_index(LR_index), .LR(LR));

//---------------------------------------------------------------------
// Assignments
//---------------------------------------------------------------------
// assign mult4_a = LR;

//---------------------------------------------------------------------
// Always block
//---------------------------------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		update_en <= 0;
	end
	else if (curr_state == S_CALCULATE && cnt == 6) begin
		update_en <= 1;
	end
end

// Increase LR_index every 4 epochs
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		LR_index <= 0;
	end
	else if (curr_state == S_CALCULATE && cnt == 6) begin
		if (epoch == EPOCH_MAX) begin
			LR_index <= 0;
		end 
		else if (epoch % 4 == 0 && epoch > 0) begin
			LR_index <= LR_index + 1;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		w0 <= 0;
		w1 <= 0;
		w2 <= 0;
		w3 <= 0;
		w4 <= 0;
		w5 <= 0;
		w6 <= 0;
		w7 <= 0;
		w8 <= 0;
		w9 <= 0;
		w10 <= 0;
		w11 <= 0;
	end
	else if (in_valid_w1) begin
		w0 <= w1; // w^1_0
		w1 <= w2; // w^1_1
		w2 <= w3; // w^1_2
		w3 <= w4; // w^1_3
		w4 <= w5; // w^1_4
		w5 <= w6; // w^1_5
		w6 <= w7; // w^1_6
		w7 <= w8; // w^1_7
		w8 <= w9; // w^1_8
		w9 <= w10; // w^1_9
		w10 <= w11; // w^1_10
		w11 <= weight1; // w^1_11
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		w20 <= 0;
		w21 <= 0;
		w22 <= 0;
	end
	else if (in_valid_w2) begin
		w20 <= w21; // w^2_0
		w21 <= w22; // w^2_1
		w22 <= weight2; // w^2_2
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		s0 <= 0;
		s1 <= 0;
		s2 <= 0;
		s3 <= 0;
	end
	else if (in_valid_d) begin
		s0 <= s1; // s^1_0
		s1 <= s2; // s^1_1
		s2 <= s3; // s^1_2
		s3 <= data_point; // s^1_3
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		target_r <= 0;
	end
	else if (in_valid_t) begin
		target_r <= target; // y^2_0
	end
end

// MACs inputs (a, b, c) for forward propagation
always@(posedge clk or negedge rst_n) begin 
	if (!rst_n) begin
		mac1_a <= 0;
		mac1_b <= 0;
		mac1_c <= 0;
		mac2_a <= 0;
		mac2_b <= 0;
		mac2_c <= 0;
		mac3_a <= 0;
		mac3_b <= 0;
		mac3_c <= 0;
	end
	else begin
		case (curr_state) 
			S_INPUT: begin
				if (next_state == S_CALCULATE) begin
					mac1_a <= s0; // s^1_0
					mac1_b <= w0; // w^1_0
					mac1_c <= 0; // MAC1 output register
					mac2_a <= s0; 
					mac2_b <= w4; // w^1_4
					mac2_c <= 0; // MAC2 output register
					mac3_a <= s0; 
					mac3_b <= w8; // w^1_8
					mac3_c <= 0; // MAC3 output register
				end
			end
			S_CALCULATE: begin
				case (cnt)
					1: begin
						mac1_a <= s1; // s^1_0
						mac1_b <= w1; // w^1_0
						mac1_c <= mac1_out;
						mac2_a <= s1; // s^1_1
						mac2_b <= w5; // w^1_5
						mac2_c <= mac2_out;
						mac3_a <= s1; // s^1_2
						mac3_b <= w9; // w^1_9
						mac3_c <= mac3_out;
					end
					2: begin
						mac1_a <= s2; // s^1_1
						mac1_b <= w2; // w^1_4
						mac1_c <= mac1_out; 
						mac2_a <= s2; // s^1_2
						mac2_b <= w6; // w^1_5
						mac2_c <= mac2_out; 
						mac3_a <= s2; // s^1_2
						mac3_b <= w10; // w^1_10
						mac3_c <= mac3_out;
					end
					3: begin
						mac1_a <= s3; // s^1_2
						mac1_b <= w3; // w^1_8
						mac1_c <= mac1_out;
						mac2_a <= s3; // s^1_3
						mac2_b <= w7; // w^1_9
						mac2_c <= mac2_out; 
						mac3_a <= s3; // s^1_3
						mac3_b <= w11; // w^1_10
						mac3_c <= mac3_out; 
					end
				endcase
			end
		endcase
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		y0 <= 0;
		y1 <= 0;
		y2 <= 0;
	end
	else if (curr_state == S_CALCULATE && cnt == 4) begin
		y0 <= (h0_is_pos) ? mac1_out : FP_ZERO; // y^1_0 = ReLU(h^1_0)
		y1 <= (h1_is_pos) ? mac2_out : FP_ZERO; // y^1_1 = ReLU(h^1_1)
		y2 <= (h2_is_pos) ? mac3_out : FP_ZERO; // y^1_2 = ReLU(h^1_2)
	end
end

// MULs
always@(*) begin
	if (!rst_n) begin
		mult1_a = 0;
		mult1_b = 0;
		mult2_a = 0;
		mult2_b = 0;
		mult3_a = 0;
		mult3_b = 0;
	end
	else begin
		case (curr_state) 
			S_CALCULATE: begin
				case (cnt)
					5: begin
						mult1_a = y0; 
						mult1_b = w20; // w^2_0
						mult2_a = y1;
						mult2_b = w21; // w^2_1
						mult3_a = y2;
						mult3_b = w22; // w^2_2
					end
					6: begin
						mult1_a = delta2; // delta2 = y_pred - target
						mult1_b = w20; // w^2_0
						mult2_a = delta2;
						mult2_b = w21; // w^2_1
						mult3_a = delta2;
						mult3_b = w22; // w^2_2
					end
					7: begin
						mult1_a = delta10; 
						mult1_b = s0; 
						mult2_a = delta11;
						mult2_b = s1; 
						mult3_a = delta12;
						mult3_b = s2; 
					end
					default: begin
						mult1_a = 0;
						mult1_b = 0;
						mult2_a = 0;
						mult2_b = 0;
						mult3_a = 0;
						mult3_b = 0;
					end
				endcase
			end
			default: begin
				mult1_a = 0;
				mult1_b = 0;
				mult2_a = 0;
				mult2_b = 0;
				mult3_a = 0;
				mult3_b = 0;
			end
		endcase
	end
end

always@(*) begin
	if (!rst_n) begin
		mult4_a = 0;
		mult4_b = 0;
	end
	else begin
		case (curr_state) 
			S_CALCULATE: begin
				case (cnt)
					1: begin
						mult4_a = LR; 
						mult4_b = s0; 
					end
					2: begin
						mult4_a = LR;
						mult4_b = s1;
					end
					3: begin
						mult4_a = LR;
						mult4_b = s2;
					end
					4: begin
						mult4_a = LR;
						mult4_b = s3;
					end
					6: begin
						mult4_a = LR;
						mult4_b = delta2; // delta2 = y_pred - target
					end
					default: begin
						mult4_a = 0;
						mult4_b = 0;
					end
				endcase
			end
			default: begin
				mult4_a = 0;
				mult4_b = 0;
			end
		endcase
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		delta2 <= 0;
	end
	else if (curr_state == S_CALCULATE && cnt == 5) begin
		delta2 <= sub1_out; // delta2 = y_pred - target
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		delta10 <= 0; // delta^1_0 = LR*s0*delta^2_0
		delta11 <= 0; // delta^1_1 = LR*s1*delta^2_1
		delta12 <= 0; // delta^1_2 = LR*s2*delta^2_2
	end
	else if (curr_state == S_CALCULATE && cnt == 6) begin
		delta10 <= (h0_is_pos) ? mult1_out : FP_ZERO; // delta^1_0 = LR*s0*delta^2_0
		delta11 <= (h1_is_pos) ? mult2_out : FP_ZERO; // delta^1_1 = LR*s1*delta^2_1
		delta12 <= (h2_is_pos) ? mult3_out : FP_ZERO; // delta^1_2 = LR*s2*delta^2_2
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		LRs0 <= 0; // LR*s0
		LRs1 <= 0; // LR*s1
		LRs2 <= 0; // LR*s2
		LRs3 <= 0; // LR*s3
		LRdelta2 <= 0; // LR*delta2
	end
	else begin
		case (curr_state) 
			S_CALCULATE: begin
				case (cnt)
					1: begin
						LRs0 <= mult4_out;
					end
					2: begin
						LRs1 <= mult4_out;
					end
					3: begin
						LRs2 <= mult4_out;
					end
					4: begin
						LRs3 <= mult4_out;
					end
					6: begin
						LRdelta2 <= mult4_out; 
					end
				endcase
			end
		endcase
	end
end

// assign sum1_a = mult1_out;
// assign sum1_b = mult2_out;
// assign sum1_c = mult3_out;
always@(*) begin
	if (!rst_n) begin
		sum1_a = 0;
		sum1_b = 0;
		sum1_c = 0;
	end
	else begin
		case (curr_state) 
			S_CALCULATE: begin
				case (cnt)
					5: begin // y_pred = w^2_0 * y^1_0 + w^2_1 * y^1_1 + w^2_2 * y^1_2
						sum1_a = mult1_out; // w^2_0 * y^1_0
						sum1_b = mult2_out; // w^2_1 * y^1_1
						sum1_c = mult3_out; // w^2_2 * y^1_2
					end
					default: begin
						sum1_a = 0;
						sum1_b = 0;
						sum1_c = 0;
					end
				endcase
			end
			default: begin
				sum1_a = 0;
				sum1_b = 0;
				sum1_c = 0;
			end
		endcase
	end
end

always@(*) begin
	if (!rst_n) begin
		sub1_a = 0;
		sub1_b = 0;
	end
	else begin
		case (curr_state) 
			S_CALCULATE: begin
				case (cnt)
					5: begin // delta2 = y_pred - target
						sub1_a = sum1_out; // y_pred = w^2_0 * y^1_0 + w^2_1 * y^1_1 + w^2_2 * y^1_2
						sub1_b = target_r; // target = y_gold
					end
					7: begin
						sub1_a = w0; // w^1_0
						sub1_b = mult1_out; // LR * grad = LR * (LR*s0*delta^1_0)
					end
					default: begin
						sub1_a = 0;
						sub1_b = 0;
					end
				endcase
			end
			default: begin
				sub1_a = 0;
				sub1_b = 0;
			end
		endcase
	end
end

always@(*) begin
	if (!rst_n) begin
		sub2_a = 0;
		sub2_b = 0;
		sub3_a = 0;
		sub3_b = 0;
	end
	else begin
		case (curr_state) 
			S_CALCULATE: begin
				case (cnt)
					7: begin
						sub2_a = w4; 
						sub2_b = mult2_out; 
						sub3_a = w8; 
						sub3_b = mult3_out;
					end
					default: begin
						sub2_a = 0;
						sub2_b = 0;
						sub3_a = 0;
						sub3_b = 0;
					end
				endcase
			end
			default: begin
				sub2_a = 0;
				sub2_b = 0;
				sub3_a = 0;
				sub3_b = 0;
			end
		endcase
	end
end

// always@(posedge clk or negedge rst_n) begin
// 	if (!rst_n) begin
// 		sub1_out_r <= 0;
// 		sub2_out_r <= 0;
// 		sub3_out_r <= 0;
// 	end
// 	else begin
// 		sub1_out_r <= sub1_out;
// 		sub2_out_r <= sub2_out;
// 		sub3_out_r <= sub3_out;
// 	end
// end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cnt <= 1;
	end
	else if (curr_state == S_CALCULATE) begin
		if (cnt == CNT_MAX) begin
			cnt <= 1;
		end 
		else begin
			cnt <= cnt + 1;
		end
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out <= 0;
		out_valid <= 0;
	end
	else if (curr_state == S_CALCULATE && cnt == 5) begin
		out <= sum1_out; // y_pred = w^2_0 * y^1_0 + w^2_1 * y^1_1 + w^2_2 * y^1_2
		out_valid <= 1;
	end 
	else begin
		out <= 0;
		out_valid <= 0;
	end
	// else if (curr_state == S_INPUT) begin
	// 	out_valid <= 0;
	// end
end

//------------------------------------------
// FSM
//------------------------------------------
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		curr_state <= S_RESET;
	end else begin
		curr_state <= next_state;
	end
end

always @(*) begin
	case (curr_state)
		S_RESET: begin
			if (in_valid_w1 || in_valid_d) begin
				next_state = S_INPUT;
			end 
			else begin
				next_state = S_RESET;
			end
		end
		S_INPUT: begin
			if (in_valid_d) begin
				next_state = S_CALCULATE;
			end 
			else begin
				next_state = S_INPUT;
			end
		end
		S_CALCULATE: begin
			if (epoch == EPOCH_MAX) begin
				next_state = S_INPUT;
			end 
			else begin
				next_state = S_CALCULATE;
			end
		end
		default: next_state = S_RESET;
	endcase
end

endmodule

module CURRENT_LR #(
    parameter inst_sig_width = 23, // Bit-width of the significand
    parameter inst_exp_width = 8,  // Bit-width of the exponent
    parameter LR_SIZE        = 7   // Number of learning rates
) (
	input       rst_n,
	input      [$clog2(LR_SIZE)-1:0] LR_index,
	output reg [inst_sig_width+inst_exp_width:0] LR
);
	always@(*) begin
		if (!rst_n) begin
			LR = {inst_sig_width+inst_exp_width+1{1'b0}}; // Reset to 0
		end 
		else begin
			case (LR_index)
				0: LR = 32'h358637bd; // 0.000001
				1: LR = 32'h350637bd;
				2: LR = 32'h348637bd;
				3: LR = 32'h340637bd;
				4: LR = 32'h338637bd;
				5: LR = 32'h330637bd;
				6: LR = 32'h328637bd; // reset to 0 after 6th index
				default: LR = 32'h00000000;
			endcase
		end
	end
endmodule
