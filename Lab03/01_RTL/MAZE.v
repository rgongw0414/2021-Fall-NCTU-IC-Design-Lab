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
parameter DATA_WIDTH = 5; // 5 bits for x and y (0 to 31)
parameter MAZE_WIDTH = 17; // 17x17 maze
parameter MAZE_SIZE  = MAZE_WIDTH * MAZE_WIDTH; // The maze consists of 289 (17x17) cells
parameter STATE_WIDTH = 2; // 2 bits for the FSM state
parameter QUEUE_DEPTH = 16; // The depth of the queue

// Primary FSM States
parameter S_RESET  = 2'd0;
parameter S_INPUT  = 2'd1;
parameter S_WALK   = 2'd2;
parameter S_OUTPUT = 2'd3;

// Directions
parameter RIGHT    = 2'd0;
parameter DOWN     = 2'd1;
parameter LEFT     = 2'd2;
parameter UP       = 2'd3;

//****************************************************************//
// Input/Output Declaration
//****************************************************************//
input clk, rst_n, in_valid, in;
output reg out_valid; // Pull up when the BFS is finished, and the parents array is reversed
output reg [DIR_WIDTH-1:0] out;

//*****************************************************************//
// Regs
//****************************************************************//
reg [MAZE_WIDTH-1:0]  maze   [MAZE_WIDTH-1:0];   // 17x17 maze
reg [DIR_WIDTH-1:0]   prev_x [MAZE_WIDTH-1:0][MAZE_WIDTH-1:0]; // The parents array storing the dir to the previous cell in the BFS walk
reg [DATA_WIDTH-1:0]  curr_x, curr_y; // Current position in the maze
reg [STATE_WIDTH-1:0] curr_state, next_state;
reg [DIR_WIDTH-1:0]   curr_dir; // Current direction in the maze
reg [1:0]             offset_x, offset_y; // Offset for the next cell in the maze

// Loop variables
reg [$clog2(MAZE_WIDTH)-1:0] i, j; // Index for maze

// Queue variables
reg enq_valid, deq_ready;

//*****************************************************************//
// Wires
//****************************************************************//
wire walk_finished;
wire [DATA_WIDTH-1:0] next_x, next_y;
wire [DIR_WIDTH-1:0] next_dir;
wire curr_y_reached_N;

// Queue variables
wire q_full, q_empty;
wire [(DATA_WIDTH)*2-1:0] enq_data, deq_data; // Concatenation of x and y for the queue

//*****************************************************************//
// Assigns
//****************************************************************//
assign walk_finished = (curr_x == MAZE_WIDTH - 1 && curr_y == MAZE_WIDTH - 1);
assign next_x = curr_x + offset_x;
assign next_y = curr_y + offset_y;
assign curr_y_reached_N = (curr_y == MAZE_WIDTH - 1);
assign enq_data = {next_x, next_y}; // Concatenate x and y for the queue

//****************************************************************//
// Module Declaration
//****************************************************************//
`include "QUEUE.v" // Include the QUEUE module for BFS implementation
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
        // else begin
        //     for (int i = 0; i < MAZE_WIDTH; i = i + 1) begin
        //         for (int j = 0; j < MAZE_WIDTH; j = j + 1) begin
        //             maze[i][j] <= 0;
        //         end
        //     end
        // end
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
                    if (next_state == S_WALK) begin
                        curr_x <= 0;
                    end
                    else begin
                        curr_x <= curr_x + 1;
                    end
                end
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
                if (curr_y_reached_N) begin
                    if (next_state == S_WALK) begin
                        curr_y <= 0;
                    end
                    else begin
                        curr_y <= 0;
                    end
                end
                else begin
                    curr_y <= curr_y + 1;
                end
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
            if (walk_finished) begin
                curr_dir <= RIGHT;
            end
            else begin
                curr_dir <= next_dir;
            end
        end
        endcase
    end
end

always@(*) begin // RIGHT: 0, DOWN: 1, LEFT: 2, UP: 3
    if (curr_dir == RIGHT) begin
        next_dir = DOWN;
    end
    else if (curr_dir == DOWN) begin
        next_dir = LEFT;
    end
    else if (curr_dir == LEFT) begin
        next_dir = UP;
    end
    else if (curr_dir == UP) begin
        next_dir = RIGHT;
    end
    else begin // should not happen, because curr_dir is 2-bit long
        next_dir = RIGHT;
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
            out <= prev_x[curr_x][curr_y];
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
                next_state = S_OUTPUT;
            end
            else begin
                next_state = S_WALK;
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
