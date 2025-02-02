# 2021-Fall-NCTU-IC-Design-Lab
What I Learned in each Lab
## Lab01 - Combinational Circuit
* To avoid synthesizing latches in comb always blocks, either **complete the conditional statements (if/else, case)**, or **assign default values to signals in the blocks**
* To prevent from overflowing, reserve enough bit-width for output signal
* Take care of unsigned/signed types, their range differ by 1 sign-bit; only when both numbers are signed, the calculation will be signed
* E.g., Lab01/Exercise/01_RTL/sort.v:
```verilog
always@(*) begin
    // Default assignment for avoiding X value or latches
    max1 = 0;
    max2 = 0;
    max3 = 0;
    min1 = 127;
    min2 = 127;
    min3 = 127;
    if (mode == 1) begin  // Sort the input signals in ascending order
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
end
```
* Default values of min/max regs
* Since only the top-3 max/min values are needed, so no need to sort the entire array
* Sorting algorithm excels in time complexity takes extra space. Implementing them in Verilog might take more registers, i.e., more area
