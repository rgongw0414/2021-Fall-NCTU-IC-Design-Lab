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

//****************************************************************//
// Parameter Declaration
//****************************************************************//
parameter CELL_NUM = 25; // 5x5 cells
// FSM States
parameter S_RESET  = 2'd0;
parameter S_INPUT  = 2'd1;
parameter S_WALK   = 2'd2;
parameter S_OUTPUT = 2'd3;

//****************************************************************//
// Regs
//****************************************************************//
reg [1:0] current_state, next_state;
/* To minimize the memory usage, we can store the direction of the 25 cells in 75 bits,
the walk direction of the 25 cells (3-bit each, i.e., 0~7), except for the last cell,
each cell has one of the 8 directions to walk to the next cell.
reg [74:0] cell_dir; */
// Registers for the input signals
reg [2:0] priority_num_r; // the priority number of the current cell
reg [4:0] move_num_r;  // how many cells have been visited
reg [74:0] x, y; // the x and y of the cells which walked from beginning to the end (0-th to 24-th)
reg signed [2:0] offset_x, offset_y;

// Regs for walking (S_WALK)
reg [24:0] cell_walked; // the flag to indicate whether the cell has been walked
reg [4:0] i_th_step; // i-th step, where i=0~24, the walking finished when i=24 
reg [2:0] curr_dir, next_dir;
reg [3:0] backtrack_cnt; // the counter to check the backtracking

//****************************************************************//
// Wires
//****************************************************************//
wire [2:0] curr_x, curr_y; // current position
wire [2:0] prev_x, prev_y; // previous position

wire [4:0] curr_cell_i;
wire walk_finished;
wire out_of_bound;

/* A flag in S_WALK, to check whether the path is backtracking, if true, i_th_step--, otherwise, i_th_step++.
On every attempt to walk from cell_a (by curr_dir) to the next cell, if the cell is out of bound or already walked, then backtrack_cnt++; 
Once backtrack_cnt == 9, set backtrack_f to 1, indicating that all 8 dirs have been attempted and failed. */
wire backtrack_f; 
wire [4:0] backtrack_cell_i; // the index of the cell to backtrack, for indexing cell_walked

//****************************************************************//
// Wire Assignments
//****************************************************************//
assign curr_x = x[3*i_th_step +: 3];
assign curr_y = y[3*i_th_step +: 3];
assign prev_x = (i_th_step == 0) ? x[0+:3] : x[3*(i_th_step-1) +: 3];
assign prev_y = (i_th_step == 0) ? y[0+:3] : y[3*(i_th_step-1) +: 3];

