 
****************************************
Report : resources
Design : MAZE
Version: S-2021.06-SP2
Date   : Fri May  2 20:09:33 2025
****************************************


Resource Report for this hierarchy in file ./../01_RTL/MAZE.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_1        | DW01_add       | width=6    | add_91 (MAZE.v:91)         |
| add_x_2        | DW01_add       | width=6    | add_92 (MAZE.v:92)         |
| gte_x_4        | DW_cmp         | width=6    | gte_93 (MAZE.v:93)         |
| gte_x_6        | DW_cmp         | width=6    | gte_93_2 (MAZE.v:93)       |
| add_x_12       | DW01_inc       | width=6    | add_207 (MAZE.v:207)       |
| add_x_25       | DW01_inc       | width=2    | add_276 (MAZE.v:276)       |
| gt_x_38        | DW_cmp         | width=8    | gt_390 (MAZE.v:390)        |
| add_x_154      | DW01_inc       | width=4    | Q/add_51 (QUEUE.v:51)      |
| add_x_155      | DW01_inc       | width=4    | Q/add_61 (QUEUE.v:61)      |
| add_x_156      | DW01_inc       | width=5    | Q/add_72 (QUEUE.v:72)      |
| sub_x_157      | DW01_dec       | width=5    | Q/sub_73 (QUEUE.v:73)      |
| add_x_19       | DW01_inc       | width=6    | add_236 (MAZE.v:236)       |
|                |                |            | add_241 (MAZE.v:241)       |
| DP_OP_1659J1_122_2218           |            |                            |
|                | DP_OP_1659J1_122_2218 |     |                            |
=============================================================================

Datapath Report for DP_OP_1659J1_122_2218
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_1659J1_122_2218 | sub_390 (MAZE.v:390) add_386 (MAZE.v:386)          |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 8     |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 8     | addsub(I1,1,I2) ( MAZE.v:386 MAZE.v:390 ) |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'add_91 (MAZE.v:91)' in design 'MAZE' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'lt_93 (MAZE.v:93)'.  (HDL-120)

Information: Operator associated with resources 'add_92 (MAZE.v:92)' in design 'MAZE' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'lt_93_2 (MAZE.v:93)'.  (HDL-120)


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
| add_x_154          | DW01_inc         | apparch (area)     |                |
| add_x_155          | DW01_inc         | apparch (area)     |                |
| add_x_156          | DW01_inc         | apparch (area)     |                |
| sub_x_157          | DW01_dec         | apparch (area)     |                |
| add_x_19           | DW01_inc         | apparch (area)     |                |
| DP_OP_1659J1_122_2218                 |                    |                |
|                    | DP_OP_1659J1_122_2218 | str (area)    |                |
===============================================================================

1
