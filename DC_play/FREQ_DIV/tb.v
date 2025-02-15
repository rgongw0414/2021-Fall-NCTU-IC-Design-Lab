`timescale 1ns/10ps
`ifdef RTL
    `include "F_DIV.v"
`endif
`ifdef GATE
    `include "F_DIV_SYN.v"
`endif

`define DESIGN_FILE "F_DIV"

module tb;
    reg clk_in;
    reg rst;
    wire clk_out_2x;
    wire clk_out_3x;
    wire clk_out_4x;
    wire clk_out_5x;

    F_DIV uut (
        .clk_in(clk_in),
        .rst(rst),
        .clk_out_2x(clk_out_2x),
        .clk_out_3x(clk_out_3x),
        .clk_out_4x(clk_out_4x),
        .clk_out_5x(clk_out_5x)
    );

    initial begin
        clk_in = 0;
        rst = 0;
        #10 rst = 1;
        #10 rst = 0;
        #500 $finish;
    end

    always begin
        #5 clk_in = ~clk_in;
    end


    initial begin
        `ifdef RTL
            $fsdbDumpfile({`DESIGN_FILE, ".fsdb"});
            $fsdbDumpvars(0,"+mda");
            $fsdbDumpvars();
        `endif
        `ifdef GATE
            $sdf_annotate({`DESIGN_FILE, ".sdf"}, uut);
            $fsdbDumpfile({`DESIGN_FILE, "_SYN.fsdb"});
            $fsdbDumpvars(0,"+mda");
            $fsdbDumpvars();    
        `endif
    end
endmodule