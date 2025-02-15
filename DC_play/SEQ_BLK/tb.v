`timescale 1ns/10ps

`define DESIGN_FILE "SEQ_BLK"
`ifdef RTL
    `include "SEQ_BLK.v"
`endif
`ifdef GATE
    `include "Netlist/SEQ_BLK_SYN.v"
`endif

module tb;
    reg clk;
    reg rst;
    reg in;
    wire outA, outB, outC;

    SEQ_BLK uut (
        .clk(clk),
        .rst(rst),
        .in(in),
        .outA(outA),
        .outB(outB),
        .outC(outC)
    );

    initial begin
        clk = 0;
        rst = 0;
        in = 0;
        #10 rst = 1;
        #10 rst = 0;
        #10 in = 1;
        #10 in = 0;
        #10 in = 1;
        #20 $finish;
    end

    always begin
        #5 clk = ~clk;
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