`timescale 1ns/10ps

`define DESIGN_FILE "FREQ_DIV"
`ifdef RTL
    `include "FREQ_DIV.v"
`elsif GATE
    `include "Netlist/FREQ_DIV_SYN.v"
`else
    initial begin
        $display("Error: Neither RTL nor GATE is defined.");
        $finish;
    end
`endif

module tb;
    reg clk_in;
    reg rst;
    wire clk_out_2x;
    wire clk_out_3x;
    wire clk_out_4x;
    wire clk_out_5x;

    FREQ_DIV uut (
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
            $sdf_annotate({"Netlist/", `DESIGN_FILE, "_SYN.sdf"}, uut);
            $fsdbDumpfile({`DESIGN_FILE, "_SYN.fsdb"});
            $fsdbDumpvars(0,"+mda");
            $fsdbDumpvars();    
        `endif
    end
endmodule