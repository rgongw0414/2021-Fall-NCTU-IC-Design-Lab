module F_DIV(
    input wire clk_in,
    input wire rst,
    output reg clk_out_2x, // 2x clock
    output wire clk_out_3x,  // 3x clock
    output reg clk_out_4x // 4x clock
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
    reg [1:0] count_rising, count_faling;
    reg clk_rising, clk_faling; // each of them is HIGH for 1 clock cycle, but mismatched by half a cycle
    assign clk_out_3x = clk_rising | clk_faling; // hence, by ORing them, we get a 3x clock
    always @(posedge clk_in) begin
        if (rst) begin
            count_rising <= 2'b00;
            clk_rising <= 1'b0;
        end
        else begin
            
            if (count_rising == 2'b10) begin
                clk_rising <= 1'b1;
                count_rising <= 2'b00;
            end
            else begin
                clk_rising <= 1'b0;
                count_rising <= count_rising + 1;
            end
        end
    end
    always@(negedge clk_in) begin
        if (rst) begin
            count_faling <= 2'b00;
            clk_faling <= 1'b0;
        end
        else begin
            if (count_faling == 2'b10) begin
                clk_faling <= 1;
                count_faling <= 2'b00;
            end
            else begin
                clk_faling <= 0;
                count_faling <= count_faling + 1;
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

endmodule