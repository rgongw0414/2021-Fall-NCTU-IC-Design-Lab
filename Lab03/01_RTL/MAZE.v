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
parameter DIR_WIDTH  = 2;
parameter DATA_WIDTH = 6; // 6 signed bits for x and y (-32 to 31)
parameter MAZE_WIDTH = 17; // 17x17 maze
parameter MAZE_SIZE  = MAZE_WIDTH * MAZE_WIDTH; // The maze consists of 289 (17x17) cells
parameter STATE_WIDTH = 3; // For FSM state
parameter QUEUE_DEPTH = 16; // The depth of the queue

// Primary FSM States
parameter [STATE_WIDTH-1:0] S_RESET  = 'd0;
parameter [STATE_WIDTH-1:0] S_INPUT  = 'd1;
parameter [STATE_WIDTH-1:0] S_WALK   = 'd2;
parameter [STATE_WIDTH-1:0] S_BACK   = 'd3;
parameter [STATE_WIDTH-1:0] S_OUTPUT = 'd4;

// Directions
parameter [DIR_WIDTH-1:0] RIGHT    = 2'd0;
parameter [DIR_WIDTH-1:0] DOWN     = 2'd1;
parameter [DIR_WIDTH-1:0] LEFT     = 2'd2;
parameter [DIR_WIDTH-1:0] UP       = 2'd3;

//****************************************************************//
// Input/Output Declaration
//****************************************************************//
input clk, rst_n, in_valid, in;
output reg out_valid; // Pull up when the BFS is finished, and the parents array is reversed
output reg [DIR_WIDTH-1:0] out;

//*****************************************************************//
// Regs
//****************************************************************//
reg signed [DATA_WIDTH-1:0] curr_x, curr_y; // Current position in the maze
reg signed [1:0]            offset_x, offset_y; // Offset for the next cell in the maze
reg [MAZE_WIDTH-1:0]        maze      [MAZE_WIDTH-1:0];   // 17x17 maze
reg [DIR_WIDTH:0]           prev_dirs [MAZE_WIDTH-1:0][MAZE_WIDTH-1:0]; // The parents array storing the dir to the previous cell in the BFS walk
reg [STATE_WIDTH-1:0]       curr_state, next_state;
reg [DIR_WIDTH-1:0]         curr_dir, next_dir; // Current direction in the maze

// Loop variables
reg [$clog2(MAZE_WIDTH)-1:0] i, j; // Index for maze

// Queue variables

//*****************************************************************//
// Wires
//****************************************************************//
wire walk_finished;
wire signed [DATA_WIDTH-1:0] next_x, next_y;
wire next_is_start;
wire curr_y_reached_N;
wire next_is_wall, next_is_visited, next_is_oob, next_is_valid;
wire backtrack_finished;

// Queue variables
wire signed [DATA_WIDTH-1:0] deq_x, deq_y; // Dequeue x and y from the queue
wire [(DATA_WIDTH)*2-1:0]    enq_data, deq_data; // Concatenation of x and y for the queue
wire q_full, q_empty;
wire enq_valid, deq_ready;

//*****************************************************************//
// Assigns
//****************************************************************//
assign walk_finished    = (curr_x == MAZE_WIDTH - 1 && curr_y == MAZE_WIDTH - 1); // TODO: This might better be a register to indicate now is backtracking
assign curr_y_reached_N = (curr_y == MAZE_WIDTH - 1);
assign next_x = curr_x + offset_x;
assign next_y = curr_y + offset_y;
assign next_is_oob     = (next_x < 0 || next_x >= MAZE_WIDTH || next_y < 0 || next_y >= MAZE_WIDTH);
assign next_is_wall    = (!next_is_oob && maze[next_x][next_y] == 0);
assign next_is_start   = (next_x == 0 && next_y == 0); // Check if the next cell is the starting point
assign next_is_visited = ((!next_is_oob && prev_dirs[next_x][next_y] != 7) || next_is_start); // 7 means not visited
assign next_is_valid   = (!next_is_oob && !next_is_visited && !next_is_wall);
assign backtrack_finished = (curr_state == S_BACK && next_is_start);
assign enq_data = {next_x, next_y}; // Concatenate x and y for enqueue
assign {deq_x, deq_y} = deq_data; // Dequeue x and y from the queue
assign enq_valid = (next_is_valid && !q_full); // Enqueue only if the next cell is valid and the queue is not full
assign deq_ready = (curr_dir == UP && !q_empty); // Dequeue only if the current direction is UP and the queue is not empty

