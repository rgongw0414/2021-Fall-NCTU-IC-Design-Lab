module KT(
	// Input Port
    clk,
    rst_n,
    in_valid,
    in_x,
    in_y,
    move_num,
    priority_num,

	// Output Port
    out_valid,
    out_x,
    out_y,
    move_out
);

input clk, rst_n;
input in_valid;
input [2:0] in_x, in_y;
input [4:0] move_num;
input [2:0] priority_num;

output reg out_valid;
output reg [2:0] out_x, out_y;
output reg [4:0] move_out;

// FSM States
parameter S_RESET  = 2'd0;
parameter S_INPUT  = 2'd1;
parameter S_WALK   = 2'd2;
parameter S_OUTPUT = 2'd3;

parameter CELL_NUM = 25; // 5x5 cells

reg [74:0] cell_dir; // 75=25*3: the walk direction of the 25 cells (3-bit each, i.e., 0~7), except for the last cell, each cell has one of the 8 directions to walk
reg [0:24] cell_walked; // the flag to indicate whether the cell has been walked

reg [4:0] move_num_r;  // how many cells have been visited

// wire [4:0] cell_walked_i;
// wire
// assign cell_walked_i = 5 * x + y;

// TODO_1: x_next = x + x_walk, y_next = y + y_walk
// x_walk = dir_x[ZERO], dir_x[ONE], dir_x[TWO], dir_x[THREE], dir_x[FOUR], dir_x[FIVE], dir_x[SIX], dir_x[SEVEN]
// y_walk = dir_y[ZERO], dir_y[ONE], dir_y[TWO], dir_y[THREE], dir_y[FOUR], dir_y[FIVE], dir_y[SIX], dir_y[SEVEN]
// dir_x[8] = {-1, +1, +2, +2, +1, -1, -2, -2}
// dir_y[8] = {+2, +2, +1, -1, -2, -2, -1, +1}

// TODO_2: store the input x, y, and move_num to regs

wire walk_finished;
assign walk_finished = (cell_walked == {25{1'b1}}); // all 25 cells have been walked

genvar i_dir;
generate
	for (i_dir=0; i_dir<CELL_NUM; i_dir=i_dir+1) begin: cell_dir
		always@(posedge clk or negedge rst_n) begin
			if(!rst_n) begin
				cell_dir[3*i_dir +: 3] = 0;
			end
			else begin
				case (curr_state)
				S_INPUT	: 
				if (in_valid) begin

					cell_dir[3*i_dir +: 3] = priority_num;
				end
				S_WALK	:

					default: 
				endcase
			end
		end
	end
endgenerate

genvar i_walked;
generate
	for (i_walked=0; i_walked<CELL_NUM; i_walked=i_walked+1) begin: cell_walked
		always@(posedge clk or negedge rst_n) begin
			if(!rst_n) begin
				cell_walked[i_walked] = 0;
			end
			else begin
				// Walk to next cell
			end
		end
	end
endgenerate

//***************************************************//
//Finite State Machine example
//***************************************************//

//FSM current state assignment
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		curr_state <= S_RESET;
	end
	else begin
		curr_state <= next_state;
	end
end

//FSM next state assignment
always@(*) begin
	case(curr_state)
		S_RESET: begin
			if (in_valid) begin
				next_state = S_INPUT;
			end
			else begin
				next_state = S_RESET;
			end
		end
		S_INPUT: begin
			if (in_valid) begin
				next_state = S_INPUT
			end
			else begin
				next_state = S_WALK;
			end
		end
		S_WALK: begin
			if (walk_finished) begin
				next_state = S_OUTPUT;
			end
			else begin
				next_state = S_WALK;
			end
		end
		default: begin
			next_state = 
		end
	
	endcase
end 

//Output assignment
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		
	end
	else if(current_state == S_OUTPUT) begin
		
	end
	else begin
		
	end
end

endmodule
