 
****************************************
Report : resources
Design : KT
Version: S-2021.06-SP2
Date   : Sat Feb 15 22:39:37 2025
****************************************


Resource Report for this hierarchy in file
        /home/eric/2021-Fall-NCTU-IC-Design-Lab/Lab02/Exercise/01_RTL/KT.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_1        | DW01_add       | width=4    | add_87 (KT.v:87)           |
| add_x_3        | DW01_add       | width=4    | add_88 (KT.v:88)           |
| lt_x_5         | DW_cmp         | width=4    | lt_92 (KT.v:92)            |
| gt_x_6         | DW_cmp         | width=4    | gt_92 (KT.v:92)            |
| lt_x_7         | DW_cmp         | width=4    | lt_92_2 (KT.v:92)          |
| gt_x_8         | DW_cmp         | width=4    | gt_92_2 (KT.v:92)          |
| eq_x_10        | DW_cmp         | width=3    | eq_117 (KT.v:117)          |
| sub_x_14       | DW01_sub       | width=4    | sub_173 (KT.v:173)         |
| sub_x_15       | DW01_sub       | width=4    | sub_174 (KT.v:174)         |
| add_x_62       | DW01_inc       | width=3    | add_434 (KT.v:434)         |
| sub_x_65       | DW01_dec       | width=5    | sub_469 (KT.v:469)         |
| lt_x_78        | DW_cmp         | width=5    | lt_562 (KT.v:562)          |
| add_x_99       | DW01_inc       | width=5    | add_635 (KT.v:635)         |
| eq_x_110       | DW_cmp         | width=4    | eq_178 (KT.v:178)          |
|                |                |            | eq_193 (KT.v:193)          |
| eq_x_111       | DW_cmp         | width=4    | eq_178_2 (KT.v:178)        |
|                |                |            | eq_181_2 (KT.v:181)        |
| eq_x_112       | DW_cmp         | width=4    | eq_181 (KT.v:181)          |
|                |                |            | eq_190 (KT.v:190)          |
| eq_x_113       | DW_cmp         | width=4    | eq_184 (KT.v:184)          |
|                |                |            | eq_187 (KT.v:187)          |
| eq_x_114       | DW_cmp         | width=4    | eq_184_2 (KT.v:184)        |
|                |                |            | eq_199_2 (KT.v:199)        |
| eq_x_115       | DW_cmp         | width=4    | eq_187_2 (KT.v:187)        |
|                |                |            | eq_196_2 (KT.v:196)        |
| eq_x_116       | DW_cmp         | width=4    | eq_190_2 (KT.v:190)        |
|                |                |            | eq_193_2 (KT.v:193)        |
| eq_x_117       | DW_cmp         | width=4    | eq_196 (KT.v:196)          |
|                |                |            | eq_199 (KT.v:199)          |
| DP_OP_390J1_122_1019            |            |                            |
|                | DP_OP_390J1_122_1019 |      |                            |
| DP_OP_391J1_123_9307            |            |                            |
|                | DP_OP_391J1_123_9307 |      |                            |
| DP_OP_392J1_124_3613            |            |                            |
|                | DP_OP_392J1_124_3613 |      |                            |
| DP_OP_393J1_125_3319            |            |                            |
|                | DP_OP_393J1_125_3319 |      |                            |
=============================================================================

