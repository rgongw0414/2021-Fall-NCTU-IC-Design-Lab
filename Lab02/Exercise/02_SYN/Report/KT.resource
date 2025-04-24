 
****************************************
Report : resources
Design : KT
Version: S-2021.06-SP2
Date   : Fri Apr 25 01:43:29 2025
****************************************


Resource Report for this hierarchy in file
        /home/eric/2021-Fall-NCTU-IC-Design-Lab/Lab02/Exercise/01_RTL/KT.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_1        | DW01_add       | width=4    | add_89 (KT.v:89)           |
| add_x_3        | DW01_add       | width=4    | add_90 (KT.v:90)           |
| lt_x_5         | DW_cmp         | width=4    | lt_94 (KT.v:94)            |
| gt_x_6         | DW_cmp         | width=4    | gt_94 (KT.v:94)            |
| lt_x_7         | DW_cmp         | width=4    | lt_94_2 (KT.v:94)          |
| gt_x_8         | DW_cmp         | width=4    | gt_94_2 (KT.v:94)          |
| eq_x_10        | DW_cmp         | width=3    | eq_119 (KT.v:119)          |
| sub_x_14       | DW01_sub       | width=4    | sub_175 (KT.v:175)         |
| sub_x_15       | DW01_sub       | width=4    | sub_176 (KT.v:176)         |
| add_x_62       | DW01_inc       | width=3    | add_441 (KT.v:441)         |
| sub_x_65       | DW01_dec       | width=5    | sub_476 (KT.v:476)         |
| lt_x_78        | DW_cmp         | width=5    | lt_569 (KT.v:569)          |
| add_x_99       | DW01_inc       | width=5    | add_643 (KT.v:643)         |
| eq_x_112       | DW_cmp         | width=4    | eq_180 (KT.v:180)          |
|                |                |            | eq_195 (KT.v:195)          |
| eq_x_113       | DW_cmp         | width=4    | eq_180_2 (KT.v:180)        |
|                |                |            | eq_183_2 (KT.v:183)        |
| eq_x_114       | DW_cmp         | width=4    | eq_183 (KT.v:183)          |
|                |                |            | eq_192 (KT.v:192)          |
| eq_x_115       | DW_cmp         | width=4    | eq_186 (KT.v:186)          |
|                |                |            | eq_189 (KT.v:189)          |
| eq_x_116       | DW_cmp         | width=4    | eq_186_2 (KT.v:186)        |
|                |                |            | eq_201_2 (KT.v:201)        |
| eq_x_117       | DW_cmp         | width=4    | eq_189_2 (KT.v:189)        |
|                |                |            | eq_198_2 (KT.v:198)        |
| eq_x_118       | DW_cmp         | width=4    | eq_192_2 (KT.v:192)        |
|                |                |            | eq_195_2 (KT.v:195)        |
| eq_x_119       | DW_cmp         | width=4    | eq_198 (KT.v:198)          |
|                |                |            | eq_201 (KT.v:201)          |
| DP_OP_392J1_122_1019            |            |                            |
|                | DP_OP_392J1_122_1019 |      |                            |
| DP_OP_393J1_123_9307            |            |                            |
|                | DP_OP_393J1_123_9307 |      |                            |
| DP_OP_394J1_124_3613            |            |                            |
|                | DP_OP_394J1_124_3613 |      |                            |
| DP_OP_395J1_125_3319            |            |                            |
|                | DP_OP_395J1_125_3319 |      |                            |
=============================================================================

