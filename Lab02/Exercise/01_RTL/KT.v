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
input [4:0] move_num; // how many cells have been visited (since there's no default start position, which means move_num_r = 1~24, i.e., at least 1 cell has been visited)
input [2:0] priority_num;

output reg out_valid;
output reg [2:0] out_x, out_y;
output reg [4:0] move_out;

//****************************************************************//
// Parameter Declaration
//****************************************************************//
parameter CELL_WIDTH = 3+1; // the width of x and y, +1 for sign bit
parameter CELL_NUM = 25; // 5x5 cells
// FSM States
parameter S_RESET  = 2'd0;
parameter S_INPUT  = 2'd1;
parameter S_WALK   = 2'd2;
parameter S_OUTPUT = 2'd3;

//*****************************************************************//
// Debug
parameter TP_NO = 0; // Test Pattern Number
//*****************************************************************//
// Regs
//****************************************************************//
reg [1:0] current_state, next_state;
/* To minimize the memory usage, we can store the direction of the 25 cells in 75 bits,
the walk direction of the 25 cells (4-signed-bit each, i.e., -8~7), except for the last cell,
each cell has one of the 8 directions to walk to the next cell.
reg [CELL_WIDTH*CELL_NUM-1:0] cell_dir; */
// Registers for the input signals
reg [2:0] priority_num_r; // the priority number of the current cell
reg [4:0] move_num_r;  // how many cells have been visited (since there's no default start position, which means move_num_r = 1~24, i.e., at least 1 cell has been visited)
reg signed [CELL_WIDTH*CELL_NUM-1:0] x, y; // the x and y of the cells which walked from beginning to the end (0-th to 24-th)
reg signed [CELL_WIDTH-1:0] offset_x, offset_y;

// Regs for walking (S_WALK)
reg [CELL_NUM-1:0] cell_walked; // the flag to indicate whether the cell has been walked
reg [4:0] i_th_step; // i-th step, where i=0~24, the walking finished when i=24 
reg [2:0] curr_dir, next_dir;
reg [2:0] backtrack_dir; // the next direction to backtrack

reg signed [CELL_WIDTH-1:0] prev_x, prev_y; // previous position
reg signed [CELL_WIDTH-1:0] curr_x, curr_y; // current position
reg backtrack_f; // backtracking flag

//****************************************************************//
// Wires
//****************************************************************//
wire [4:0] curr_cell_i; // the index of the current cell, for indexing cell_walked
// wire visited; // the flag to indicate whether the cell has been visited
wire next_visited; // the flag to indicate whether the next cell has been visited
wire walk_finished;
// wire out_of_bound;
wire next_out_of_bound; // the flag to indicate whether the cell is out of bound

/* A flag in S_WALK, to check whether the path is backtracking, if true, i_th_step--, otherwise, i_th_step++.
On every attempt to walk from cell_a (by curr_dir) to the next cell, if the cell is out of bound or already walked, then backtrack_cnt++; 
Once backtrack_cnt == 9, set backtrack_f to 1, indicating that all 8 dirs have been attempted and failed. */
wire signed [CELL_WIDTH-1:0] next_x, next_y; // the next position to walk to
wire next_cell_found; // the flag to indicate whether the next cell is found (not out of bound and not visited before)
wire signed [5:0] next_x_tmp_ext, next_y_tmp_ext;
//****************************************************************//
// Wire Assignments
//****************************************************************//

