export VCS_ARCH_OVERRIDE=linux
# vcs -full64 -R -sverilog tb.sv tsmc18.v ascon_core.syn.v asconp.syn.v linearDiffM014.syn.v Sbox.syn.v ascon_SboxLUT_0.syn.v ascon_SboxLUT_1.syn.v ascon_SboxLUT_2.syn.v ascon_SboxLUT_3.syn.v -debug_all +neg_tchk -negdelay
# vcs -full64 -R -sverilog tb.sv ascon_core.sv asconp.sv Sbox.sv ascon_SboxLUT.sv -debug_all +neg_tchk -negdelay

vcs -full64 -R -sverilog tb.sv tsmc18.v ascon_core.syn.v asconp.syn.v linearDiffM04.syn.v -debug_all +neg_tchk -negdelay
