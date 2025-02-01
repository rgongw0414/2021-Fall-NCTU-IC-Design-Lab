//================================================================
//   Date: 2023.03.12
//   Author: yt wang                      
//================================================================
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
    out_n
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
output[9:0] out_n; 								

//================================================================
//    Wire & Registers 
//================================================================
// Declare the wire/reg you would use in your circuit
// remember 
// wire for port connection and cont. assignment
// reg for proc. assignment

reg [5:0] n; // The resulting ID/Gm, used for sorting in the next stage
reg max1, max2, max3; // The top-3 ID/Gm, where max1 > max2 > max3
reg min1, min2, min3; // The top-3 ID/Gm, where min1 < min2 < min3



//================================================================
//    DESIGN
//================================================================
// --------------------------------------------------
// 1. ID and Gm calculation
// --------------------------------------------------
wire [6:0] ID_0, ID_1, ID_2, ID_3, ID_4, ID_5; // 7 bits, prevent overflow
wire [6:0] Gm_0, Gm_1, Gm_2, Gm_3, Gm_4, Gm_5;
wire overflow_ID, overflow_Gm;  // flags for overflow and underflow
ID_Gm_calculator ID_Gm_calculator0(.W(W_0), .V_GS(V_GS_0), .V_DS(V_DS_0), .ID(ID_0), .Gm(Gm_0), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator1(.W(W_1), .V_GS(V_GS_1), .V_DS(V_DS_1), .ID(ID_1), .Gm(Gm_1), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator2(.W(W_2), .V_GS(V_GS_2), .V_DS(V_DS_2), .ID(ID_2), .Gm(Gm_2), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator3(.W(W_3), .V_GS(V_GS_3), .V_DS(V_DS_3), .ID(ID_3), .Gm(Gm_3), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator4(.W(W_4), .V_GS(V_GS_4), .V_DS(V_DS_4), .ID(ID_4), .Gm(Gm_4), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
ID_Gm_calculator ID_Gm_calculator5(.W(W_5), .V_GS(V_GS_5), .V_DS(V_DS_5), .ID(ID_5), .Gm(Gm_5), .overflow_ID(overflow_ID), .overflow_Gm(overflow_Gm));
// --------------------------------------------------
// 2. Determine output ID/gm ann then sorting
// --------------------------------------------------



// Calculate final output: out_n
always@(*) begin
  // max1 > max2 > max3
  if (mode[1] == 1) begin
    if (mode[0] == 0) begin
      // Calculate max gm
      out_n = max1 * 3 + max2 * 4 + max3 * 5;
    end
    else begin
      // Calculate max I
      out_n = max1 + max2 + max3;
    end

  end
  else begin
    // min3 > min2 > min1
    if (mode[0] == 0) begin
      // Calculate min gm
      out_n = n[0] + n[1] + n[2] + n[3] + n[4] + n[5] - max1 - max2 - max3;
      // out_n = min1 + min2 + min3;
    end
    else begin
      // Calculate min I
      out_n = 3 * min3 + 4 * min2 + 5 * min1;
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
input reg [2:0] V_GS, V_DS;
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
      Gm = W * V_GS * 2 / 3;
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

// --------------------------------------------------
// Example for using submodule 
// BBQ bbq0(.meat(meat_0), .vagetable(vagetable_0), .water(water_0),.cost(cost[0]));
// --------------------------------------------------
// Example for continuous assignment
// assign out_n = XXX;
// --------------------------------------------------
// Example for procedure assignment
// always@(*) begin 
// 	out_n = XXX; 
// end
// --------------------------------------------------
// Example for case statement
// always @(*) begin
// 	case(op)
// 		2'b00: output_reg = a + b;
// 		2'b10: output_reg = a - b;
// 		2'b01: output_reg = a * b;
// 		2'b11: output_reg = a / b;
// 		default: output_reg = 0;
// 	endcase
// end
// --------------------------------------------------