Datapath Report for DP_OP_392J1_122_1019
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_392J1_122_1019 | mult_95 (KT.v:95) mult_95_2 (KT.v:95)               |
|                      | mult_95_3 (KT.v:95) add_95 (KT.v:95)                |
|                      | add_95_2 (KT.v:95) lt_95 (KT.v:95) gt_95 (KT.v:95)  |
|                      | add_95_3 (KT.v:95)                                  |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 4     |                                          |
| I2    | PI   | Signed   | 4     |                                          |
| T8    | IFO  | Signed   | 8     | $unsigned(3'b101) * I1 (KT.v:95)         |
| T9    | IFO  | Signed   | 9     | T8 + I2 (KT.v:95)                        |
| T370  | IFO  | Signed   | 5     | T8[4:0]                                  |
| O1    | PO   | Signed   | 1     | T9 < $signed(1'b0) (KT.v:95)             |
| O2    | PO   | Signed   | 1     | T9 > $signed(6'b011000) (KT.v:95)        |
| O3    | PO   | Signed   | 5     | T370 + I2 (KT.v:95)                      |
==============================================================================

Datapath Report for DP_OP_393J1_123_9307
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_393J1_123_9307 | mult_101 (KT.v:101) add_101 (KT.v:101)              |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 4     |                                          |
| I2    | PI   | Signed   | 4     |                                          |
| T17   | IFO  | Signed   | 5     | $unsigned(3'b101) * I1 (KT.v:101)        |
| O1    | PO   | Signed   | 5     | T17 + I2 (KT.v:101)                      |
==============================================================================

Datapath Report for DP_OP_394J1_124_3613
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_394J1_124_3613 | add_458_S2 (KT.v:458) add_464 (KT.v:464)            |
|                      | add_483 (KT.v:483) add_560 (KT.v:560)               |
|                      | eq_560 (KT.v:560)                                   |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 5     |                                          |
| I2    | PI   | Unsigned | 5     |                                          |
| O1    | PO   | Unsigned | 6     | I1 + $unsigned(1'b1) ( KT.v:458 KT.v:464 KT.v:483 KT.v:560 ) |
| O2    | PO   | Unsigned | 1     | O1 == I2 (KT.v:560)                      |
==============================================================================

Datapath Report for DP_OP_395J1_125_3319
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_395J1_125_3319 | mult_505_S2 (KT.v:505) mult_509_S2 (KT.v:509)       |
|                      | add_505_S2 (KT.v:505) add_509_S2 (KT.v:509)         |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 3     |                                          |
| I2    | PI   | Unsigned | 3     |                                          |
| T120  | IFO  | Unsigned | 6     | I1 * $unsigned(3'b101) ( KT.v:505 KT.v:509 ) |
| O1    | PO   | Unsigned | 7     | T120 + I2 ( KT.v:505 KT.v:509 )          |
==============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'add_89 (KT.v:89)' in design 'KT' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'C10125 (KT.v:89)'.  (HDL-120)

Information: Operator associated with resources 'add_90 (KT.v:90)' in design 'KT' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'C10126 (KT.v:90)'.  (HDL-120)

Information: Operator associated with resources 'add_441 (KT.v:441)' in design 'KT' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'C10207 (KT.v:437)'.  (HDL-120)


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
| eq_x_112           | DW_cmp           | apparch (area)     |                |
| eq_x_113           | DW_cmp           | apparch (area)     |                |
| eq_x_114           | DW_cmp           | apparch (area)     |                |
| eq_x_115           | DW_cmp           | apparch (area)     |                |
| eq_x_116           | DW_cmp           | apparch (area)     |                |
| eq_x_117           | DW_cmp           | apparch (area)     |                |
| eq_x_118           | DW_cmp           | apparch (area)     |                |
| eq_x_119           | DW_cmp           | apparch (area)     |                |
| DP_OP_392J1_122_1019                  |                    |                |
|                    | DP_OP_392J1_122_1019 | str (speed)    |                |
| DP_OP_393J1_123_9307                  |                    |                |
|                    | DP_OP_393J1_123_9307 | str (area)     |                |
| DP_OP_394J1_124_3613                  |                    |                |
|                    | DP_OP_394J1_124_3613 | str (area)     |                |
| DP_OP_395J1_125_3319                  |                    |                |
|                    | DP_OP_395J1_125_3319 | str (area)     |                |
===============================================================================

1
