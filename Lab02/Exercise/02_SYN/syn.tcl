#======================================================
#
# Synopsys Synthesis Scripts (Design Vision dctcl mode)
#
#======================================================
#======================================================
#  Set Libraries
#======================================================
set search_path "./../01_RTL \
                   /usr/cad/synopsys/synthesis/cur/libraries/syn \
                   /home/eric/CBDK018_TSMC_Artisan/CIC/SynopsysDC"

#                    ~iclabta01/umc018/Synthesis \

set synthetic_library "dw_foundation.sldb"
set link_library "* dw_foundation.sldb standard.sldb slow.db"
set target_library "slow.db"       

#======================================================
#  Global Parameters
#======================================================
set DESIGN "KT"
set clk_period 5.0
set IN_DLY  [expr 0.5*$clk_period]
set OUT_DLY [expr 0.5*$clk_period]

#set hdlin_ff_always_sync_set_reset true

#======================================================
#  Read RTL Code
#======================================================
read_sverilog "$DESIGN\.v"
current_design $DESIGN

#======================================================
#  Global Setting
#======================================================

#======================================================
#  Set Design Constraints
#======================================================
create_clock -name "clk" -period $clk_period clk
set_ideal_network -no_propagate clk
set_input_delay  $IN_DLY -clock clk [all_inputs]
set_output_delay $OUT_DLY  -clock clk [all_outputs]
set_input_delay 0 -clock clk clk
set_input_delay 0 -clock clk rst_n
set_load 0.05 [all_outputs]
#set_dont_use slow/JKFF*


#======================================================
#  Optimization
#======================================================
uniquify
check_design > Report/$DESIGN\.check
set_fix_multiple_port_nets -all -buffer_constants
set_fix_hold [all_clocks]
compile_ultra

#======================================================
#  Output Reports
#======================================================
report_timing            >  Report/$DESIGN\.timing
report_area              >  Report/$DESIGN\.area
report_resource          >  Report/$DESIGN\.resource


#======================================================
#  Change Naming Rule
#======================================================
set bus_inference_style "%s\[%d\]"
set bus_naming_style "%s\[%d\]"
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
change_names -hierarchy -rules name_rule

#======================================================
#  Output Results
#======================================================
set verilogout_higher_designs_first true
write -format verilog -output Netlist/$DESIGN\_SYN.v -hierarchy
write_sdf -version 3.0 -context verilog -load_delay cell Netlist/$DESIGN\_SYN.sdf -significant_digits 6
write_sdc Netlist/$DESIGN\_SYN.sdc

#======================================================
#  Finish and Quit
#======================================================
exit



