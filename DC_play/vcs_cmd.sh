#DC Command
# dc_shell -f dc_syn.tcl | tee dc_syn.log

#Gate level simulation
# vcs -full64 -R -sverilog tb.sv tsmc18.v four_bit_adder.syn.v -debug_all +neg_tchk -negdelay

#Function Simulation
# vcs -full64 -R -sverilog tb.sv four_bit_adder.sv -debug_all +neg_tchk -negdelay


#PrimeTime
# pt_shell -f PTPX_trace.tcl
