//================================================================
// Author: Gong-Chi Wang (王公志)
// NCTU IC Lab Exercise #1
//================================================================
//   File Name   : sort.v
//   Module Name : Sort
//   Description : Sort the input signals (ID/Gm) in ascending order, *with combination logic only, i.e., no clk*
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
module Sort(
    // Input signals
    in0, in1, in2, in3, in4, in5,
    mode,
    // Output signals
    out0, out1, out2
);
input [6:0] in0, in1, in2, in3, in4, in5;
input mode; // 0: Ascending, 1: Descending
output [6:0] out0, out1, out2;

reg [6:0] max1, max2, max3; // The top-3 ID/Gm, where max1 > max2 > max3
reg [6:0] min1, min2, min3; // The top-3 ID/Gm, where min1 < min2 < min3

assign out0 = (mode == 0) ? max1 : min3;
assign out1 = (mode == 0) ? max2 : min2;
assign out2 = (mode == 0) ? max3 : min1;

always@(*) begin
    // Default assignment for avoiding X value
    max1 = max1;
    max2 = max2;
    max3 = max3;
    min1 = min1;
    min2 = min2;
    min3 = min3;
    if (mode == 0) begin  // Sort the input signals in ascending order
        if (in0 > in1) begin
            max1 = in0;
            max2 = in1;
        end
        else begin
            max1 = in1;
            max2 = in0;
        end

        if (in2 > max1) begin
            //     in2 > max1 > max2 
            // -> max1 > max2 > max3
            max3 = max2;
            max2 = max1;
            max1 = in2;
        end
        else if (in2 > max2) begin
            //     in2 > max2
            //    max1 > max2 
            max3 = max2;
            if (in2 > max1) begin
                max2 = max1;
                max1 = in2;
            end
            else begin
                max2 = in2;
            end
        end
        else if (in2 > max3) begin
            max3 = in2;
        end
        // else begin
        //   we have default assignment for max3, max2, max1, so no need to assign again
        // end

        if (in3 > max1) begin
            max3 = max2;
            max2 = max1;
            max1 = in3;
        end
        else if (in3 > max2) begin
            //     in3 > max2
            //    max1 > max2
            max3 = max2;
            if (in3 > max1) begin
                max2 = max1;
                max1 = in3;
            end
            else begin
                max2 = in3;
            end
        end
        else if (in3 > max3) begin
            max3 = in3;
        end
        // else begin
        //   we have default assignment for max3, max2, max1, so no need to assign again
        // end

        if (in4 > max1) begin
            max3 = max2;
            max2 = max1;
            max1 = in4;
        end
        else if (in4 > max2) begin
            //     in4 > max2
            //    max1 > max2
            max3 = max2;
            if(in4 > max1) begin
                max2 = max1;
                max1 = in4;
            end
            else begin
                max2 = in4;
            end
        end
        else if (in4 > max3) begin
            max3 = in4;
        end
        // else begin
        //   we have default assignment for max3, max2, max1, so no need to assign again
        // end

        if(in5 > max1) begin
            max3 = max2;
            max2 = max1;
            max1 = in5;
        end
        else if(in5 > max2) begin
            //     in5 > max2
            //    max1 > max2
            max3 = max2;
            if(in5 > max1) begin
                max2 = max1;
                max1 = in5;
            end
            else begin
                max2 = in5;
            end
        end
        else if(in5 > max3) begin
            max3 = in5;
        end
    end
    // Sort the input signals in descending order
    else begin
        if (in0 < in1) begin
            min1 = in0;
            min2 = in1;
        end
        else begin
            min1 = in1;
            min2 = in0;
        end

        if (in2 < min1) begin
            min3 = min2;
            min2 = min1;
            min1 = in2;
        end
        else if (in2 < min2) begin
            //    in2 < min2
            //   min1 < min2
            min3 = min2;
            if (in2 < min1) begin
                min2 = min1;
                min1 = in2;
            end
            else begin
                min2 = in2;
            end
        end
        else if (in2 < min3) begin
            min3 = in2;
        end
        // else begin
        //   we have default assignment for min1, min2, min1, so no need to assign again
        // end

        if (in3 < min1) begin
            min3 = min2;
            min2 = min1;
            min1 = in3;
        end
        else if (in3 < min2) begin
            //    in3 < min2
            //   min1 < min2
            min3 = min2;
            if (in3 < min1) begin
                min2 = min1;
                min1 = in3;
            end
            else begin
                min2 = in3;
            end
        end
        else if (in3 < min3) begin
            min3 = in3;
        end
        // else begin
        //   we have default assignment for min1, min2, min1, so no need to assign again
        // end

        if (in4 < min1) begin
            min3 = min2;
            min2 = min1;
            min1 = in4;
        end
        else if (in4 < min2) begin
            //    in4 < min2
            //   min1 < min2
            min3 = min2;
            if (in4 < min1) begin
                min2 = min1;
                min1 = in4;
            end
            else begin
                min2 = in4;
            end
        end
        else if (in4 < min3) begin
            min3 = in4;
        end
        // else begin
        //   we have default assignment for min1, min2, min1, so no need to assign again
        // end

        if (in5 < min1) begin
            min3 = min2;
            min2 = min1;
            min1 = in5;
        end
        else if (in5 < min2) begin
            //    in5 < min2
            //   min1 < min2
            min3 = min2;
            if (in5 < min1) begin
                min2 = min1;
                min1 = in5;
            end
            else begin
                min2 = in5;
            end
        end
        else if (in5 < min3) begin
            min3 = in5;
        end
        // else begin
        //   we have default assignment for min1, min2, min1, so no need to assign again
        // end
    end
end

endmodule
