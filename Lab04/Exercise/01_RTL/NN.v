`include "CURRENT_LR.v"

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
wire [3-1:0] rnd;
assign rnd = 3'b000; // round to nearest even

// FSM parameters
localparam FSM_SIZE    = 3; // 3 states: S_RESET, S_INPUT, S_CALCULATE
localparam FSM_WIDTH   = $clog2(FSM_SIZE); // 3 states: S_RESET, S_INPUT, S_CALCULATE
localparam S_RESET     = 0;
localparam S_INPUT     = 1;
localparam S_CALCULATE = 2; // forward, backward, update while epoch < 25; go to S_INPUT to get new weights when epoch >= 25

// Training parameters
localparam EPOCH_MAX     = 24; // 25 epochs
localparam EPOCH_WIDTH   = $clog2(EPOCH_MAX); 
localparam DATASET_MAX   = 99; // 100 data points for training
localparam DATASET_WIDTH = $clog2(DATASET_MAX); // 100 data points for training

// Pipeline parameters
localparam CNT_MAX     = 7;  // Each forward/backward/update takes 7 cycles, cnt_max = 7
localparam CNT_WIDTH   = $clog2(CNT_MAX); 
localparam FP_ZERO     = {inst_exp_width+inst_sig_width+1{1'b0}}; // 0.0 in IEEE 754 format 
localparam LR_SIZE     = 7; // 7 learning rates for every 4 epochs (1e-6, 5e-7, 2.5e-7, 1.25e-7, 6.25e-8, 3.125e-8, 1.5625e-8)

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
reg  update_en; // enable signal for update
reg  [DATASET_WIDTH-1:0] dataset_index; // index for dataset: 0 ~ 99

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

reg  [inst_sig_width+inst_exp_width:0] data_points [INPUT_DIM-1:0]; // stores the 4 data for data_point
wire [inst_sig_width+inst_exp_width:0] s0, s1, s2, s3; // stores the 4 data for data_point
reg  [inst_sig_width+inst_exp_width:0] target_r; // stores the 1 data for target
reg  [$clog2(INPUT_DIM)-1:0] data_point_index; // index for data_point
assign s0 = data_points[0]; // s^1_0
assign s1 = data_points[1]; // s^1_1
assign s2 = data_points[2]; // s^1_2
assign s3 = data_points[3]; // s^1_3

// DW_fp_mac parameters
reg  [inst_sig_width+inst_exp_width:0] mac1_a, mac1_b, mac1_c, mac2_a, mac2_b, mac2_c, mac3_a, mac3_b, mac3_c;
wire [inst_sig_width+inst_exp_width:0] mac1_out, mac2_out, mac3_out;

// DW_fp_mult parameters
reg  [inst_sig_width+inst_exp_width:0] mult1_a, mult1_b, mult2_a, mult2_b, mult3_a, mult3_b, mult4_a, mult4_b;
wire [inst_sig_width+inst_exp_width:0] mult1_out, mult2_out, mult3_out, mult4_out;

// DW_fp_sub parameters
reg  [inst_sig_width+inst_exp_width:0] sub1_a, sub1_b, sub2_a, sub2_b, sub3_a, sub3_b;
wire [inst_sig_width+inst_exp_width:0] sub1_out, sub2_out, sub3_out;

// DW_fp_sum3 parameters
reg  [inst_sig_width+inst_exp_width:0] sum1_a, sum1_b, sum1_c;
wire [inst_sig_width+inst_exp_width:0] sum1_out;

// DW_fp_cmp parameters
wire h0_is_pos, h1_is_pos, h2_is_pos; // flag for checking if h^1_i is positive or negative

// FSM
reg [FSM_WIDTH-1:0]   curr_state, next_state;
reg [EPOCH_WIDTH-1:0] epoch;
reg [CNT_WIDTH-1:0]   cnt; // cnt for pipeline stage

//---------------------------------------------------------------------
//   DesignWare
//---------------------------------------------------------------------
wire [7:0] dummy_status1, dummy_status2, dummy_status3, dummy_status4, dummy_status5, dummy_status6, dummy_status7, dummy_status8, dummy_status9, dummy_status10, dummy_status11, dummy_status12, dummy_status13, dummy_status14, dummy_status15, dummy_status16, dummy_status17;
wire dummy_flag1, dummy_flag2, dummy_flag3, dummy_flag4, dummy_flag5, dummy_flag6, dummy_flag7, dummy_flag8, dummy_flag9;
wire [inst_sig_width+inst_exp_width:0] dummy_z1, dummy_z2, dummy_z3, dummy_z4, dummy_z5, dummy_z6;
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC1 (.a(mac1_a), .b(mac1_b), .c(mac1_c), .rnd(rnd), .z(mac1_out), .status(dummy_status1));
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC2 (.a(mac2_a), .b(mac2_b), .c(mac2_c), .rnd(rnd), .z(mac2_out), .status(dummy_status2));
DW_fp_mac  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MAC3 (.a(mac3_a), .b(mac3_b), .c(mac3_c), .rnd(rnd), .z(mac3_out), .status(dummy_status3));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL1 (.a(mult1_a), .b(mult1_b), .rnd(rnd), .z(mult1_out), .status(dummy_status4));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL2 (.a(mult2_a), .b(mult2_b), .rnd(rnd), .z(mult2_out), .status(dummy_status5));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL3 (.a(mult3_a), .b(mult3_b), .rnd(rnd), .z(mult3_out), .status(dummy_status6));
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) MUL4 (.a(mult4_a), .b(mult4_b), .rnd(rnd), .z(mult4_out), .status(dummy_status7));
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB1 (.a(sub1_a), .b(sub1_b), .rnd(rnd), .z(sub1_out), .status(dummy_status8));
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB2 (.a(sub2_a), .b(sub2_b), .rnd(rnd), .z(sub2_out), .status(dummy_status9));
DW_fp_sub  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUB3 (.a(sub3_a), .b(sub3_b), .rnd(rnd), .z(sub3_out), .status(dummy_status10));
DW_fp_sum3 #(inst_sig_width, inst_exp_width, inst_ieee_compliance) SUM1 (.a(sum1_a), .b(sum1_b), .c(sum1_c), .rnd(rnd), .z(sum1_out), .status(dummy_status11));

// compare mac1_out, mac2_out, mac3_out with 0.0 to check if they are positive or negative
DW_fp_cmp #(inst_sig_width, inst_exp_width, inst_ieee_compliance)  CMP1 (.a(mac1_out), .b(FP_ZERO), .altb(dummy_flag1), .agtb(h0_is_pos), .aeqb(dummy_flag2), .unordered(dummy_flag3), .z0(dummy_z1), .z1(dummy_z2), .status0(dummy_status12), .status1(dummy_status13), .zctr(1'b0));
DW_fp_cmp #(inst_sig_width, inst_exp_width, inst_ieee_compliance)  CMP2 (.a(mac2_out), .b(FP_ZERO), .altb(dummy_flag4), .agtb(h1_is_pos), .aeqb(dummy_flag5), .unordered(dummy_flag6), .z0(dummy_z3), .z1(dummy_z4), .status0(dummy_status14), .status1(dummy_status15), .zctr(1'b0));
DW_fp_cmp #(inst_sig_width, inst_exp_width, inst_ieee_compliance)  CMP3 (.a(mac3_out), .b(FP_ZERO), .altb(dummy_flag7), .agtb(h2_is_pos), .aeqb(dummy_flag8), .unordered(dummy_flag9), .z0(dummy_z5), .z1(dummy_z6), .status0(dummy_status16), .status1(dummy_status17), .zctr(1'b0));

// synopsys dc_script_begin
//
// set_implementation rtl MAC1
// set_implementation rtl MAC2
// set_implementation rtl MAC3
// set_implementation rtl MUL1
// set_implementation rtl MUL2
// set_implementation rtl MUL3
// set_implementation rtl MUL4
// set_implementation rtl SUB1
// set_implementation rtl SUB2
// set_implementation rtl SUB3
// set_implementation rtl SUM1
// set_implementation rtl CMP1
// set_implementation rtl CMP2
// set_implementation rtl CMP3
//
// synopsys dc_script_end

//----------------------------------------------------------------------
// Module declaration 
//---------------------------------------------------------------------
CURRENT_LR #(.inst_sig_width(inst_sig_width), .inst_exp_width(inst_exp_width), .EPOCH_MAX(EPOCH_MAX)) CURR_LR (.epoch(epoch), .LR(LR));

//---------------------------------------------------------------------
// Assignments
//---------------------------------------------------------------------

//---------------------------------------------------------------------
// Always block
//---------------------------------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		update_en <= 0;
	end
	else if (curr_state == S_CALCULATE && !update_en && cnt == 6) begin 
		// pull up update_en after the first 6 cycles of S_CALCULATE
		update_en <= 1;
	end
	else if (curr_state == S_CALCULATE && update_en && in_valid_w2) begin 
		// update_en is all the way up, until in_valid_w2 is high (indicating the 25 epochs of current dataset are done)
		update_en <= 0;
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		dataset_index <= 0;
	end
	else if (dataset_index == DATASET_MAX) begin
		dataset_index <= 0;
	end
	else if (update_en && cnt == 4) begin
		dataset_index <= dataset_index + 1;
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		epoch <= 0;
	end
	else if (epoch == EPOCH_MAX && dataset_index == DATASET_MAX) begin
		epoch <= 0; // increase epoch every 100 data points
	end
	else if (dataset_index == DATASET_MAX) begin
		epoch <= epoch + 1; // increase epoch every 100 data points
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		w0  <= 0;
		w1  <= 0;
		w2  <= 0;
		w3  <= 0;
		w4  <= 0;
		w5  <= 0;
		w6  <= 0;
		w7  <= 0;
		w8  <= 0;
		w9  <= 0;
		w10 <= 0;
		w11 <= 0;
	end
	else if (in_valid_w1) begin
		w0  <= w1; // w^1_0
		w1  <= w2; // w^1_1
		w2  <= w3; // w^1_2
		w3  <= w4; // w^1_3
		w4  <= w5; // w^1_4
		w5  <= w6; // w^1_5
		w6  <= w7; // w^1_6
		w7  <= w8; // w^1_7
		w8  <= w9; // w^1_8
		w9  <= w10; // w^1_9
		w10 <= w11; // w^1_10
		w11 <= weight1; // w^1_11
	end
	else if (update_en) begin 
		case (cnt)
			1: begin
				if (in_valid_d && !in_valid_t) begin // this is stupid, but it works, gotta fix this later
					w1 <= sub1_out; 
					w5 <= sub2_out; 
					w9 <= sub3_out; 
				end
			end
			2: begin
				w2  <= sub1_out; 
				w6  <= sub2_out; 
				w10 <= sub3_out; 
			end
			3: begin
				w3  <= sub1_out; 
				w7  <= sub2_out; 
				w11 <= sub3_out; 
			end
			7: begin
				w0 <= sub1_out; // w^1_0 = w^1_0 - LR*s0*delta^2_0
				w4 <= sub2_out; // w^1_4 = w^1_4 - LR*s1*delta^2_1
				w8 <= sub3_out; // w^1_8 = w^1_8 - LR*s2*delta^2_2
			end
		endcase
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
	else if (update_en && cnt == 4) begin
		w20 <= sub1_out; // w^2_0 = w^2_0 - LR*delta^2_0*(y_pred - target)
		w21 <= sub2_out; // w^2_1 = w^2_1 - LR*delta^2_1*(y_pred - target)
		w22 <= sub3_out; // w^2_2 = w^2_2 - LR*delta^2_2*(y_pred - target)
	end
end

genvar i;
generate
	for (i = 0; i < INPUT_DIM; i = i + 1) begin: data_points_gen
		always@(posedge clk or negedge rst_n) begin
			if (!rst_n) begin
				data_points[i] <= 0;
			end
			else if (in_valid_d && i == data_point_index) begin
				data_points[i] <= data_point; // data_point is the input data for each neuron in the input layer
			end
		end
	end
endgenerate

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		data_point_index <= 0;
	end
	else if (in_valid_d) begin
		data_point_index <= data_point_index + 1; // data_point_index is the index for data_point
	end
	else begin
		data_point_index <= 0;
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
					mac1_a <= data_point; // s^1_0
					mac1_b <= w0; // w^1_0
					mac1_c <= 0; // MAC1 output register
					mac2_a <= data_point; 
					mac2_b <= w4; // w^1_4
					mac2_c <= 0; // MAC2 output register
					mac3_a <= data_point; 
					mac3_b <= w8; // w^1_8
					mac3_c <= 0; // MAC3 output register
				end
			end
			S_CALCULATE: begin
				case (cnt)
					1: begin
						if (in_valid_t) begin
							mac1_a <= data_point; 
							mac1_b <= w0; 
							mac1_c <= 0;  // MAC1 output register
							mac2_a <= data_point; 
							mac2_b <= w4; 
							mac2_c <= 0;  // MAC2 output register
							mac3_a <= data_point; 
							mac3_b <= w8; 
							mac3_c <= 0;  // MAC3 output register
						end
						else begin
							mac1_a <= data_point; 
							mac1_b <= sub1_out;  
							mac1_c <= mac1_out;
							mac2_a <= data_point; 
							mac2_b <= sub2_out;   
							mac2_c <= mac2_out;
							mac3_a <= data_point; 
							mac3_b <= sub3_out;   
							mac3_c <= mac3_out;
						end
					end
					2: begin
						mac1_a <= data_point; 
						mac1_b <= sub1_out;   
						mac1_c <= mac1_out; 
						mac2_a <= data_point; 
						mac2_b <= sub2_out;   
						mac2_c <= mac2_out; 
						mac3_a <= data_point; 
						mac3_b <= sub3_out;   
						mac3_c <= mac3_out;
					end
					3: begin
						mac1_a <= data_point; 
						mac1_b <= sub1_out;   
						mac1_c <= mac1_out;
						mac2_a <= data_point; 
						mac2_b <= sub2_out;   
						mac2_c <= mac2_out; 
						mac3_a <= data_point; 
						mac3_b <= sub3_out;   
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
	mult1_a = 0;
	mult1_b = 0;
	mult2_a = 0;
	mult2_b = 0;
	mult3_a = 0;
	mult3_b = 0;
	mult4_a = LR;
	mult4_b = 0;
	if (curr_state == S_CALCULATE) begin
		case (cnt)
			1: begin
				mult1_a = delta10; 
				mult1_b = LRs1; 
				mult2_a = delta11;
				mult2_b = LRs1;
				mult3_a = delta12;
				mult3_b = LRs1;
				mult4_a = LR; 
				mult4_b = s0; 
			end
			2: begin
				mult1_a = delta10; 
				mult1_b = LRs2; 
				mult2_a = delta11;
				mult2_b = LRs2;
				mult3_a = delta12;
				mult3_b = LRs2;
				mult4_a = LR;
				mult4_b = s1;
			end
			3: begin
				mult1_a = delta10; 
				mult1_b = LRs3; 
				mult2_a = delta11;
				mult2_b = LRs3;
				mult3_a = delta12;
				mult3_b = LRs3;
				mult4_a = LR;
				mult4_b = s2;
			end
			4: begin
				mult1_a = LRdelta2; // LR*delta2 = LR*(y_pred - target)
				mult1_b = y0; 
				mult2_a = LRdelta2;
				mult2_b = y1;
				mult3_a = LRdelta2;
				mult3_b = y2;
				mult4_a = LR;
				mult4_b = s3;
			end
			5: begin
				mult1_a = y0; 
				mult1_b = w20; // w^2_0
				mult2_a = y1;
				mult2_b = w21; // w^2_1
				mult3_a = y2;
				mult3_b = w22; // w^2_2
				mult4_a = LR;
				mult4_b = 0;
			end
			6: begin
				mult1_a = delta2; // delta2 = y_pred - target
				mult1_b = w20; // w^2_0
				mult2_a = delta2;
				mult2_b = w21; // w^2_1
				mult3_a = delta2;
				mult3_b = w22; // w^2_2
				mult4_a = LR;
				mult4_b = delta2; // delta2 = y_pred - target
			end
			7: begin
				mult1_a = delta10; 
				mult1_b = LRs0; // LR*s0
				mult2_a = delta11;
				mult2_b = LRs0; // LR*s1
				mult3_a = delta12;
				mult3_b = LRs0; // LR*s2
				mult4_a = LR;
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
						if (in_valid_d && !in_valid_t) begin
							LRs0 <= mult4_out;
						end
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

always@(*) begin
	sum1_a = 0;
	sum1_b = 0;
	sum1_c = 0;
	if (curr_state == S_CALCULATE && cnt == 5) begin
		sum1_a = mult1_out;
		sum1_b = mult2_out;
		sum1_c = mult3_out;
	end
end

always@(*) begin
	sub1_a = 0;
	sub1_b = 0;
	sub2_a = 0;
	sub2_b = 0;
	sub3_a = 0;
	sub3_b = 0;
	if (curr_state == S_CALCULATE) begin
		case (cnt)
			1: begin
				sub1_a = w1; 
				sub1_b = mult1_out; 
				sub2_a = w5; 
				sub2_b = mult2_out; 
				sub3_a = w9; 
				sub3_b = mult3_out; 
			end
			2: begin
				sub1_a = w2; 
				sub1_b = mult1_out; 
				sub2_a = w6; 
				sub2_b = mult2_out; 
				sub3_a = w10; 
				sub3_b = mult3_out; 
			end
			3: begin
				sub1_a = w3; 
				sub1_b = mult1_out; 
				sub2_a = w7; 
				sub2_b = mult2_out; 
				sub3_a = w11; 
				sub3_b = mult3_out; 
			end
			4: begin
				sub1_a = w20; 
				sub1_b = mult1_out; 
				sub2_a = w21; 
				sub2_b = mult2_out; 
				sub3_a = w22; 
				sub3_b = mult3_out; 
			end
			5: begin // delta2 = y_pred - target
				sub1_a = sum1_out; // y_pred = w^2_0 * y^1_0 + w^2_1 * y^1_1 + w^2_2 * y^1_2
				sub1_b = target_r; // target = y_gold
				sub2_a = 0;
				sub2_b = 0;
				sub3_a = 0;
				sub3_b = 0;
			end
			7: begin
				sub1_a = w0; // w^1_0
				sub1_b = mult1_out; // LR * grad = LR * (LR*s0*delta^1_0)
				sub2_a = w4; 
				sub2_b = mult2_out; 
				sub3_a = w8; 
				sub3_b = mult3_out;
			end
		endcase
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cnt <= 1;
	end
	else if (curr_state == S_CALCULATE) begin
		if (cnt == CNT_MAX) begin
			cnt <= 1;
		end 
		else if (update_en && in_valid_d && in_valid_t) begin
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
end

//------------------------------------------
// FSM
//------------------------------------------
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		curr_state <= S_RESET;
	end 
	else begin
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
			if (epoch == EPOCH_MAX && dataset_index == DATASET_MAX) begin
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
