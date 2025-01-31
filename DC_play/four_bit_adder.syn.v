/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : S-2021.06-SP2
// Date      : Mon Aug  5 14:29:14 2024
/////////////////////////////////////////////////////////////


module four_bit_adder ( A, B, Cin, Sum, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] Sum;
  input Cin;
  output Cout;
  wire   n44, n45, n46, n47, n48, n7, n8, n9, n10, n11, n12, n15, n16, n17,
         n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43;

  ADDFX2 U5 ( .A(B[2]), .B(A[2]), .CI(n42), .CO(n41), .S(n45) );
  ADDFX2 U6 ( .A(B[1]), .B(A[1]), .CI(n43), .CO(n42), .S(n46) );
  ADDFX2 U7 ( .A(B[0]), .B(A[0]), .CI(Cin), .CO(n43), .S(n47) );
  BUFX3 U8 ( .A(n10), .Y(n9) );
  CLKINVX12 U9 ( .A(n9), .Y(Sum[2]) );
  BUFX3 U10 ( .A(n11), .Y(n8) );
  CLKINVX12 U11 ( .A(n8), .Y(Sum[0]) );
  BUFX3 U12 ( .A(n12), .Y(n7) );
  CLKINVX12 U13 ( .A(n7), .Y(Sum[1]) );
  INVXL U14 ( .A(n46), .Y(n12) );
  INVXL U15 ( .A(n47), .Y(n11) );
  INVXL U16 ( .A(n45), .Y(n10) );
  CLKINVX12 U17 ( .A(n48), .Y(Cout) );
  CLKINVX12 U18 ( .A(n44), .Y(Sum[3]) );
  BUFX2 U19 ( .A(n16), .Y(n48) );
  BUFX2 U20 ( .A(n15), .Y(n44) );
  INVX1 U21 ( .A(B[3]), .Y(n17) );
  INVX1 U22 ( .A(A[3]), .Y(n18) );
  INVX1 U23 ( .A(n41), .Y(n19) );
  NOR2X1 U24 ( .A(n17), .B(n21), .Y(n20) );
  NOR2X1 U25 ( .A(n18), .B(n23), .Y(n22) );
  NOR2X1 U26 ( .A(n19), .B(n25), .Y(n24) );
  NOR2X1 U27 ( .A(n19), .B(n27), .Y(n26) );
  NOR2X1 U28 ( .A(n28), .B(n29), .Y(n15) );
  NOR2X1 U29 ( .A(n18), .B(n19), .Y(n30) );
  NOR2X1 U30 ( .A(n17), .B(n19), .Y(n31) );
  NOR2X1 U31 ( .A(n17), .B(n18), .Y(n32) );
  NOR2X1 U32 ( .A(n32), .B(n33), .Y(n16) );
  NOR2X1 U33 ( .A(A[3]), .B(n41), .Y(n34) );
  INVX1 U34 ( .A(n34), .Y(n21) );
  NOR2X1 U35 ( .A(B[3]), .B(n41), .Y(n35) );
  INVX1 U36 ( .A(n35), .Y(n23) );
  NOR2X1 U37 ( .A(B[3]), .B(A[3]), .Y(n36) );
  INVX1 U38 ( .A(n36), .Y(n25) );
  NOR2X1 U39 ( .A(n17), .B(n18), .Y(n37) );
  INVX1 U40 ( .A(n37), .Y(n27) );
  NOR2X1 U41 ( .A(n20), .B(n22), .Y(n38) );
  INVX1 U42 ( .A(n38), .Y(n28) );
  NOR2X1 U43 ( .A(n24), .B(n26), .Y(n39) );
  INVX1 U44 ( .A(n39), .Y(n29) );
  NOR2X1 U45 ( .A(n30), .B(n31), .Y(n40) );
  INVX1 U46 ( .A(n40), .Y(n33) );
endmodule

