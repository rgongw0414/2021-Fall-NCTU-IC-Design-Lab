module VIP(
	// Input signals
	clk,
	rst_n,
	in_valid,
	vector_1,
	vector_2,
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

// FSM parameters
parameter	ST_IDLE		=	'd0,
			ST_INPUT	=	'd1,
			ST_OUTPUT	=	'd2;
			
//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input  clk, rst_n, in_valid;
input [inst_sig_width+inst_exp_width:0] vector_1, vector_2;
output reg	out_valid;
output reg [inst_sig_width+inst_exp_width:0] out;

//---------------------------------------------------------------------
//   WIRE AND REG DECLARATION
//---------------------------------------------------------------------
reg [1:0] count;
reg	[1:0] curr_state, next_state;

// Use for designware
reg  [inst_sig_width+inst_exp_width:0] mult_a, mult_b, add_a, add_b;
wire [inst_sig_width+inst_exp_width:0] mult_out, add_out;

//---------------------------------------------------------------------
//   DesignWare
//---------------------------------------------------------------------
DW_fp_mult #(inst_sig_width, inst_exp_width, inst_ieee_compliance) M0 (.a(mult_a), .b(mult_b), .rnd(3'b000), .z(mult_out));
DW_fp_add  #(inst_sig_width, inst_exp_width, inst_ieee_compliance) A0 (.a(add_a), .b(add_b), .rnd(3'b000), .z(add_out));

//---------------------------------------------------------------------
//   ALGORITHM
//---------------------------------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
	begin
		mult_a <= 0;
		mult_b <= 0;
	end
	else if (in_valid) begin
		mult_a <= vector_1;
		mult_b <= vector_2;
	end
	else if (curr_state == ST_OUTPUT) begin
		mult_a <= 0;
		mult_b <= 0;
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n)	begin
		add_a <= 0;
	end
	else if (count == 1) begin
		add_a <= mult_out;
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n)	begin
		add_b <= 0;
	end
	else if (count == 2) begin
		add_b <= mult_out;
	end
end

//---------------------------------------------------------------------
//   COUNTER
//---------------------------------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
		count <= 0;
	else if (count == 3)
		count <= 0;
	else if (in_valid || count > 0)
		count <= count + 1;
end

//---------------------------------------------------------------------
//   OUTPUT
//---------------------------------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
		out_valid <= 0;
	else if (curr_state == ST_OUTPUT)
		out_valid <= 1;
	else
		out_valid <= 0;
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n)
		out <= 0;
	else if (curr_state == ST_OUTPUT)
		out <= add_out;
	else
		out <= 0;
end

//---------------------------------------------------------------------
//   Finite-State Machine                                          
//---------------------------------------------------------------------
always@(posedge	clk or negedge rst_n) begin
	if (!rst_n) 
		curr_state	<=	ST_IDLE;
	else 
		curr_state	<=	next_state;
end

always@(*)	begin
	case (curr_state)
		ST_IDLE: begin
			if (in_valid) next_state = ST_INPUT;
			else 		  next_state = ST_IDLE;
		end
		ST_INPUT: begin
			if (count == 3) next_state = ST_OUTPUT;
			else            next_state = ST_INPUT;
		end
		ST_OUTPUT: begin
			next_state = ST_IDLE;
		end
		default: begin
			next_state = ST_IDLE;
		end
	endcase
end
endmodule
