module four_bit_adder (
    input logic [3:0] A,      // 4-bit input A
    input logic [3:0] B,      // 4-bit input B
    input logic Cin,          // Carry-in input
    output logic [3:0] Sum,   // 4-bit sum output
    output logic Cout         // Carry-out output
);

    logic [3:0] carry;        // Intermediate carry signals

    // Generate sum and carry-out for each bit
    assign {carry[0], Sum[0]} = A[0] + B[0] + Cin;
    assign {carry[1], Sum[1]} = A[1] + B[1] + carry[0];
    assign {carry[2], Sum[2]} = A[2] + B[2] + carry[1];
    assign {Cout, Sum[3]}     = A[3] + B[3] + carry[2];

endmodule