//************************************************************************//
// Broken, need to fix cell_walked, once visit the cell, it is asserted right away
// assign visited = cell_walked[curr_cell_i]; // the flag to indicate whether the current cell has been visited
assign next_x = (backtrack_f) ? prev_x : curr_x + offset_x;
assign next_y = (backtrack_f) ? prev_y : curr_y + offset_y;
assign next_x_tmp_ext = { {2{next_x[CELL_WIDTH-1]}}, next_x }; // Sign extend to 6 bits
assign next_y_tmp_ext = { {2{next_y[CELL_WIDTH-1]}}, next_y }; // Sign extend to 6 bits
// assign out_of_bound = (curr_x < 0 || curr_x > 4 || curr_y < 0 || curr_y > 4); // out of bound
assign next_out_of_bound = (next_x_tmp_ext < 0 || next_x_tmp_ext > 4 || next_y_tmp_ext < 0 || next_y_tmp_ext > 4); // out of bound
assign next_visited = ((5*next_x_tmp_ext+next_y_tmp_ext < 0) || (5*next_x_tmp_ext+next_y_tmp_ext > 24)) ? 0 : cell_walked[5*next_x_tmp_ext + next_y_tmp_ext]; // the flag to indicate whether the next cell has been visited
assign next_cell_found = (!next_out_of_bound && !next_visited); // the flag to indicate whether the next cell is found (not out of bound and not visited before)
// assign backtrack_f = (current_state == S_WALK && next_dir == priority_num_r && !next_cell_found); // backtracking flag, raise if all 8 dirs have been attempted and failed
//************************************************************************//
/* What is the value of curr_cell_i when out_of_bound is asserted? 
It will be the previous cell, because curr_cell_i is decrease by 1 when out_of_bound raised. */
assign curr_cell_i = 5*curr_x + curr_y; // & {(CELL_WIDTH-1){1'b1}} masks out the sign bit because of the auto-filling 0s
assign walk_finished = (cell_walked == {25{1'b1}}); // all 25 cells have been walked

// assign prev_x = (i_th_step == 0)          ? x[0+:CELL_WIDTH]                                        : x[CELL_WIDTH*(i_th_step-1) +: CELL_WIDTH];
// assign prev_y = (i_th_step == 0)          ? y[0+:CELL_WIDTH]                                        : y[CELL_WIDTH*(i_th_step-1) +: CELL_WIDTH];
// // assign curr_x = (current_state == S_WALK) ? x[CELL_WIDTH*(move_num_r - 1) +: CELL_WIDTH] + offset_x : x[CELL_WIDTH*i_th_step +: CELL_WIDTH];
// // assign curr_y = (current_state == S_WALK) ? y[CELL_WIDTH*(move_num_r - 1) +: CELL_WIDTH] + offset_y : y[CELL_WIDTH*i_th_step +: CELL_WIDTH];
// assign curr_x = x[CELL_WIDTH*i_th_step +: CELL_WIDTH];
// assign curr_y = y[CELL_WIDTH*i_th_step +: CELL_WIDTH];
// assign next_x = curr_x + offset_x;
// assign next_y = curr_y + offset_y;

// assign backtrack_f = (current_state == S_WALK && next_dir == priority_num_r && !next_cell_found); // backtracking flag, raise if all 8 dirs have been attempted and failed
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		backtrack_f <= 0;
	end
	else if (current_state == S_WALK) begin
		if (next_dir == priority_num_r && !next_cell_found) begin
			backtrack_f <= 1;
		end
		else begin
			backtrack_f <= 0;
		end
	end
	else begin
		backtrack_f <= 0;
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

// when backtrack_f asserted, calculate the next dir by curr_x, curr_y, prev_x, prev_y
// the diff b/w curr_x/y and prev_x/y is the offset to backtrack
wire signed [CELL_WIDTH-1:0] diff_x, diff_y;
assign diff_x = curr_x - prev_x;
assign diff_y = curr_y - prev_y;

always@(*) begin
	// Calculate the offset to backtrack
	if (diff_x == -1 && diff_y == 2) begin
		backtrack_dir = 3'd1;
	end
	else if (diff_x == 1 && diff_y == 2) begin
		backtrack_dir = 3'd2;
	end
	else if (diff_x == 2 && diff_y == 1) begin
		backtrack_dir = 3'd3;
	end
	else if (diff_x == 2 && diff_y == -1) begin
		backtrack_dir = 3'd4;
	end
	else if (diff_x == 1 && diff_y == -2) begin
		backtrack_dir = 3'd5;
	end
	else if (diff_x == -1 && diff_y == -2) begin
		backtrack_dir = 3'd6;
	end
	else if (diff_x == -2 && diff_y == -1) begin
		backtrack_dir = 3'd7;
	end
	else if (diff_x == -2 && diff_y == 1) begin
		backtrack_dir = 3'd0;
	end
	else begin
		backtrack_dir = priority_num_r;
	end
	// end
	// else begin
	// 	backtrack_dir = priority_num_r;
	// end
end

// prev_x/y: the previous position, curr_x/y: the current position
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		prev_x <= 0;
		prev_y <= 0;
	end
	else begin
		case (current_state)
		// S_INPUT: begin
		// 	prev_x <= prev_x;
		// 	prev_y <= prev_y;
		// end
		S_WALK: begin
			if (backtrack_f) begin
				prev_x <= x[CELL_WIDTH*(i_th_step-3) +: CELL_WIDTH];
				prev_y <= y[CELL_WIDTH*(i_th_step-3) +: CELL_WIDTH]; // update prev_y to match the change made to prev_x
			end
			// else if (next_out_of_bound || next_visited) begin
			else if (!next_cell_found) begin
				prev_x <= prev_x;
				prev_y <= prev_y;
			end
			else begin
				prev_x <= curr_x;
				prev_y <= curr_y;
			end
		end
		S_OUTPUT: begin
			if (next_state == S_RESET) begin
				prev_x <= 0;
				prev_y <= 0;
			end
			else begin
				prev_x <= prev_x;
				prev_y <= prev_y;
			end
		end
		default: begin
			prev_x <= prev_x;
			prev_y <= prev_y;
		end
		endcase
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		curr_x <= 0;
		curr_y <= 0;
	end
	else begin
		case (current_state)
		S_RESET: begin
			if (in_valid) begin
				curr_x <= {1'b0, in_x};
				curr_y <= {1'b0, in_y};
			end
			else begin
				curr_x <= curr_x;
				curr_y <= curr_y;
			end
		end
		S_INPUT: begin
			if (next_state == S_WALK) begin
				// curr_x <= {1'b0, in_x}; 
				// curr_y <= {1'b0, in_y};
				if (move_num_r == 1) begin
					curr_x <= x[CELL_WIDTH*(i_th_step-1) +: CELL_WIDTH];
					curr_y <= y[CELL_WIDTH*(i_th_step-1) +: CELL_WIDTH];
					// curr_x <= prev_x;
					// curr_y <= prev_y;
				end
				else begin
					curr_x <= {1'b0, in_x}; 
					curr_y <= {1'b0, in_y};
				end
			end
			else begin
				curr_x <= curr_x;
				curr_y <= curr_y;
			end
		end
		S_WALK: begin
			if (backtrack_f) begin
				curr_x <= x[CELL_WIDTH*(i_th_step-2) +: CELL_WIDTH];
				curr_y <= y[CELL_WIDTH*(i_th_step-2) +: CELL_WIDTH];
			end
			// else if (next_out_of_bound || next_visited) begin
			// 	curr_x <= curr_x;
			// 	curr_y <= curr_y;
			// end
			else if (next_cell_found) begin
				curr_x <= next_x;
				curr_y <= next_y;
			end
			else begin
				curr_x <= curr_x;
				curr_y <= curr_y;
			end
		end
		S_OUTPUT: begin
			if (next_state == S_RESET) begin
				curr_x <= 0;
				curr_y <= 0;
			end
			else begin
				curr_x <= curr_x;
				curr_y <= curr_y;
			end
		end
		default: begin
			curr_x <= curr_x;
			curr_y <= curr_y;
		end
		endcase
	end
end

// store the input x, y, and move_num to regs
always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		x <= 0;
		y <= 0;
	end
	else begin
		case (current_state)
		S_RESET	: begin
			if (in_valid) begin
				x[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= {1'b0, in_x};
				y[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= {1'b0, in_y};
			end
			else begin
				x[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= x[CELL_WIDTH*i_th_step +: CELL_WIDTH];
				y[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= y[CELL_WIDTH*i_th_step +: CELL_WIDTH];
			end
		end
		S_INPUT	: begin
			if (in_valid) begin
				x[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= {1'b0, in_x};
				y[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= {1'b0, in_y};
			end
			else begin
				x[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= x[CELL_WIDTH*i_th_step +: CELL_WIDTH];
				y[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= y[CELL_WIDTH*i_th_step +: CELL_WIDTH];
			end
		end
		S_WALK	: begin
			if (next_cell_found) begin
				x[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= next_x;
				y[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= next_y;
			end
			else begin
			// else if (backtrack_f || next_out_of_bound || next_visited) begin
				x[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= x[CELL_WIDTH*i_th_step +: CELL_WIDTH];
				y[CELL_WIDTH*i_th_step +: CELL_WIDTH] <= y[CELL_WIDTH*i_th_step +: CELL_WIDTH];
			end
		end
		S_OUTPUT: begin
			if (next_state == S_RESET) begin
				x <= 0;
				y <= 0;
			end
			else begin
				x <= x;
				y <= y;
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
	if (!rst_n) begin
		move_num_r <= 0;
		priority_num_r <= 0;
	end 
	else begin
		case (current_state)
			S_RESET: begin
				if (in_valid) begin
					move_num_r <= move_num;
					priority_num_r <= priority_num;
				end
				else begin
					move_num_r <= move_num_r;
					priority_num_r <= priority_num_r;
				end
			end
			S_OUTPUT: begin
				if (next_state == S_RESET) begin
					move_num_r <= 0;
					priority_num_r <= 0;
				end
				else begin
					move_num_r <= move_num_r;
					priority_num_r <= priority_num_r;
				end
			end
			default: begin
				move_num_r <= move_num_r;
				priority_num_r <= priority_num_r;
			end
		endcase
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) curr_dir <= 0;
	else if (current_state == S_INPUT) begin
		curr_dir <= priority_num_r;
	end
	else begin
		curr_dir <= next_dir;
	end
end

always@(*) begin
	case (current_state)
	S_WALK: begin
		if (backtrack_f) begin
			next_dir = backtrack_dir;
		end
		else if (next_out_of_bound || next_visited) begin
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
	if (!rst_n) i_th_step <= 0;  // 5'b11111 = 31, such that i_th_step = 0 in the first step
	else begin
		case (current_state) 
		S_RESET	: begin
			if (next_state == S_INPUT)  i_th_step <= i_th_step + 1;
			else                        i_th_step <= i_th_step;
		end
		S_INPUT	: begin
			if (in_valid) begin
				// if (next_state == S_WALK) i_th_step <= i_th_step;
				i_th_step <= i_th_step + 1;
			end
			else begin
				i_th_step <= i_th_step;
			end

			// if (next_state == S_WALK) begin
			// 	i_th_step <= i_th_step + 1;
			// end
		end
		S_WALK	: begin
			if (backtrack_f) begin
				i_th_step <= i_th_step - 1;
			end
			else if (!next_cell_found) begin
				// if (next_out_of_bound || next_visited) i_th_step <= i_th_step;
				i_th_step <= i_th_step;
			end
			else begin
				i_th_step <= i_th_step + 1;
			end
		end
		S_OUTPUT: begin
			if (next_state == S_RESET) begin
				i_th_step <= 0;
			end
			else begin
				i_th_step <= i_th_step;
			end
		end
		default: i_th_step <= i_th_step;
		endcase
	end
end

always@(posedge clk or negedge rst_n) begin
	// 0: not walked, 1: walked
	if(!rst_n) cell_walked <= 0;
	else begin
		case (current_state)
		S_RESET: begin
			if (next_state == S_INPUT)  cell_walked[in_x*5 + in_y] <= 1'b1;
			else                        cell_walked <= cell_walked;
		end
		S_INPUT	: begin
			if (in_valid) cell_walked[in_x*5 + in_y] <= 1'b1;
			else          cell_walked <= cell_walked;
		end
		S_WALK	: begin
			if (backtrack_f) begin
				// curr_cell_i now is pointing to the previous cell
				cell_walked[curr_cell_i] <= 1'b0;
			end
			else if (next_visited) begin
				cell_walked[curr_cell_i] <= cell_walked[curr_cell_i];
			end
			else begin
				cell_walked[curr_cell_i] <= 1'b1;
			end
		end
		S_OUTPUT: begin
			if (next_state == S_RESET) begin
				cell_walked <= 0;
			end
			else begin
				cell_walked <= cell_walked;
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
			if (i_th_step + 1 == move_num_r) next_state = S_WALK;
			else if (in_valid)               next_state = S_INPUT;
			else                             next_state = S_WALK;
		end
		S_WALK: begin
			if (walk_finished) next_state = S_OUTPUT;
			else               next_state = S_WALK;
		end
		S_OUTPUT: begin
			if (move_out < 25) next_state = S_OUTPUT;
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
	else begin
		// $display("(prev_x,prev_y)=(%d,%d), (curr_x,curr_y)=(%d,%d), i_th_step=%d, (next_x,next_y)=(%d,%d), next_found=%d, backtrack_f=%d, priority_num_r=%d, curr_dir=%d, next_dir=%d, curr_state=%d, next_state=%d, move_num=%d, (in_x,in_y)=(%d,%d)", prev_x, prev_y, curr_x, curr_y, i_th_step, next_x, next_y, next_cell_found, backtrack_f, priority_num_r, curr_dir, next_dir, current_state, next_state, move_num_r, in_x, in_y);
		case (current_state)
		S_WALK: begin
			if (next_state == S_OUTPUT) begin
				out_x <= x[0+:(CELL_WIDTH-1)];  // x[0+:(4-1)] for not taking the sign bit
				out_y <= y[0+:(CELL_WIDTH-1)];
			end
			else begin
				out_x <= out_x;
				out_y <= out_y;
			end
		end
		S_OUTPUT: begin
			if (out_valid) begin
				out_x <= x[CELL_WIDTH*(move_out) +: (CELL_WIDTH-1)];  // x[0+:(4-1)] for not taking the sign bit
				out_y <= y[CELL_WIDTH*(move_out) +: (CELL_WIDTH-1)];
			end
			else if (next_state == S_RESET) begin
				out_x <= 0;
				out_y <= 0;
			end
			else begin
				out_x <= out_x;
				out_y <= out_y;
			end
		end
		default: begin
			out_x <= 0;
			out_y <= 0;
		end
		endcase
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		out_valid <= 0;
	end
	else if (current_state == S_OUTPUT) begin
		if (move_out == 25 || next_state == S_RESET) begin
			out_valid <= 0;
		end
		else begin
			out_valid <= 1;
		end
	end
	else begin
		out_valid <= out_valid;
	end
end

always@(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		move_out <= 0;
	end
	else if (current_state == S_OUTPUT) begin
		if (move_out == 25 || next_state == S_RESET) begin
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