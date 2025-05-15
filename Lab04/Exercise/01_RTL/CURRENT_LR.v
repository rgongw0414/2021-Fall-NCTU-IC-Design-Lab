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