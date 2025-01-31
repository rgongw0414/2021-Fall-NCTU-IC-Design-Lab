/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : R-2020.09
// Date      : Sun Mar 12 01:52:12 2023
/////////////////////////////////////////////////////////////


module CORE ( in_n0, in_n1, opt, out_n );
  input [2:0] in_n0;
  input [2:0] in_n1;
  output [3:0] out_n;
  input opt;
  wire   n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48;

  XNOR2VTG_X1 U31 ( .A(opt), .B(in_n1[1]), .Y(n30) );
  INVVTG_X1 U32 ( .A(in_n0[1]), .Y(n29) );
  NOR2VTG_X1 U33 ( .A(n30), .B(n29), .Y(n31) );
  XNOR2VTG_X1 U34 ( .A(opt), .B(in_n1[0]), .Y(n26) );
  INVVTG_X1 U35 ( .A(in_n0[0]), .Y(n25) );
  NOR2VTG_X1 U36 ( .A(n26), .B(n25), .Y(n28) );
  XNOR2VTG_X1 U37 ( .A(n26), .B(in_n0[0]), .Y(n46) );
  NAND2VTG_X1 U38 ( .A(opt), .B(n46), .Y(n27) );
  INVVTG_X1 U39 ( .A(n27), .Y(n48) );
  NOR2VTG_X1 U40 ( .A(n28), .B(n48), .Y(n41) );
  XNOR2VTG_X1 U41 ( .A(n30), .B(n29), .Y(n42) );
  NOR2VTG_X1 U42 ( .A(n41), .B(n42), .Y(n45) );
  NOR2VTG_X1 U43 ( .A(n31), .B(n45), .Y(n36) );
  INVVTG_X1 U44 ( .A(in_n0[2]), .Y(n33) );
  XNOR2VTG_X1 U45 ( .A(opt), .B(in_n1[2]), .Y(n32) );
  XNOR2VTG_X1 U46 ( .A(n33), .B(n32), .Y(n37) );
  NOR2VTG_X1 U47 ( .A(n36), .B(n37), .Y(n40) );
  NOR2VTG_X1 U48 ( .A(n33), .B(n32), .Y(n34) );
  NOR2VTG_X1 U49 ( .A(n40), .B(n34), .Y(n35) );
  XNOR2VTG_X1 U50 ( .A(n35), .B(opt), .Y(out_n[3]) );
  NAND2VTG_X1 U51 ( .A(n37), .B(n36), .Y(n38) );
  INVVTG_X1 U52 ( .A(n38), .Y(n39) );
  NOR2VTG_X1 U53 ( .A(n40), .B(n39), .Y(out_n[2]) );
  NAND2VTG_X1 U54 ( .A(n42), .B(n41), .Y(n43) );
  INVVTG_X1 U55 ( .A(n43), .Y(n44) );
  NOR2VTG_X1 U56 ( .A(n45), .B(n44), .Y(out_n[1]) );
  NOR2VTG_X1 U57 ( .A(opt), .B(n46), .Y(n47) );
  NOR2VTG_X1 U58 ( .A(n48), .B(n47), .Y(out_n[0]) );
endmodule

