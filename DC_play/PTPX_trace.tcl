set power_enable_analysis TRUE
set power_analysis_mode time_based
set search_path "/cad/SynopsysDC /home/vlsi/Desktop/DC_play"
write_activity_waveforms -vcd tb.vcd -output four_bit_adder.out -interval 0.2 -peak_window 5 -hierarchical_levels 2

report_activity_waveforms

set link_library "fast.db"
read_verilog four_bit_adder.syn.v
current_design four_bit_adder
link

read_sdc four_bit_adder.sdc 
set_operating_conditions

check_timing
update_timing
report_timing

read_vcd tb.vcd -strip_path tb/four_bit_adder

check_power
set_power_analysis_options -waveform_format out -waveform_output powerTrace0
update_power
report_power
quit

