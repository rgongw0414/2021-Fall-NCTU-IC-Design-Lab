#======================================================
#
# Synopsys Synthesis Scripts (Design Vision dctcl mode)
#
#======================================================

#======================================================
#  Set Libraries
#======================================================
# for DC 2021.06-sp2, use "", not {}
set search_path "./../01_RTL \
                   /usr/cad/synopsys/synthesis/cur/libraries/syn \
                   /home/eric/CBDK018_TSMC_Artisan/CIC/SynopsysDC"
                #    ~iclabta01/umc018/Synthesis \
                #    /home/eda/SAED32_EDK/lib/stdcell_lvt/db_nldm/ }
#                   "/home/eda/CBDK45_FreePDK_TSRI_v1.1/lib" }
                   #/usr/syn/libraries/syn/ \
                   #/usr/syn/dw/ }

set synthetic_library "dw_foundation.sldb"
set link_library "* dw_foundation.sldb standard.sldb slow.db"
set target_library "slow.db"

#set_host_options -max_cores 16
#======================================================
#  Global Parameters
#======================================================
set DESIGN "CORE"
set MAX_Delay 30

#======================================================
#  Read RTL Code
#======================================================
read_sverilog "$DESIGN\.v"
current_design $DESIGN

#======================================================
#  Global Setting
#======================================================
#set_operating_conditions -max slow -min fast
#======================================================
#  Set Design Constraints
#======================================================
set_max_delay $MAX_Delay -from [all_inputs] -to [all_outputs]

#======================================================
#  Optimization
#======================================================
uniquify
set_fix_multiple_port_nets -all -buffer_constants
compile_ultra

#======================================================
#  Output Reports 
#======================================================
report_timing >  Report/$DESIGN\.timing
report_area >  Report/$DESIGN\.area
report_resource >  Report/$DESIGN\.resource

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
write_sdf -version 2.1 -context verilog -load_delay cell Netlist/$DESIGN\_SYN.sdf
#======================================================
#  Finish and Quit
#======================================================
exit
