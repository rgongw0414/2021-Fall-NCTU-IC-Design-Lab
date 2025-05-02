 
****************************************
Report : resources
Design : MAZE
Version: S-2021.06-SP2
Date   : Fri May  2 22:37:18 2025
****************************************


Resource Report for this hierarchy in file ./../01_RTL/MAZE.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_1        | DW01_add       | width=6    | add_91 (MAZE.v:91)         |
| add_x_2        | DW01_add       | width=6    | add_92 (MAZE.v:92)         |
| gte_x_4        | DW_cmp         | width=6    | gte_93 (MAZE.v:93)         |
| gte_x_6        | DW_cmp         | width=6    | gte_93_2 (MAZE.v:93)       |
| add_x_11       | DW01_inc       | width=6    | add_223 (MAZE.v:223)       |
| add_x_24       | DW01_inc       | width=2    | add_292 (MAZE.v:292)       |
| gt_x_908       | DW_cmp         | width=8    | gt_445 (MAZE.v:445)        |
| add_x_1023     | DW01_inc       | width=4    | Q/add_63 (QUEUE.v:63)      |
| add_x_1024     | DW01_inc       | width=4    | Q/add_73 (QUEUE.v:73)      |
| add_x_1025     | DW01_inc       | width=5    | Q/add_84 (QUEUE.v:84)      |
| sub_x_1026     | DW01_dec       | width=5    | Q/sub_85 (QUEUE.v:85)      |
| add_x_18       | DW01_inc       | width=6    | add_252 (MAZE.v:252)       |
|                |                |            | add_257 (MAZE.v:257)       |
| DP_OP_3096J1_122_2117           |            |                            |
|                | DP_OP_3096J1_122_2117 |     |                            |
=============================================================================

Datapath Report for DP_OP_3096J1_122_2117
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_3096J1_122_2117 | sub_445 (MAZE.v:445) add_441 (MAZE.v:441)          |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 8     |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Signed   | 8     | addsub(I1,1,I2) ( MAZE.v:441 MAZE.v:445 ) |
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
| add_x_11           | DW01_inc         | apparch (area)     |                |
| add_x_24           | DW01_inc         | apparch (area)     |                |
| gt_x_908           | DW_cmp           | apparch (area)     |                |
| add_x_1023         | DW01_inc         | apparch (area)     |                |
| add_x_1024         | DW01_inc         | apparch (area)     |                |
| add_x_1025         | DW01_inc         | apparch (area)     |                |
| sub_x_1026         | DW01_dec         | apparch (area)     |                |
| add_x_18           | DW01_inc         | apparch (area)     |                |
| DP_OP_3096J1_122_2117                 |                    |                |
|                    | DP_OP_3096J1_122_2117 | str (area)    |                |
===============================================================================

1
