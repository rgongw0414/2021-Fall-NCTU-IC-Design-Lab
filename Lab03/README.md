# 17x17 MAZE Solving
* Start: (0, 0) -> Target: (16, 16)
* Given a 17x17 maze, return the directions along the path from start to target cell
  
## Components
* FIFO Memory (Queue)
* 2-d Memory for saving the maze (0 for wall, 1 for path)
* 2-d Memory for saving the parent direction of each cell
* 1-d Memory for saving the directions from the target to the start cell
  
## Gate-level Result

![alt text](./03_GATE/post-sim.png)

* Timing Report
```
****************************************
Report : timing
        -path full
        -delay max
        -max_paths 1
Design : MAZE
Version: S-2021.06-SP2
Date   : Fri May  2 22:37:18 2025
****************************************

 # A fanout number of 1000 was used for high fanout net computations.

Operating Conditions: slow   Library: slow
Wire Load Model Mode: top

  Startpoint: curr_x_reg[1]
              (rising edge-triggered flip-flop clocked by clk)
  Endpoint: Q/mem_reg[3][0]
            (rising edge-triggered flip-flop clocked by clk)
  Path Group: clk
  Path Type: max

  Point                                    Incr       Path
  -----------------------------------------------------------
  clock clk (rise edge)                    0.00       0.00
  clock network delay (ideal)              0.00       0.00
  curr_x_reg[1]/CK (DFFSX1)                0.00 #     0.00 r
  curr_x_reg[1]/QN (DFFSX1)                0.56       0.56 f
  U5908/Y (NOR2X2)                         0.18       0.73 r
  U5909/Y (NAND2XL)                        0.15       0.88 f
  U5910/Y (CLKINVX3)                       0.30       1.18 r
  U5911/Y (NAND4X1)                        0.19       1.37 f
  U4566/Y (NOR2X1)                         0.24       1.61 r
  U4563/Y (INVX1)                          0.10       1.71 f
  U4747/Y (NOR2X1)                         0.15       1.87 r
  U4559/Y (NOR2X1)                         0.11       1.98 f
  U6546/Y (MXI2X1)                         0.22       2.19 f
  U6549/Y (NOR2X1)                         0.34       2.54 r
  U6550/Y (INVX1)                          0.13       2.67 f
  U6551/Y (OAI21XL)                        0.21       2.88 r
  U6552/Y (AND2X2)                         0.24       3.12 r
  U4483/S (ADDFHX2)                        0.60       3.71 r
  U4553/Y (INVX2)                          0.14       3.86 f
  U5077/Y (NOR2X2)                         1.25       5.11 r
  U5229/Y (NAND2BX1)                       0.30       5.41 f
  U6948/Y (NOR2X2)                         0.44       5.85 r
  U7107/Y (AOI22XL)                        0.20       6.05 f
  U4484/Y (AND4X1)                         0.32       6.37 f
  U4520/Y (NAND4XL)                        0.16       6.52 r
  U7108/Y (NOR3XL)                         0.10       6.63 f
  U4514/Y (NAND4XL)                        0.16       6.79 r
  U4513/Y (AOI22XL)                        0.15       6.93 f
  U4510/Y (AOI22XL)                        0.22       7.15 r
  U4509/Y (AOI31XL)                        0.15       7.30 f
  U7127/Y (NOR2X1)                         0.18       7.48 r
  U7210/Y (NAND4XL)                        0.12       7.60 f
  U7211/Y (OR3X2)                          0.36       7.96 f
  U4507/Y (AOI21X1)                        0.21       8.18 r
  U4505/Y (NAND2X1)                        0.14       8.32 f
  U4501/Y (NOR2X1)                         0.19       8.51 r
  U4499/Y (INVXL)                          0.10       8.61 f
  U5591/Y (NOR2XL)                         0.62       9.23 r
  U5592/Y (INVX1)                          0.32       9.55 f
  U7841/Y (AOI22XL)                        0.28       9.83 r
  Q/mem_reg[3][0]/D (DFFSX1)               0.00       9.83 r
  data arrival time                                   9.83

  clock clk (rise edge)                   10.00      10.00
  clock network delay (ideal)              0.00      10.00
  Q/mem_reg[3][0]/CK (DFFSX1)              0.00      10.00 r
  library setup time                      -0.13       9.87
  data required time                                  9.87
  -----------------------------------------------------------
  data required time                                  9.87
  data arrival time                                  -9.83
  -----------------------------------------------------------
  slack (MET)                                         0.03
```

* Area Report
```
****************************************
Report : area
Design : MAZE
Version: S-2021.06-SP2
Date   : Fri May  2 22:37:18 2025
****************************************

Library(s) Used:

    slow (File: /home/eric/CBDK018_TSMC_Artisan/CIC/SynopsysDC/slow.db)

Number of ports:                            7
Number of nets:                          6752
Number of cells:                         5844
Number of combinational cells:           4192
Number of sequential cells:              1652
Number of macros/black boxes:               0
Number of buf/inv:                        236
Number of references:                      58

Combinational area:              61864.387571
Buf/Inv area:                     1613.304021
Noncombinational area:          104409.041748
Macro/Black Box area:                0.000000
Net Interconnect area:      undefined  (No wire load specified)

Total cell area:                166273.429319
Total area:                 undefined
```