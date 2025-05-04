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
                /home/eric/CBDK018_TSMC_Artisan/CIC/SynopsysDC \
				/cad/synopsys/synthesis/cur/dw/sim_ver"

set synthetic_library "dw_foundation.sldb"
set link_library "* dw_foundation.sldb standard.sldb slow.db"
set target_library "slow.db"   

#======================================================
#
# Synopsys Synthesis Scripts (Design Vision dctcl mode)
#
#======================================================
#report_lib slow

#======================================================
#  Global Parameters
#======================================================
set DESIGN "VIP"
set CYCLE_TIME 10

#======================================================
#  Read RTL Code
#======================================================
read_sverilog "$DESIGN\.v"
# read_sverilog "$DESIGN\_reference.v"
current_design $DESIGN

#======================================================
#  Global Setting
#======================================================
#set_wire_load_mode top

#======================================================
#  Set Design Constraints
#======================================================
create_clock -name "clk" -period $CYCLE_TIME clk 
set_input_delay  [ expr $CYCLE_TIME*0.5 ] -clock clk [all_inputs]
set_output_delay [ expr $CYCLE_TIME*0.5 ] -clock clk [all_outputs]
set_input_delay 0 -clock clk clk
set_input_delay 0 -clock clk rst_n
set_load 0.05 [all_outputs]

#======================================================
#  Optimization
#======================================================
uniquify
check_design > Report/$DESIGN\.check
set_fix_multiple_port_nets -all -buffer_constants
#set_fix_hold [all_clocks]
compile_ultra

#======================================================
#  Output Reports 
#======================================================
report_timing           >  Report/$DESIGN\.timing
report_area -designware >  Report/$DESIGN\.area
report_resource         >  Report/$DESIGN\.resource

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

#======================================================
#  Finish and Quit
#======================================================
report_area -designware
report_timing
exit