//****************************************************************//
// Module Declaration
//****************************************************************//
QUEUE #(
    .DATA_WIDTH(DATA_WIDTH*2), // 2*DATA_WIDTH for the concatenation of x and y
    .DEPTH(QUEUE_DEPTH),
    .ADDR_WIDTH($clog2(QUEUE_DEPTH))
) Q (
    .clk(clk),
    .rst_n(rst_n),
    .enq_valid(enq_valid),
    .enq_data(enq_data),
    .full(q_full),
    .deq_ready(deq_ready),
    .deq_data(deq_data),
    .empty(q_empty)
);

//*****************************************************************//
// Always Blocks
//****************************************************************//

//******************************************//
// 1. Direction Logic
//******************************************//
always@(*) begin
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

// Store input data into maze
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
        endcase
    end
end

//******************************************//
// 1-2. curr_dir and next_dir Logic
//******************************************//
always@(posedge clk or negedge rst_n) begin // RIGHT: 0, DOWN: 1, LEFT: 2, UP: 3
    if (!rst_n) begin
        curr_dir <= RIGHT; 
    end
    else begin
        case (curr_state)
        S_WALK: begin
            curr_dir <= curr_dir + 1;
            // if (next_is_valid) begin
            //     curr_dir <= next_dir;
            // end
            // else begin
            //     curr_dir <= curr_dir;
            // end
        end
        endcase
    end
end

// always@(*) begin // RIGHT: 0, DOWN: 1, LEFT: 2, UP: 3
//     // TODO: Optimization by skipping the parent direction
//     // if (!next_is_valid) begin
//     //     next_dir = DOWN;
//     // end
//     if (curr_dir == RIGHT) begin
//         next_dir = DOWN;
//     end
//     else if (curr_dir == DOWN) begin
//         next_dir = LEFT;
//     end
//     else if (curr_dir == LEFT) begin
//         next_dir = UP;
//     end
//     else if (curr_dir == UP) begin
//         next_dir = RIGHT;
//     end
//     else begin // should not happen, because curr_dir is 2-bit long
//         next_dir = RIGHT;
//     end
// end

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
                    prev_dirs[next_x][next_y] <= curr_dir;
                end
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
        out <= 0;
    end
    else begin
        if (curr_state == S_OUTPUT) begin
            out_valid <= 1;
            out <= prev_dirs[curr_x][curr_y];
        end
        else begin
            out_valid <= 0;
            out <= 0;
        end
    end
end

//******************************************//
// FSM 
//******************************************//
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        curr_state <= S_RESET;
    end
    else begin
        curr_state <= next_state;
    end
end

always@(*) begin
    case (curr_state)
        S_RESET: begin
            if (in_valid) next_state = S_INPUT;
            else          next_state = S_RESET;
        end
        S_INPUT: begin
            if (in_valid) begin
                if (walk_finished) begin // Check if the target cell (16,16) is reached
                    next_state = S_WALK;
                end
                else begin
                    next_state = S_INPUT;
                end
            end
            else begin
                next_state = S_WALK;
            end
        end
        S_WALK: begin
            if (walk_finished) begin
                next_state = S_BACK;
            end
            else begin
                next_state = S_WALK;
            end
        end
        S_BACK: begin
            if (backtrack_finished) begin
                next_state = S_OUTPUT;
            end
            else begin
                next_state = S_BACK;
            end
        end
        S_OUTPUT: begin
            if (out_valid) begin
                next_state = S_OUTPUT;
            end
            else begin
                next_state = S_RESET;
            end
        end
        default: next_state = S_RESET;
    endcase
end
endmodule
