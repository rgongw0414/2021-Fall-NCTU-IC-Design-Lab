`timescale 1ns/1ps

module tb;
    string VCD_FILE = "tb.vcd";
    // Declare testbench signals
    logic [3:0] A, B;
    logic Cin;
    logic [3:0] Sum;
    logic Cout;

    // Instantiate the four_bit_adder module
    four_bit_adder four_bit_adder (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // Testbench procedure
    initial begin
        $sdf_annotate("/home/vlsi/Desktop/DC_play/four_bit_adder.sdf", four_bit_adder);
        $dumpfile(VCD_FILE);
        $dumpvars(0, tb .four_bit_adder);
        $set_gate_level_monitoring("on");
        // Monitor changes
        $monitor("Time = %0t | A = %b | B = %b | Cin = %b | Sum = %b | Cout = %b", 
                 $time, A, B, Cin, Sum, Cout);

        // Test case 1
        A = 4'b0000; B = 4'b0000; Cin = 1'b0;
        #10; // Wait 10 time units

        // Test case 2
        A = 4'b0101; B = 4'b0011; Cin = 1'b0;
        #10; // Wait 10 time units

        // Test case 3
        A = 4'b1111; B = 4'b0001; Cin = 1'b0;
        #10; // Wait 10 time units

        // Test case 4
        A = 4'b1010; B = 4'b0101; Cin = 1'b1;
        #10; // Wait 10 time units

        // Test case 5
        A = 4'b0110; B = 4'b1001; Cin = 1'b1;
        #10; // Wait 10 time units

        // End simulation
        $finish;
    end

endmodule
