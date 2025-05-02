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
set my_verilog_files [list MAZE.v QUEUE.v]

# Set the top module of your design
set my_toplevel MAZE

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
# set host

#======================================================
# Use Multiple Cores
#======================================================
set_host_options -max_cores 4

#======================================================
#  Global Parameters
#======================================================
set clk_period 10.0
set IN_DLY  [expr 0.5*$clk_period]
set OUT_DLY [expr 0.5*$clk_period]

#set hdlin_ff_always_sync_set_reset true

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

#######################################
# Verilog (?) Compiler settings       #
#######################################

# to make DC not use the assign statement in its output netlist
set verilogout_no_tri true

# assume this means DC will ignore the case of the letters in net and module names
#set verilogout_ignore_case true

# unconnected nets will be marked by adding a prefix to its name
set verilogout_unconnected_prefix "UNCONNECTED"

# show unconnected pins when creating module ports
set verilogout_show_unconnected_pins true

# make sure that vectored ports don't get split up into single bits
set verilogout_single_bit false

# generate a netlist without creating an EDIF schematic
set edifout_netlist_only true

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
set_load 0.05 [all_outputs]
#set_dont_use slow/JKFF*


#======================================================
#  Optimization
#======================================================
# used to generate separate instances within the netlist
uniquify 
check_design > Report/$my_toplevel\.check
set_fix_multiple_port_nets -all -buffer_constants
set_fix_hold [all_clocks]
compile_ultra

#======================================================
#  Output Reports
#======================================================
report_timing            >  Report/$my_toplevel\.timing
report_area -designware  >  Report/$my_toplevel\.area 
report_resource          >  Report/$my_toplevel\.resource


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
write_sdc Netlist/$my_toplevel\_SYN.sdc

#======================================================
#  Finish and Quit
#======================================================
exit