Datapath Report for DP_OP_390J1_122_1019
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_390J1_122_1019 | mult_93 (KT.v:93) mult_93_2 (KT.v:93)               |
|                      | mult_93_3 (KT.v:93) add_93 (KT.v:93)                |
|                      | add_93_2 (KT.v:93) lt_93 (KT.v:93) gt_93 (KT.v:93)  |
|                      | add_93_3 (KT.v:93)                                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 4     |                                          |
| I2    | PI   | Signed   | 4     |                                          |
| T8    | IFO  | Signed   | 8     | $unsigned(3'b101) * I1 (KT.v:93)         |
| T9    | IFO  | Signed   | 9     | T8 + I2 (KT.v:93)                        |
| T368  | IFO  | Signed   | 5     | T8[4:0]                                  |
| O1    | PO   | Signed   | 1     | T9 < $signed(1'b0) (KT.v:93)             |
| O2    | PO   | Signed   | 1     | T9 > $signed(6'b011000) (KT.v:93)        |
| O3    | PO   | Signed   | 5     | T368 + I2 (KT.v:93)                      |
==============================================================================

Datapath Report for DP_OP_391J1_123_9307
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_391J1_123_9307 | mult_99 (KT.v:99) add_99 (KT.v:99)                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 4     |                                          |
| I2    | PI   | Signed   | 4     |                                          |
| T17   | IFO  | Signed   | 5     | $unsigned(3'b101) * I1 (KT.v:99)         |
| O1    | PO   | Signed   | 5     | T17 + I2 (KT.v:99)                       |
==============================================================================

Datapath Report for DP_OP_392J1_124_3613
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_392J1_124_3613 | add_451_S2 (KT.v:451) add_457 (KT.v:457)            |
|                      | add_476 (KT.v:476) add_553 (KT.v:553)               |
|                      | eq_553 (KT.v:553)                                   |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 5     |                                          |
| I2    | PI   | Unsigned | 5     |                                          |
| O1    | PO   | Unsigned | 6     | I1 + $unsigned(1'b1) ( KT.v:451 KT.v:457 KT.v:476 KT.v:553 ) |
| O2    | PO   | Unsigned | 1     | O1 == I2 (KT.v:553)                      |
==============================================================================

Datapath Report for DP_OP_393J1_125_3319
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_393J1_125_3319 | mult_498_S2 (KT.v:498) mult_502_S2 (KT.v:502)       |
|                      | add_498_S2 (KT.v:498) add_502_S2 (KT.v:502)         |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 3     |                                          |
| I2    | PI   | Unsigned | 3     |                                          |
| T120  | IFO  | Unsigned | 6     | I1 * $unsigned(3'b101) ( KT.v:498 KT.v:502 ) |
| O1    | PO   | Unsigned | 7     | T120 + I2 ( KT.v:498 KT.v:502 )          |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'add_87 (KT.v:87)' in design 'KT' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'C9815 (KT.v:87)'.  (HDL-120)

Information: Operator associated with resources 'add_88 (KT.v:88)' in design 'KT' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'C9816 (KT.v:88)'.  (HDL-120)

Information: Operator associated with resources 'add_434 (KT.v:434)' in design 'KT' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'C9895 (KT.v:430)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_1            | DW01_add         | apparch (area)     |                |
| add_x_3            | DW01_add         | apparch (area)     |                |
| lt_x_5             | DW_cmp           | apparch (area)     |                |
| gt_x_6             | DW_cmp           | apparch (area)     |                |
| lt_x_7             | DW_cmp           | apparch (area)     |                |
| gt_x_8             | DW_cmp           | apparch (area)     |                |
| eq_x_10            | DW_cmp           | apparch (area)     |                |
| sub_x_14           | DW01_sub         | apparch (area)     |                |
| sub_x_15           | DW01_sub         | apparch (area)     |                |
| add_x_62           | DW01_inc         | apparch (area)     |                |
| sub_x_65           | DW01_dec         | apparch (area)     |                |
| lt_x_78            | DW_cmp           | apparch (area)     |                |
| add_x_99           | DW01_inc         | apparch (area)     |                |
| eq_x_110           | DW_cmp           | apparch (area)     |                |
| eq_x_111           | DW_cmp           | apparch (area)     |                |
| eq_x_112           | DW_cmp           | apparch (area)     |                |
| eq_x_113           | DW_cmp           | apparch (area)     |                |
| eq_x_114           | DW_cmp           | apparch (area)     |                |
| eq_x_115           | DW_cmp           | apparch (area)     |                |
| eq_x_116           | DW_cmp           | apparch (area)     |                |
| eq_x_117           | DW_cmp           | apparch (area)     |                |
| DP_OP_390J1_122_1019                  |                    |                |
|                    | DP_OP_390J1_122_1019 | str (speed)    |                |
| DP_OP_391J1_123_9307                  |                    |                |
|                    | DP_OP_391J1_123_9307 | str (area)     |                |
| DP_OP_392J1_124_3613                  |                    |                |
|                    | DP_OP_392J1_124_3613 | str (area)     |                |
| DP_OP_393J1_125_3319                  |                    |                |
|                    | DP_OP_393J1_125_3319 | str (area)     |                |
===============================================================================

1
