`include "QUEUE.v" // Include the QUEUE module for BFS implementation

module MAZE (
    // Input
	clk,
	rst_n,
	in_valid,
	in,
    // Output
	out_valid,
	out
);

//****************************************************************//
// Parameter Declaration
//****************************************************************//
parameter MAZE_WIDTH   = 17; // 17x17 maze
parameter MAZE_SIZE    = MAZE_WIDTH * MAZE_WIDTH; // The maze consists of 289 (17x17) cells
parameter OFFSET_WIDTH = 2;  // 2 signed bits for offset_x & offset_y (-1 to 1) to the next cell
parameter DATA_WIDTH   = 6;  // 6 signed index bits for x and y (-32 to 31)

// Primary FSM States
parameter  STATE_WIDTH = 3;  // For FSM state encoding (5 states)
parameter [STATE_WIDTH-1:0] S_RESET  = 'd0;
parameter [STATE_WIDTH-1:0] S_INPUT  = 'd1;
parameter [STATE_WIDTH-1:0] S_WALK   = 'd2;
parameter [STATE_WIDTH-1:0] S_BACK   = 'd3;
parameter [STATE_WIDTH-1:0] S_OUTPUT = 'd4;

// Directions
parameter  DIR_WIDTH = 2;  // 2 bits for direction (right, down, left, up)
parameter [DIR_WIDTH-1:0] RIGHT    = 2'd0;
parameter [DIR_WIDTH-1:0] DOWN     = 2'd1;
parameter [DIR_WIDTH-1:0] LEFT     = 2'd2;
parameter [DIR_WIDTH-1:0] UP       = 2'd3;

// Backtracking variables
parameter QUEUE_DATA_WIDTH = DATA_WIDTH * 2; // 2*DATA_WIDTH for the concatenation of x and y
parameter MAX_STEPS   = 150; // Maximum number of steps taken to reach the goal (16,16); for PATTERN_NUM of 500, this is enough
parameter QUEUE_DEPTH = 16;  // The depth (max size) of the queue

//****************************************************************//
// Input/Output Declaration
//****************************************************************//
input clk, rst_n, in_valid, in;
output reg out_valid; // Pull up when the BFS is finished, and the parents array is reversed
output [DIR_WIDTH-1:0] out;

//*****************************************************************//
// Regs
//****************************************************************//
reg signed [DATA_WIDTH-1:0]   curr_x, curr_y; // Current position in the maze
reg signed [OFFSET_WIDTH-1:0] offset_x, offset_y; // Offset for the next cell in the maze
reg [MAZE_WIDTH-1:0]          maze      [MAZE_WIDTH-1:0];   // 17x17 maze
reg [DIR_WIDTH:0]             prev_dirs [MAZE_WIDTH-1:0][MAZE_WIDTH-1:0]; // The parents array storing the dir to the previous cell in the BFS walk
reg [STATE_WIDTH-1:0]         curr_state, next_state;
reg [DIR_WIDTH-1:0]           curr_dir; // Current direction in the maze

// Loop variables
reg [$clog2(MAX_STEPS)-1:0] i, j; // Index for maze

// Backtracking variables
reg [DIR_WIDTH-1:0]         backtrack_dirs [MAX_STEPS-1:0];
reg [$clog2(MAX_STEPS)-1:0] backtrack_idx; // Index for saving the backtrack directions
reg backtrack_finished;

//*****************************************************************//
// Wires
//****************************************************************//
wire walk_finished;
wire signed [DATA_WIDTH-1:0] next_x, next_y;
wire curr_is_start, next_is_start;
wire curr_y_reached_N;
wire next_is_wall, next_is_visited, next_is_oob, next_is_valid;

// Queue variables
wire signed [DATA_WIDTH-1:0] deq_x, deq_y; // Dequeue x and y from the queue
wire [(DATA_WIDTH)*2-1:0]    enq_data, deq_data; // Concatenation of x and y for the queue
wire full, empty;
wire enq_valid, deq_ready;

//*****************************************************************//
// Assigns
//****************************************************************//
// Current cell logic
assign walk_finished    = (curr_x == MAZE_WIDTH - 1 && curr_y == MAZE_WIDTH - 1); // TODO: This might better be a register to indicate now is backtracking
assign curr_y_reached_N = (curr_y == MAZE_WIDTH - 1);
assign curr_is_start   = (curr_x == 0 && curr_y == 0);

// Next cell logic
assign next_x = curr_x + offset_x;
assign next_y = curr_y + offset_y;
assign next_is_oob     = (next_x < 0 || next_x >= MAZE_WIDTH || next_y < 0 || next_y >= MAZE_WIDTH);
assign next_is_wall    = (!next_is_oob && maze[next_x][next_y] == 0);
assign next_is_start   = (next_x == 0 && next_y == 0); // Check if the next cell is the starting point
assign next_is_visited = ((!next_is_oob && prev_dirs[next_x][next_y] != 7) || next_is_start); // 7 means not visited
assign next_is_valid   = (!next_is_oob && !next_is_visited && !next_is_wall);

// Queue (Solve & Backtrack) Logic
assign {deq_x, deq_y} = deq_data; // Dequeue x and y from the queue
/* 1. Dequeue only if curr_dir is UP and the queue is not empty
 * 2. Clean up the queue while backtracking  */
assign deq_ready = (curr_state == S_WALK && curr_dir == UP && !empty) || (curr_state == S_BACK && 1'b1); 
assign enq_data = {next_x, next_y}; // Concatenate x and y for enqueue
assign enq_valid = (curr_state == S_WALK && next_is_valid && !full); // Enqueue only if the next cell is valid and the queue is not full
assign out = backtrack_dirs[backtrack_idx];

//****************************************************************//
// Module Declaration
//****************************************************************//
QUEUE #(
    .DATA_WIDTH(QUEUE_DATA_WIDTH), // 2*DATA_WIDTH for the concatenation of x and y
    .DEPTH(QUEUE_DEPTH)
) Q (
    .clk(clk),
    .rst_n(rst_n),
    .enq_valid(enq_valid),
    .enq_data(enq_data),
    .full(full),
    .deq_ready(deq_ready),
    .deq_data(deq_data),
    .empty(empty)
);

//*****************************************************************//
// Always Blocks
//****************************************************************//

//******************************************//
// 1. Direction Logic
//******************************************//
always@(*) begin
    if (next_state == S_BACK) begin // When going back, the offsets are reversed
        if (curr_dir == RIGHT) begin 
            offset_x = 0;
            offset_y = -1;
        end
        else if (curr_dir == DOWN) begin
            offset_x = -1;
            offset_y = 0;
        end
        else if (curr_dir == LEFT) begin
            offset_x = 0;
            offset_y = 1;
        end
        else if (curr_dir == UP) begin
            offset_x = 1;
            offset_y = 0;
        end
        else begin // should not happen, because curr_dir is 2-bit long
            offset_x = 0;
            offset_y = 0;
        end
    end
    else begin // When solving the maze, the offsets are as normal
        if (curr_dir == RIGHT) begin
            offset_x = 0;
            offset_y = 1;
        end
        else if (curr_dir == DOWN) begin
            offset_x = 1;
            offset_y = 0;
        end
        else if (curr_dir == LEFT) begin
            offset_x = 0;
            offset_y = -1;
        end
        else if (curr_dir == UP) begin
            offset_x = -1;
            offset_y = 0;
        end
        else begin // should not happen, because curr_dir is 2-bit long
            offset_x = 0;
            offset_y = 0;
        end
    end
end

// Store input data (0 for wall, 1 for path) into maze
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < MAZE_WIDTH; i = i + 1) begin
            for (j = 0; j < MAZE_WIDTH; j = j + 1) begin
                maze[i][j] <= 0;
            end
        end
    end
    else begin
        if (in_valid) begin
            maze[curr_x][curr_y] <= in;
        end
    end
end

//******************************************//
// 1-1. curr_x and curr_y Logic
//******************************************//
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        curr_x <= 0;
    end
    else begin
        case (curr_state)
        S_INPUT: begin
            if (in_valid) begin
                if (curr_y_reached_N) begin
                    curr_x <= (next_state == S_WALK) ? 0 : curr_x + 1;
                end
            end
        end
        S_WALK: begin
            if (deq_ready) begin
                curr_x <= deq_x;
            end
        end
        S_BACK: begin
            if (backtrack_finished) begin
                curr_x <= 0;
            end
            else begin
                curr_x <= next_x;
            end
        end
        endcase
    end
end

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        curr_y <= 0;
    end
    else begin
        case (curr_state) 
        S_RESET: begin
            if (next_state == S_INPUT) begin
                curr_y <= curr_y + 1;
            end
        end
        S_INPUT: begin
            if (in_valid) begin
                curr_y <= (curr_y_reached_N) ? 0 : curr_y + 1;
            end
        end
        S_WALK: begin
            if (deq_ready) begin
                curr_y <= deq_y;
            end
        end
        S_BACK: begin
            if (backtrack_finished) begin
                curr_y <= 0;
            end
            else begin
                curr_y <= next_y;
            end
        end
        endcase
    end
end

//******************************************//
// 1-2. curr_dir Logic (For both forward and backward)
//******************************************//
always@(posedge clk or negedge rst_n) begin // RIGHT: 0, DOWN: 1, LEFT: 2, UP: 3
    if (!rst_n) begin
        curr_dir <= RIGHT; 
    end
    else begin
        case (curr_state)
        S_WALK: begin
            if (next_state == S_BACK) begin
                // prev_dirs[i][j] is one bit longer than curr_dir, so pad it with 0
                curr_dir <= prev_dirs[MAZE_WIDTH-1][MAZE_WIDTH-1][DIR_WIDTH-1:0]; // Set curr_dir to the direction of the last cell in the maze
            end
            else begin
                curr_dir <= curr_dir + 1;
            end
        end
        S_BACK: begin
            // $display("curr_x: %d, curr_y: %d, curr_dir: %d", curr_x, curr_y, curr_dir);
            if (next_is_start) begin
                curr_dir <= 0; // Reset to the initial direction when backtracking to the start
            end
            else begin
                curr_dir <= prev_dirs[next_x][next_y][DIR_WIDTH-1:0]; // Set to the dir of the parent cell of the current cell
            end
        end
        default: begin
            curr_dir <= RIGHT; 
        end
        endcase
    end
end

//****************************************************//
// 2. Forward Logic - Save the dirs to the parent cell
//****************************************************//
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < MAZE_WIDTH; i = i + 1) begin
            for (j = 0; j < MAZE_WIDTH; j = j + 1) begin
                prev_dirs[i][j] <= 7; // Initialize all directions to 7 (not visited before)
            end
        end
    end
    else begin
        case (curr_state) 
            S_WALK: begin
                if (next_is_valid) begin
                    prev_dirs[next_x][next_y] <= {1'b0, curr_dir};
                    // prev_dirs[next_x][next_y] <= curr_dir;
                end
            end
            S_OUTPUT: begin
                if (next_state == S_RESET) begin
                    for (i = 0; i < MAZE_WIDTH; i = i + 1) begin
                        for (j = 0; j < MAZE_WIDTH; j = j + 1) begin
                            prev_dirs[i][j] <= 7; // Initialize all directions to 7 (not visited before)
                        end
                    end
                end
            end
        endcase
    end
end

//****************************************************//
// 3-1. Backtrack: Check if next cell is (0,0)
//****************************************************//
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        backtrack_finished <= 0;
    end
    else begin
        case (curr_state)
            S_BACK: begin
                if ((next_is_start)) begin
                    backtrack_finished <= 1;
                end
            end
            S_OUTPUT: begin
                if (next_state == S_RESET) begin
                    backtrack_finished <= 0; // Reset backtrack_finished when outputting the result
                end
            end
        endcase
    end
end

//****************************************************//
// 3-2. Backtrack: Save the dirs from (16,16) to (0,0)
//****************************************************//
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < MAX_STEPS; i = i + 1) begin
            backtrack_dirs[i] <= 0;
        end
    end
    else begin
        case (curr_state)
            S_BACK: begin
                if (!backtrack_finished) begin
                    backtrack_dirs[backtrack_idx] <= curr_dir;
                end
            end
            S_OUTPUT: begin
                if (next_state == S_RESET) begin
                    for (i = 0; i < MAX_STEPS; i = i + 1) begin
                        backtrack_dirs[i] <= 0;
                    end
                end
            end
        endcase
    end
end

// Index for saving backtrack directions to backtrack_dirs
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        backtrack_idx <= 0;
    end
    else begin
        case (curr_state)
            S_BACK: begin
                if (!next_is_start && !backtrack_finished) begin
                    backtrack_idx <= backtrack_idx + 1;
                end
            end
            S_OUTPUT: begin
                backtrack_idx <= (backtrack_idx > 0) ? backtrack_idx - 1 : 0; // Decrement backtrack_idx when outputting the result
            end
        endcase
    end
end

//******************************************//
// Output Logic
//******************************************//
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_valid <= 0;
    end
    else begin
        case (curr_state)
            S_BACK: begin
                if (next_state == S_OUTPUT) begin
                    out_valid <= 1; // pull up out_valid as FSM goes in S_OUTPUT
                end
            end
            S_OUTPUT: begin 
                if (backtrack_idx == 0) begin
                    out_valid <= 0;
                end
            end
        endcase
    end
end

//******************************************//
// FSM 
//******************************************//
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) curr_state <= S_RESET;
    else        curr_state <= next_state;
end

always@(*) begin
    case (curr_state)
        S_RESET: begin
            if (in_valid) next_state = S_INPUT;
            else          next_state = S_RESET;
        end
        S_INPUT: begin
            if (in_valid) begin
                if (walk_finished) next_state = S_WALK; // Check if the target cell (16,16) is reached
                else               next_state = S_INPUT;
            end
            else next_state = S_WALK;
        end
        S_WALK: begin
            if (walk_finished) next_state = S_BACK;
            else               next_state = S_WALK;
        end
        S_BACK: begin
            if (backtrack_finished) next_state = S_OUTPUT;
            else                    next_state = S_BACK;
        end
        S_OUTPUT: begin
            if (out_valid) next_state = S_OUTPUT;
            else           next_state = S_RESET;
        end
        default: next_state = S_RESET;
    endcase
end
endmodule
