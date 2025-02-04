module KT(
    clk,
    rst_n,
    in_valid,
    in_x,
    in_y,
    move_num,
    priority_num,
    out_valid,
    out_x,
    out_y,
    move_out
);

input clk,rst_n;
input in_valid;
input [2:0] in_x,in_y;
input [4:0] move_num;
input [2:0] priority_num;

output reg out_valid;
output reg [2:0] out_x,out_y;
output reg [4:0] move_out;

// FSM States
parameter S_IDLE = 3'd0;
parameter S_INPUT = 3'd1;
parameter S_WALK = 3'd2;
parameter S_OUTPUT = 3'd3;

parameter CELL_NUM = 25; // 5x5 cells

reg [74:0] cell_dir; // 75=25*3: the walk direction of the 25 cells (3-bit each, i.e., 0~7), except for the last cell, each cell has one of the 8 directions to walk
reg [0:24] cell_walked; // the flag to indicate whether the cell has been walked

genvar i_dir;
generate
	for (i_dir=0; i_dir<CELL_NUM; i_dir=i_dir+1) begin: cell_dir
		always@(posedge clk or negedge rst_n) begin
			if(!rst_n) begin
				cell_dir[3*i_dir +: 3] = 0;
			end
			else begin
				// Walk to next cell
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
		state <= RESET;
	end
	else begin
		state <= n_state;
	end
end

//FSM next state assignment
always@(*) begin
	case(state)
		
		RESET: begin
			n_state = 
		end
		
		
		default: begin
			n_state = 
		end
	
	endcase
end 

//Output assignment
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		
	end
	else if( ) begin
		
	end
	else begin
		
	end
end

// Walk to next cell

endmodule
