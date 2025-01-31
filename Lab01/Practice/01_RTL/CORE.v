module CORE (
    in_n0,
    in_n1,
    opt,
    out_n
);
//--------------------------------------------------------------
//Input, Output Declaration
//--------------------------------------------------------------
input [2:0] in_n0, in_n1;
input opt;
output [3:0] out_n;

reg [3:0] in_n1_inv;
reg carry_in;
wire [3:0] tmp;

//-----write your code here-----

/* 
What I learned: 
	Note: The input is 3-bit unsigned number, and the output is 4-bit signed number. If the input in signed, then we cannot use this solution, because the last output bit will be wrong.
	Since the output is 4-bit, we need to use 4-bit adder, however, the input is 3-bit, so we need to convert it to 4-bit.
	Also, minimize the final area, the last bit of in_n0 is 0 (it is unsigned, it does not contribute to out_n[3] in HA), so we can use HA instead of FA.
*/

always@(*)
begin
if(opt)
	begin
	in_n1_inv = {1'b1, ~in_n1};  // 2's complement, invert and add 1
	carry_in = 1'b1;  // carry in for 2's complement
	end
else
	begin
	in_n1_inv = {1'b0,in_n1};
	carry_in = 1'b0;
	end
end


FA FA0(.a(in_n0[0]),.b(in_n1_inv[0]),.c_in(carry_in),.sum(out_n[0]),.c_out(tmp[0]));
FA FA1(.a(in_n0[1]),.b(in_n1_inv[1]),.c_in(tmp[0]),.sum(out_n[1]),.c_out(tmp[1]));
FA FA2(.a(in_n0[2]),.b(in_n1_inv[2]),.c_in(tmp[1]),.sum(out_n[2]),.c_out(tmp[2]));
HA HA3(.a(tmp[2]),.b(in_n1_inv[3]),.sum(out_n[3]),.c_out(tmp[3])); // in_n0[3] is 0, so no need to adder, further, no need to use FA, just use HA!



//-----write your code here-----


endmodule 
//--------------------------------------------------------------
//Module Half Adder & Full Adder provided by TA
//--------------------------------------------------------------
module HA(
		a, 
		b, 
		sum, 
		c_out
);
  input wire a, b;
  output wire sum, c_out;
  xor (sum, a, b);
  and (c_out, a, b);
endmodule


module FA(
		a, 
		b, 
		c_in, 
		sum, 
		c_out
);
  input   a, b, c_in;
  output  sum, c_out;
  wire   w1, w2, w3;
  HA M1(.a(a), .b(b), .sum(w1), .c_out(w2));
  HA M2(.a(w1), .b(c_in), .sum(sum), .c_out(w3));
  or (c_out, w2, w3);
endmodule