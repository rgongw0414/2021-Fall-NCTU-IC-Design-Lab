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
				0: LR = 32'h358637bd; // epoch 0 ~ 3:   LR = 1e-6
				1: LR = 32'h350637bd; // epoch 4 ~ 7:   LR = 5e-7
				2: LR = 32'h348637bd; // epoch 8 ~ 11:  LR = 2.5e-7
				3: LR = 32'h340637bd; // epoch 12 ~ 15: LR = 1.25e-7
				4: LR = 32'h338637bd; // epoch 16 ~ 19: LR = 6.25e-8
				5: LR = 32'h330637bd; // epoch 20 ~ 23: LR = 3.125e-8
				6: LR = 32'h328637bd; // epoch 24     : LR = 1.5625e-8
				default: LR = 32'h00000000;
			endcase
		end
	end
endmodule