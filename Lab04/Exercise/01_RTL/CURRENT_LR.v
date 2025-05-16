// Return the current learning rate based on current epoch
module CURRENT_LR #(
    parameter inst_sig_width = 23, // Bit-width of the significand
    parameter inst_exp_width = 8,  // Bit-width of the exponent
    parameter EPOCH_MAX      = 24  // Maximum number of epochs (each dataset is tranined for 25 epochs)
) (
	input      [$clog2(EPOCH_MAX)-1:0] epoch, // Current epoch
	output reg [inst_sig_width+inst_exp_width:0] LR
);
	// Learning rate constants (IEEE 754 float format)
    localparam [inst_sig_width+inst_exp_width:0] LR_0   = 32'h358637bd; // 1.0000e-6
    localparam [inst_sig_width+inst_exp_width:0] LR_1   = 32'h350637bd; // 5.0000e-7
    localparam [inst_sig_width+inst_exp_width:0] LR_2   = 32'h348637bd; // 2.5000e-7
    localparam [inst_sig_width+inst_exp_width:0] LR_3   = 32'h340637bd; // 1.2500e-7
    localparam [inst_sig_width+inst_exp_width:0] LR_4   = 32'h338637bd; // 6.2500e-8
    localparam [inst_sig_width+inst_exp_width:0] LR_5   = 32'h330637bd; // 3.1250e-8
    localparam [inst_sig_width+inst_exp_width:0] LR_6   = 32'h328637bd; // 1.5625e-8
    localparam [inst_sig_width+inst_exp_width:0] LR_D   = 32'h00000000; // 0

	wire [($clog2(EPOCH_MAX)-1)-2:0] epoch_group;
    assign epoch_group = epoch >> 2; // Divide by 4

	always@(*) begin
		case (epoch_group)
			0: LR = LR_0; // epoch 0 ~ 3:   LR = 1e-6
			1: LR = LR_1; // epoch 4 ~ 7:   LR = 5e-7
			2: LR = LR_2; // epoch 8 ~ 11:  LR = 2.5e-7
			3: LR = LR_3; // epoch 12 ~ 15: LR = 1.25e-7
			4: LR = LR_4; // epoch 16 ~ 19: LR = 6.25e-8
			5: LR = LR_5; // epoch 20 ~ 23: LR = 3.125e-8
			6: LR = (epoch == 24) ? LR_6 : LR_D; // epoch 24: LR = 1.5625e-8, epoch 25 ~ 27: LR = 0
			default: LR = LR_D;
		endcase
	end
endmodule