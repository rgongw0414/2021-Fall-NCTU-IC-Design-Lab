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

//****************************************************************//
// Input/Output Declaration
//****************************************************************//
input clk, rst_n, in_valid, in;
output reg out_valid; // Pull up when the BFS is finished, and the parents array is reversed
output reg [DIR_WIDTH-1:0] out;

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

//*****************************************************************//
// Regs
//****************************************************************//
reg [MAZE_WIDTH-1:0] maze [MAZE_WIDTH-1:0];   // 17x17 maze
reg [DIR_WIDTH-1:0][MAZE_WIDTH-1:0] prev_x [MAZE_WIDTH-1:0]; // The parents array storing the dir to the previous cell in the BFS walk
reg [DATA_WIDTH-1:0] curr_x, curr_y; // Current position in the maze
reg [DATA_WIDTH-1:0] next_x, next_y;
reg [1:0] curr_state;

//*****************************************************************//
// Wires
//****************************************************************//
wire [1:0] next_state;
wire walk_finished;

//*****************************************************************//
// Assigns
//****************************************************************//
assign walk_finished = (curr_x == MAZE_WIDTH - 1 && curr_y == MAZE_WIDTH - 1);


//*****************************************************************//
// Always Blocks
//****************************************************************//

// Store input data into maze
always@(posedge clk or negedge rst_n) begin
    if (!rst_n) maze <= 0;
    else begin
        if (in_valid) begin
            maze[curr_x][curr_y] <= in;
        end
        else begin
            maze <= maze;
        end
    end
end

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        curr_x <= 0;
        curr_y <= 0;
    end
    else begin
        case (curr_state) 
        S_INPUT: begin
            if (in_valid) begin
                if (curr_y == MAZE_WIDTH - 1) begin
                    if (next_state == S_WALK) begin
                        curr_x <= 0;
                        curr_y <= 0;
                    end
                    else begin
                        curr_x <= curr_x + 1;
                        curr_y <= 0;
                    end
                end
                else begin
                    curr_x <= curr_x;
                    curr_y <= curr_y + 1;
                end
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

//*****************************************************************//
// FSM 
//****************************************************************//
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
