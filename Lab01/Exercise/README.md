# Exercise 1 - Design: Supper MOSFET Calculator(SMC)
## Description
* Design a Supper MOSFET Calculator to calculate the drain current I<sub>D</sub> and transconductance g<sub>m</sub> in a short time.
* Given numerous combinations of width, V<sub>GS</sub> and V<sub>DS</sub>, find which one could get the maximum value?

##
* Cell library: CBDK018_TSMC_Artisan
* 10,000 test patterns passed in post-sim (Lab01/Exercise/00_TESTBED/Test_data_gen_ref.cpp)
* Only combinational cells are introduced!

Area:
```
Number of ports:                          118
Number of nets:                          4129
Number of cells:                         3763
Number of combinational cells:           3760
Number of sequential cells:                 0
Number of macros/black boxes:               0
Number of buf/inv:                        837
Number of references:                      74

Combinational area:              63876.860044
Buf/Inv area:                     5604.984072
Noncombinational area:               0.000000
Macro/Black Box area:                0.000000
Net Interconnect area:      undefined  (No wire load specified)

Total cell area:                 63876.860044
Total area:                 undefined
```

Time:
```
  max_delay                               20.00      20.00
  output external delay                    0.00      20.00
  data required time                                 20.00
  -----------------------------------------------------------
  data required time                                 20.00
  data arrival time                                 -20.00
  -----------------------------------------------------------
  slack (MET)                                         0.00
```

## What to notice
* Default values of min/max regs
* Since only the top-3 max/min values are needed, so no need to sort the entire array
* Sorting algorithm excels in time complexity takes extra space. Implementing them in Verilog might take more registers, i.e., more area

