module F_DIV(
    input wire clk_in,
    input wire rst,
    output reg clk_out_2x,   // 2x clock
    output wire clk_out_3x,  // 3x clock
    output reg clk_out_4x,   // 4x clock
    output wire clk_out_5x   // 5x clock
);
    // 2x clock
    always@(posedge clk_in) begin
        if (rst) begin
            clk_out_2x <= 1'b0;
        end
        else begin
            clk_out_2x <= ~clk_out_2x;
        end
    end

    // 3x clock
    reg [1:0] cnt_3x_rising, cnt_3x_falling;
    reg clk_3x_rising, clk_3x_falling; // each of them is HIGH for 1 clock cycle, but mismatched by half a cycle
    assign clk_out_3x = clk_3x_rising | clk_3x_falling; // hence, by ORing them, we get a 3x clock
    always @(posedge clk_in) begin
        if (rst) begin
            cnt_3x_rising <= 2'b00;
            clk_3x_rising <= 1'b0;
        end
        else begin
            
            if (cnt_3x_rising == 2'b10) begin
                clk_3x_rising <= 1'b1;
                cnt_3x_rising <= 2'b00;
            end
            else begin
                clk_3x_rising <= 1'b0;
                cnt_3x_rising <= cnt_3x_rising + 1;
            end
        end
    end
    always@(negedge clk_in) begin
        if (rst) begin
            cnt_3x_falling <= 2'b00;
            clk_3x_falling <= 1'b0;
        end
        else begin
            if (cnt_3x_falling == 2'b10) begin
                clk_3x_falling <= 1;
                cnt_3x_falling <= 2'b00;
            end
            else begin
                clk_3x_falling <= 0;
                cnt_3x_falling <= cnt_3x_falling + 1;
            end
        end
    end
    
    // 4x clock
    reg cnt_4x;
    always @(posedge clk_in) begin
        if (rst) begin
            clk_out_4x <= 1'b0;
            cnt_4x <= 1'b0;
        end
        else begin
            if (cnt_4x) begin
                clk_out_4x <= ~clk_out_4x;
                cnt_4x <= 1'b0;
            end
            else begin
                clk_out_4x <= clk_out_4x;
                cnt_4x <= 1'b1;
            end
        end
    end

    // 5x clock
    reg [2:0] cnt_5x_rising, cnt_5x_falling;
    reg clk_5x_rising, clk_5x_falling; // each of them is HIGH for 2 cycles, but mismatched by half a cycle
    assign clk_out_5x = clk_5x_rising | clk_5x_falling; // hence, by ORing them, we get a 5x clock
    always @(posedge clk_in) begin
        if (rst) begin
            cnt_5x_rising <= 3'b000;
            clk_5x_rising <= 1'b0;
        end
        else begin
            if (cnt_5x_rising == 3'b011) begin
                clk_5x_rising <= 1'b1;
                cnt_5x_rising <= cnt_5x_rising + 1;
            end
            else if (cnt_5x_rising == 3'b100) begin
                clk_5x_rising <= 1'b1;
                cnt_5x_rising <= 3'b000;
            end
            else begin
                clk_5x_rising <= 1'b0;
                cnt_5x_rising <= cnt_5x_rising + 1;
            end
        end
    end
    always @(negedge clk_in) begin
        if (rst) begin
            cnt_5x_falling <= 3'b000;
            clk_5x_falling <= 1'b0;
        end
        else begin
            if (cnt_5x_falling == 3'b011) begin
                clk_5x_falling <= 1'b1;
                cnt_5x_falling <= cnt_5x_falling + 1;
            end
            else if (cnt_5x_falling == 3'b100) begin
                clk_5x_falling <= 1'b1;
                cnt_5x_falling <= 3'b000;
            end
            else begin
                clk_5x_falling <= 1'b0;
                cnt_5x_falling <= cnt_5x_falling + 1;
            end
        end
    end

endmodule