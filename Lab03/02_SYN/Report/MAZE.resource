Warning: Design 'MAZE' has '1' unresolved references. For more detailed information, use the "link" command. (UID-341)
 
****************************************
Report : resources
Design : MAZE
Version: S-2021.06-SP2
Date   : Thu May  1 23:51:00 2025
****************************************


Resource Report for this hierarchy in file
        /home/eric/2021-Fall-NCTU-IC-Design-Lab/Lab03/01_RTL/MAZE.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_1        | DW01_add       | width=6    | add_85 (MAZE.v:85)         |
| add_x_2        | DW01_add       | width=6    | add_86 (MAZE.v:86)         |
| gte_x_4        | DW_cmp         | width=6    | gte_87 (MAZE.v:87)         |
| gte_x_6        | DW_cmp         | width=6    | gte_87_2 (MAZE.v:87)       |
| add_x_12       | DW01_inc       | width=6    | add_199 (MAZE.v:199)       |
| add_x_25       | DW01_inc       | width=2    | add_267 (MAZE.v:267)       |
| gt_x_38        | DW_cmp         | width=8    | gt_376 (MAZE.v:376)        |
| add_x_19       | DW01_inc       | width=6    | add_228 (MAZE.v:228)       |
|                |                |            | add_233 (MAZE.v:233)       |
| DP_OP_1652J1_122_6527           |            |                            |
|                | DP_OP_1652J1_122_6527 |     |                            |
=============================================================================

Datapath Report for DP_OP_1652J1_122_6527
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_1652J1_122_6527 | sub_376 (MAZE.v:376) add_367 (MAZE.v:367)          |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 8     |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 8     | addsub(I1,1,I2) ( MAZE.v:367 MAZE.v:376 ) |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'add_85 (MAZE.v:85)' in design 'MAZE' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'lt_87 (MAZE.v:87)'.  (HDL-120)

Information: Operator associated with resources 'add_86 (MAZE.v:86)' in design 'MAZE' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'lt_87_2 (MAZE.v:87)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_1            | DW01_add         | apparch (area)     |                |
| add_x_2            | DW01_add         | apparch (area)     |                |
| gte_x_4            | DW_cmp           | apparch (area)     |                |
| gte_x_6            | DW_cmp           | apparch (area)     |                |
| add_x_12           | DW01_inc         | apparch (area)     |                |
| add_x_25           | DW01_inc         | apparch (area)     |                |
| gt_x_38            | DW_cmp           | apparch (area)     |                |
| add_x_19           | DW01_inc         | apparch (area)     |                |
| DP_OP_1652J1_122_6527                 |                    |                |
|                    | DP_OP_1652J1_122_6527 | str (area)    |                |
===============================================================================

1