/* What is the value of curr_cell_i when out_of_bound is asserted? 
It will be the previous cell, because curr_cell_i is decrease by 1 when out_of_bound raised. */
assign curr_cell_i = 5 * x[3*i_th_step +: 3] + y[3*i_th_step +: 3]; 
assign walk_finished = (cell_walked == {25{1'b1}}); // all 25 cells have been walked
assign out_of_bound = (curr_x < 0 || curr_x > 4 || curr_y < 0 || curr_y > 4); // out of bound
assign backtrack_f = (backtrack_cnt == 9); // backtracking flag, raise if all 8 dirs have been attempted and failed
assign backtrack_cell_i = 5 * x[3*(i_th_step+1) +: 3] + y[3*(i_th_step+1) +: 3]; // might generate unknown value when i_th_step = 24

// x_walk = dir_x[ZERO], dir_x[ONE], dir_x[TWO], dir_x[THREE], dir_x[FOUR], dir_x[FIVE], dir_x[SIX], dir_x[SEVEN]
// y_walk = dir_y[ZERO], dir_y[ONE], dir_y[TWO], dir_y[THREE], dir_y[FOUR], dir_y[FIVE], dir_y[SIX], dir_y[SEVEN]
// dir_x[8] = {-1, +1, +2, +2, +1, -1, -2, -2}
// dir_y[8] = {+2, +2, +1, -1, -2, -2, -1, +1}

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		backtrack_cnt <= 0;
	end
	else begin
		case (current_state)
		S_WALK: begin
			if (backtrack_f) begin 
				// reset the counter when backtracking
				backtrack_cnt <= 0;
			end
			else if (out_of_bound || cell_walked[curr_cell_i]) begin
				backtrack_cnt <= backtrack_cnt + 1;
			end
			else begin
				backtrack_cnt <= 0;
			end
		end
		default: backtrack_cnt <= backtrack_cnt;
		endcase
	end
end

always@(*) begin
	case (curr_dir)
	0: begin
		offset_x = -1;
		offset_y = 2;
	end
	1: begin
		offset_x = 1;
		offset_y = 2;
	end
	2: begin
		offset_x = 2;
		offset_y = 1;
	end
	3: begin
		offset_x = 2;
		offset_y = -1;
	end
	4: begin
		offset_x = 1;
		offset_y = -2;
	end
	5: begin
		offset_x = -1;
		offset_y = -2;
	end
	6: begin
		offset_x = -2;
		offset_y = -1;
	end
	7: begin
		offset_x = -2;
		offset_y = 1;
	end
	default: begin
		offset_x = 0;
		offset_y = 0;
	end
	endcase
end

// store the input x, y, and move_num to regs
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		x <= 0;
		y <= 0;
	end
	else begin
		case (current_state) 
		S_INPUT	: begin
			if (in_valid) begin
				x[3*i_th_step +: 3] <= in_x;
				y[3*i_th_step +: 3] <= in_y;
			end
			else begin
				x[3*i_th_step +: 3] <= x[3*i_th_step +: 3];
				y[3*i_th_step +: 3] <= y[3*i_th_step +: 3];
			end
		end
		S_WALK	: begin
			if (backtrack_f) begin
				// (0,0) -> (1,2) -> attempt_0 -> attempt_1 -> ... -> attempt_6 -> attempt_7 -> a
				// (2,1) -> ...
				// now i_th_step is on the previous cell
				x[3*(i_th_step) +: 3] <= prev_x;
				y[3*(i_th_step) +: 3] <= prev_y;
			end
			else if (out_of_bound || cell_walked[curr_cell_i]) begin
				x[3*(i_th_step) +: 3] <= prev_x;
				y[3*(i_th_step) +: 3] <= prev_y;
			end
			else begin
				// Walk to the next cell by curr_dir (dir starts from priority_num)
				x[3*i_th_step +: 3] <= x[3*i_th_step +: 3] + offset_x;
				y[3*i_th_step +: 3] <= y[3*i_th_step +: 3] + offset_y;
			end
		end
		default: begin
			x <= x;
			y <= y;
		end 
		endcase
	end
end

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) move_num_r <= 0;
	else begin
		if (in_valid) begin
			move_num_r <= move_num;
		end
		else begin
			move_num_r <= move_num_r;
		end
	end
end

// store priority_num to priority_num_r
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		priority_num_r <= 0;
	end
	else begin
		if (in_valid) begin
			priority_num_r <= priority_num;
		end
		else begin
			priority_num_r <= priority_num_r;
		end
	end
end 

always@(posedge clk or negedge rst_n) begin
	if (in_valid) begin
		curr_dir <= priority_num;
	end
	else begin
		curr_dir <= next_dir;
	end
end

always@(*) begin
	case (current_state)
	// Says priority_num_r = 1, start from (1,2), where the prev cell of (1,2) is (0,0)
	// time: 0,11      1,10         2                   3        ...       8            9             10              11
	// dir:          1        1                   2            3      7            0            1 (all 8 dirs failed, so step back to (0,0)!)
	//      (0,0)   -> (1,2) -> attempt_0: (2,4) -> attempt_1 -> ... -> attempt_6 -> attempt_7 -> attempt_8 (1,2) -> (0,0)
	//              -> (2,1) -> ...
	// dir:          2 
	// time:           12     ...
	// Now i_th_step is on the backtracked cell (0,0), where the 8 dirs walking starting from (1,2) failed, so step back to (0,0)
	S_WALK: begin
		if (backtrack_f) begin
			next_dir = priority_num_r;
		end
		else if (out_of_bound || cell_walked[curr_cell_i]) begin
			next_dir = (curr_dir + 1) % 8;
		end
		else begin
			next_dir = priority_num_r;
		end
	end
	default: next_dir = priority_num_r;
	endcase
end

// i-th-step: 0~24, indicating currently taking the i-th step
// The coordinates indexed by i_th_step are all in the 5x5 grid
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) i_th_step <= 5'b11111;  // 5'b11111 = 31, such that i_th_step = 0 in the first step
	else begin
		case (current_state) 
		S_INPUT	: begin
			if (in_valid) begin
				i_th_step <= i_th_step + 1;
			end
			else begin
				i_th_step <= i_th_step;
			end
		end
		S_WALK	: begin
			if (out_of_bound || cell_walked[curr_cell_i]) begin
				if (backtrack_f) i_th_step <= i_th_step - 2;
				else             i_th_step <= i_th_step - 1;
			end
			else begin
				i_th_step <= i_th_step + 1;
			end
		end
		default: i_th_step <= i_th_step;
		endcase
	end
end

// always@(posedge clk or negedge rst_n) begin
// 	if (!rst_n) begin
// 		cell_dir <= 0;
// 	end
// 	else begin
// 		case (current_state)
// 		S_INPUT	: begin
// 			if (in_valid) begin
// 				cell_dir[3*i_th_step +: 3] <= priority_num;
// 			end
// 		end
// 		S_WALK	: begin
// 			// TODO_3: store the walking direction to cell_dir
// 		end
// 		default: begin
// 			cell_dir <= cell_dir;
// 		end
// 		endcase
// 	end
// end


// Says priority_num_r = 1, i_th_step = 1, start from (1,2), where the prev cell of (1,2) is (0,0)
// i_th_step: 0      1          2                   2        ...       2			2             2               0
// time: 0,11      1,10         2                   3        ...       8            9             10              11
// dir:          1        1                   2            3      7            0            1 (all 8 dirs failed, so step back to (0,0)!)
//      (0,0)   -> (1,2) -> attempt_0: (2,4) -> attempt_1 -> ... -> attempt_6 -> attempt_7 -> attempt_8 (1,2) -> (0,0)
//              -> (2,1) -> ...
// dir:          2 
// time:             12     ...
// i_th_step: 0      1
// Now i_th_step is on the backtracked cell (0,0), where the 8 dirs walking starting from (1,2) failed, so step back to (0,0)
always@(posedge clk or negedge rst_n) begin
	// 0: not walked, 1: walked
	if(!rst_n) cell_walked = 0;
	else begin
		case (current_state)
		S_INPUT	: begin
			if (in_valid) cell_walked[in_x*5 + in_y] <= 1'b1; 
			else          cell_walked <= cell_walked;
		end
		S_WALK	: begin
			if (backtrack_f) begin
				// curr_cell_i now is pointing to the previous cell
				cell_walked[backtrack_cell_i] = 1'b0;
			end
			else if (cell_walked[curr_cell_i]) begin
				cell_walked[curr_cell_i] <= cell_walked[curr_cell_i];
			end
			else begin
				cell_walked[curr_cell_i] <= 1'b1;
			end
		end
		default: cell_walked <= cell_walked;
		endcase
	end
end


//***************************************************//
//Finite State Machine (FSM)
//***************************************************//

//FSM current state assignment
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		current_state <= S_RESET;
	end
	else begin
		current_state <= next_state;
	end
end

//FSM next state assignment
always@(*) begin
	case(current_state)
		S_RESET: begin
			if (in_valid)      next_state = S_INPUT;
			else               next_state = S_RESET;
		end
		S_INPUT: begin
			if (in_valid)      next_state = S_INPUT;
			else               next_state = S_WALK;
		end
		S_WALK: begin
			if (walk_finished) next_state = S_OUTPUT;
			else               next_state = S_WALK;
		end
		S_OUTPUT: begin
			if (out_valid)     next_state = S_OUTPUT;
			else               next_state = S_RESET;
		end
		default:               next_state = S_RESET;
	endcase
end 

//Output assignment
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_x <= 0;
		out_y <= 0;
	end
	else if (current_state == S_OUTPUT) begin
		if (move_out > 0) begin
			out_x <= x[3*(move_out-1) +: 3];
			out_y <= y[3*(move_out-1) +: 3];
		end
		else begin
			out_x <= out_x;
			out_y <= out_y;
		end
	end
	else begin
		out_x <= 0;
		out_y <= 0;
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_valid <= 0;
	end
	else if (current_state == S_OUTPUT) begin
		if (move_out == 25) begin
			out_valid <= 0;
		end
		else begin
			out_valid <= 1;
		end
	end
	else begin
		out_valid <= 0;
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		move_out <= 0;
	end
	else if (current_state == S_OUTPUT) begin
		if (move_out == 25) begin
			move_out <= 0;
		end
		else begin
			move_out <= move_out + 1;
		end
	end
	else begin
		move_out <= 0;
	end
end
endmodule
