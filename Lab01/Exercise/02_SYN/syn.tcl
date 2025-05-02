#======================================================
#
# Synopsys Synthesis Scripts (Design Vision dctcl mode)
#
#======================================================

#======================================================
# User Defined Parameters
# You need to change this parameters to fit your own design
#======================================================
# Give the list of your verilog files
# If you have single file in your design, then
set my_verilog_files [list SMC.v sort.v]

# Set the top module of your design
set my_toplevel SMC

#======================================================
#  Set Libraries
#======================================================
set search_path "./../01_RTL \
                   /usr/cad/synopsys/synthesis/cur/libraries/syn \
                   /home/eric/CBDK018_TSMC_Artisan/CIC/SynopsysDC"

set synthetic_library "dw_foundation.sldb"
set link_library "* dw_foundation.sldb standard.sldb slow.db"
set target_library "slow.db"   

# Directory where DC placed intermediate files
define_design_lib WORK -path ./WORK

# set_host_options -max_cores 16

#======================================================
#  Global Parameters
#======================================================
# set my_toplevel "SMC"
set MAX_Delay 20

#======================================================
#  Read RTL Code
#======================================================
# read_sverilog "my_toplevel\.v"
# current_design $my_toplevel

# This command does the same work of analyze+elaborate
# read_verilog $my_verilog_files   

# Translates HDL to intermediate format
# analyze -f sverilog $my_verilog_files
analyze -f verilog $my_verilog_files

# Builds generic technology database
elaborate $my_toplevel

# Designate the design to synthesize
current_design $my_toplevel

# used when you are translating some netlist from one technology to another
link

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
report_timing >  Report/$my_toplevel\.timing
report_area >  Report/$my_toplevel\.area
report_resource >  Report/$my_toplevel\.resource

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
write -format verilog -output Netlist/$my_toplevel\_SYN.v -hierarchy
write_sdf -version 3.0 -context verilog -load_delay cell Netlist/$my_toplevel\_SYN.sdf -significant_digits 6
#======================================================
#  Finish and Quit
#======================================================
#report_area
#report_timing
exit
