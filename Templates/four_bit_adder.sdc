###################################################################

# Created by write_sdc on Mon Aug  5 14:29:14 2024

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_area 1.0e+08
set_load -pin_load 57.462 [get_ports {Sum[3]}]
set_load -pin_load 57.462 [get_ports {Sum[2]}]
set_load -pin_load 57.462 [get_ports {Sum[1]}]
set_load -pin_load 57.462 [get_ports {Sum[0]}]
set_load -pin_load 57.462 [get_ports Cout]
