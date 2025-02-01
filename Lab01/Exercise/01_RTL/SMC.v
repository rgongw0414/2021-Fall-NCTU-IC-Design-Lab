//================================================================
//   Date: 2025.02.01
//   Author: Gong-Chi Wang (王公志)
//   NCTU IC Lab Exercise #1
//================================================================
//   File Name   : SMC.v
//   Module Name : SMC
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
`include "sort.v"

module SMC(
  // Input signals
    mode,
    W_0, V_GS_0, V_DS_0,
    W_1, V_GS_1, V_DS_1,
    W_2, V_GS_2, V_DS_2,
    W_3, V_GS_3, V_DS_3,
    W_4, V_GS_4, V_DS_4,
    W_5, V_GS_5, V_DS_5,   
  // Output signals
    out_n, 
    overflow_ID, overflow_Gm
);

//================================================================
//   INPUT AND OUTPUT DECLARATION                         
//================================================================
input [2:0] W_0, V_GS_0, V_DS_0;
input [2:0] W_1, V_GS_1, V_DS_1;
input [2:0] W_2, V_GS_2, V_DS_2;
input [2:0] W_3, V_GS_3, V_DS_3;
input [2:0] W_4, V_GS_4, V_DS_4;
input [2:0] W_5, V_GS_5, V_DS_5;
input [1:0] mode;
output reg [9:0] out_n;
output overflow_ID, overflow_Gm;  // flags for overflow and underflow

//================================================================
//    Wire & Registers 
//================================================================
// Declare the wire/reg you would use in your circuit
// remember 
// wire for port connection and cont. assignment
// reg for proc. assignment

wire [6:0] n_0_ID, n_1_ID, n_2_ID; // The top-3 max/min ID/Gm, where max1 > max2 > max3, min1 < min2 < min3
wire [9:0] n_0_ID_fill, n_1_ID_fill, n_2_ID_fill;
wire [6:0] n_0_Gm, n_1_Gm, n_2_Gm; // The top-3 max/min ID/Gm, where max1 > max2 > max3, min1 < min2 < min3
wire [9:0] n_0_Gm_fill, n_1_Gm_fill, n_2_Gm_fill;

//================================================================
//    DESIGN
//================================================================
// --------------------------------------------------
// 1. ID and Gm calculation
// --------------------------------------------------
wire [6:0] ID_0, ID_1, ID_2, ID_3, ID_4, ID_5; // 7 bits, prevent overflow
wire [6:0] Gm_0, Gm_1, Gm_2, Gm_3, Gm_4, Gm_5;
ID_Gm_calculator ID_Gm_calculator0(.W(W_0), .V_GS(V_GS_0), .V_DS(V_DS_0), .ID(ID_0), .Gm(Gm_0), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator1(.W(W_1), .V_GS(V_GS_1), .V_DS(V_DS_1), .ID(ID_1), .Gm(Gm_1), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator2(.W(W_2), .V_GS(V_GS_2), .V_DS(V_DS_2), .ID(ID_2), .Gm(Gm_2), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator3(.W(W_3), .V_GS(V_GS_3), .V_DS(V_DS_3), .ID(ID_3), .Gm(Gm_3), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator4(.W(W_4), .V_GS(V_GS_4), .V_DS(V_DS_4), .ID(ID_4), .Gm(Gm_4), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator5(.W(W_5), .V_GS(V_GS_5), .V_DS(V_DS_5), .ID(ID_5), .Gm(Gm_5), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
// --------------------------------------------------
// 2. Determine output ID/gm and then sorting
// --------------------------------------------------

// Sort the ID/Gm 
Sort sort_ID(.in0(ID_0), .in1(ID_1), .in2(ID_2), .in3(ID_3), .in4(ID_4), .in5(ID_5), .mode(mode[1]), .out0(n_0_ID), .out1(n_1_ID), .out2(n_2_ID));
assign n_0_ID_fill = {3'b0, n_0_ID};
assign n_1_ID_fill = {3'b0, n_1_ID};
assign n_2_ID_fill = {3'b0, n_2_ID};

Sort sort_Gm(.in0(Gm_0), .in1(Gm_1), .in2(Gm_2), .in3(Gm_3), .in4(Gm_4), .in5(Gm_5), .mode(mode[1]), .out0(n_0_Gm), .out1(n_1_Gm), .out2(n_2_Gm));
assign n_0_Gm_fill = {3'b0, n_0_Gm};
assign n_1_Gm_fill = {3'b0, n_1_Gm};
assign n_2_Gm_fill = {3'b0, n_2_Gm};

// Calculate final output: out_n
always@(*) begin
  // n_0 > n_1 > n_2
  if (mode[1] == 1) begin
    if (mode[0] == 0) begin
      // Calculate max gm
      out_n = n_0_Gm_fill + n_1_Gm_fill + n_2_Gm_fill;
    end
    else begin
      // Calculate max I
      out_n = n_0_ID_fill * 3 + n_1_ID_fill * 4 + n_2_ID_fill * 5;
    end
  end
  else begin
    if (mode[0] == 0) begin
      // Calculate min gm
      out_n = n_0_Gm_fill + n_1_Gm_fill + n_2_Gm_fill;
    end
    else begin
      // Calculate min I
      out_n = n_0_ID_fill * 3 + n_1_ID_fill * 4 + n_2_ID_fill * 5;
    end
  end
end
endmodule

//================================================================
//   SUB MODULE
//================================================================

// Select the mode of the transistor (Triode or Saturation)
module mode_selector(
  // Input signals
    V_GS, V_DS,
  // Output signals
    selected_mode
);
input [2:0] V_GS, V_DS;
output reg selected_mode;  // 0: Triode, 1: Saturation

always@(*) begin
  if (V_GS - 1 > V_DS) begin
    selected_mode = 0; // Triode
  end
  else begin
    selected_mode = 1; // Saturation
  end
end

endmodule


/*
  * Calculate ID and Gm based on the mode of the transistor
  * and the input signals
  * W: Width of the transistor, 1 ~ 7
  * V_GS: Gate-source voltage, 1 ~ 7
  * V_DS: Drain-source voltage, 1 ~ 7
  * ID: Drain current, 0 ~ 81 (Triode), 0 ~ 84 (Saturation)
  * Gm: Transconductance, 0 ~ 32 (Triode), 0 ~ 28 (Saturation)
*/
module ID_Gm_calculator(
  // Input signals
    W, V_GS, V_DS,
  // Output signals
    ID, Gm, overflow_ID, overflow_Gm
);
input [2:0] W, V_GS, V_DS;
output reg overflow_ID, overflow_Gm;  // flags for overflow and underflow
output reg [6:0] ID, Gm;  // 7 bits, prevent overflow

wire selected_mode;
mode_selector mode_selector0(.V_GS(V_GS), .V_DS(V_DS), .selected_mode(selected_mode));

// Calculate ID and Gm
always@(*) begin
  if (W == 0) begin
    ID = 0;
    Gm = 0;
  end
  else begin
    if (selected_mode == 0) begin
      // Triode
      ID = (W * V_DS * (2 * (V_GS - 1) - V_DS)) / 3;
      Gm = (W * V_GS * 2) / 3;
    end
    else begin
      // Saturation
      ID = (W * (V_GS - 1) * (V_GS - 1)) / 3;
      Gm = ((W * (V_GS - 1)) * 2) / 3;
    end
  end
end

// Set overflow, underflow flags if necessary
always@(*) begin
  if (selected_mode == 0) begin
    if (ID > 81) begin
      overflow_ID = 1;
    end
    else begin
      overflow_ID = 0;
    end

    if (Gm > 32) begin
      overflow_Gm = 1;
    end
    else begin
      overflow_Gm = 0;
    end
  end
  else begin
    if (ID > 84) begin
      overflow_ID = 1;
    end
    else begin
      overflow_ID = 0;
    end

    if (Gm > 28) begin
      overflow_Gm = 1;
    end
    else begin
      overflow_Gm = 0;
    end
  end
end

// display overflow warnings
// always@(*) begin
//   if (overflow_ID == 1) begin
//     $display("Overflow: ID = %d", ID);
//   end
//   if (overflow_Gm == 1) begin
//     $display("Overflow: Gm = %d", Gm);
//   end
// end

endmodule