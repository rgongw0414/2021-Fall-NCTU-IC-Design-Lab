 
****************************************
Report : resources
Design : NN
Version: S-2021.06-SP2
Date   : Thu May 15 22:48:20 2025
****************************************


Resource Report for this hierarchy in file ./../01_RTL/NN.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_2        | DW01_inc       | width=7    | add_194 (NN.v:194)         |
| add_x_5        | DW01_inc       | width=5    | add_206 (NN.v:206)         |
| gt_x_8         | DW_cmp         | width=5    | gt_219 (NN.v:219)          |
| add_x_9        | DW01_inc       | width=3    | add_220 (NN.v:220)         |
| add_x_37       | DW01_inc       | width=2    | add_319 (NN.v:319)         |
| add_x_132      | DW01_inc       | width=3    | add_743 (NN.v:743)         |
| MAC1           | DW_fp_mac      | sig_width=23 | MAC1 (NN.v:132)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MAC2           | DW_fp_mac      | sig_width=23 | MAC2 (NN.v:133)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MAC3           | DW_fp_mac      | sig_width=23 | MAC3 (NN.v:134)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL1           | DW_fp_mult     | sig_width=23 | MUL1 (NN.v:135)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL2           | DW_fp_mult     | sig_width=23 | MUL2 (NN.v:136)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL3           | DW_fp_mult     | sig_width=23 | MUL3 (NN.v:137)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL4           | DW_fp_mult     | sig_width=23 | MUL4 (NN.v:138)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUB1           | DW_fp_sub      | sig_width=23 | SUB1 (NN.v:139)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUB2           | DW_fp_sub      | sig_width=23 | SUB2 (NN.v:140)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUB3           | DW_fp_sub      | sig_width=23 | SUB3 (NN.v:141)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUM1           | DW_fp_sum3     | sig_width=23 | SUM1 (NN.v:142)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
|                |                | arch_type=0 |                           |
| CMP1           | DW_fp_cmp      | sig_width=23 | CMP1 (NN.v:145)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| CMP2           | DW_fp_cmp      | sig_width=23 | CMP2 (NN.v:146)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| CMP3           | DW_fp_cmp      | sig_width=23 | CMP3 (NN.v:147)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
=============================================================================


Resource Report for Ungrouped Hierarchy CMP3 in file ./DW_fp_cmp__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| gt_x_3         | DW_cmp         | width=23   | gt_219                     |
| eq_x_4         | DW_cmp         | width=23   | eq_222                     |
| gt_x_5         | DW_cmp         | width=8    | gt_227                     |
| eq_x_6         | DW_cmp         | width=8    | eq_230                     |
=============================================================================


Resource Report for Ungrouped Hierarchy CMP2 in file ./DW_fp_cmp__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| gt_x_3         | DW_cmp         | width=23   | gt_219                     |
| eq_x_4         | DW_cmp         | width=23   | eq_222                     |
| gt_x_5         | DW_cmp         | width=8    | gt_227                     |
| eq_x_6         | DW_cmp         | width=8    | eq_230                     |
=============================================================================


Resource Report for Ungrouped Hierarchy CMP1 in file ./DW_fp_cmp__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| gt_x_3         | DW_cmp         | width=23   | gt_219                     |
| eq_x_4         | DW_cmp         | width=23   | eq_222                     |
| gt_x_5         | DW_cmp         | width=8    | gt_227                     |
| eq_x_6         | DW_cmp         | width=8    | eq_230                     |
=============================================================================


Resource Report for Ungrouped Hierarchy SUM1 in file ./DW_fp_sum3__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| eq_x_4         | DW_cmp         | width=31   | eq_400                     |
| eq_x_5         | DW_cmp         | width=31   | eq_411                     |
| eq_x_6         | DW_cmp         | width=31   | eq_422                     |
| gte_x_17       | DW_cmp         | width=8    | gte_452                    |
| gte_x_18       | DW_cmp         | width=8    | gte_452_2                  |
| gte_x_19       | DW_cmp         | width=8    | gte_454                    |
| gte_x_20       | DW_cmp         | width=8    | gte_454_2                  |
| sub_x_21       | DW01_sub       | width=8    | sub_458                    |
| sub_x_22       | DW01_sub       | width=8    | sub_459                    |
| sub_x_23       | DW01_sub       | width=8    | sub_460                    |
| ashr_28        | DW_rightsh     | A_width=51 | srl_470                    |
|                |                | SH_width=8 |                            |
| ash_29         | DW_leftsh      | A_width=51 | sll_472                    |
|                |                | SH_width=8 |                            |
| ashr_30        | DW_rightsh     | A_width=51 | srl_478                    |
|                |                | SH_width=8 |                            |
| ash_31         | DW_leftsh      | A_width=51 | sll_480                    |
|                |                | SH_width=8 |                            |
| ashr_32        | DW_rightsh     | A_width=51 | srl_486                    |
|                |                | SH_width=8 |                            |
| ash_33         | DW_leftsh      | A_width=51 | sll_488                    |
|                |                | SH_width=8 |                            |
| gt_x_34        | DW_cmp         | width=32   | gt_498                     |
| gt_x_35        | DW_cmp         | width=32   | gt_503                     |
| gt_x_36        | DW_cmp         | width=32   | gt_508                     |
| ash_46         | DW_leftsh      | A_width=53 | sll_562                    |
|                |                | SH_width=7 |                            |
| add_x_47       | DW01_add       | width=25   | add_575                    |
| U2             | DW_fp_ifp_conv | sig_widthi=23 | U2                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U3             | DW_fp_ifp_conv | sig_widthi=23 | U3                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U4             | DW_fp_ifp_conv | sig_widthi=23 | U4                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=28 |                         |
|                |                | exp_widtho=9 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U5             | DW_ifp_addsub  | sig_widthi=25 | U5                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=28 |                         |
|                |                | exp_widtho=9 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U6             | DW_ifp_addsub  | sig_widthi=28 | U6                      |
|                |                | exp_widthi=9 |                          |
|                |                | sig_widtho=51 |                         |
|                |                | exp_widtho=10 |                         |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U7             | DW_ifp_fp_conv | sig_widthi=51 | U7                      |
|                |                | exp_widthi=10 |                         |
|                |                | sig_width=23 |                          |
|                |                | exp_width=8 |                           |
|                |                | use_denormal=0 |                        |
| U1             | DW_lzd         | a_width=53 | U1                         |
| DP_OP_160J1_122_9276            |            |                            |
|                | DP_OP_160J1_122_9276 |      |                            |
| DP_OP_161J1_123_406             |            |                            |
|                | DP_OP_161J1_123_406 |       |                            |
=============================================================================

Datapath Report for DP_OP_160J1_122_9276
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_160J1_122_9276 | add_461 sub_564 sub_565 add_565                     |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 7     |                                          |
| O1    | PO   | Unsigned | 9     | I1 + $unsigned(2'b10)                    |
| O2    | PO   | Signed   | 10    | O1 - I2                                  |
| O3    | PO   | Signed   | 11    | $unsigned(1'b1) + O2                     |
==============================================================================

Datapath Report for DP_OP_161J1_123_406
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_161J1_123_406  | add_532 add_532_2 add_532_3 add_532_4 sub_add_537   |
|                      | add_537_ni                                          |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 52    |                                          |
| I2    | PI   | Signed   | 52    |                                          |
| I3    | PI   | Unsigned | 51    |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| T159  | IFO  | Signed   | 53    | O1[52:0]                                 |
| O1    | PO   | Signed   | 54    | I1 + I2 + I3 + I4 + I5                   |
| O2    | PO   | Signed   | 53    | -T159 + $unsigned(53'b00000000000000000000000000000000000000000000000000000) |
==============================================================================


Resource Report for Ungrouped Hierarchy SUB3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| U1             | DW_fp_addsub   | sig_width=23 | U1                       |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
=============================================================================


Resource Report for Ungrouped Hierarchy SUB2
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| U1             | DW_fp_addsub   | sig_width=23 | U1                       |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
=============================================================================


Resource Report for Ungrouped Hierarchy SUB1
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| U1             | DW_fp_addsub   | sig_width=23 | U1                       |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
=============================================================================


Resource Report for Ungrouped Hierarchy *cell*12533/UL2
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy *cell*12533/UL1
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL3 in file ./DW_fp_mult__str.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| gte_x_2        | DW_cmp         | width=9    | gte_401                    |
| gte_x_4        | DW_cmp         | width=9    | gte_403                    |
| add_x_11       | DW01_add       | width=7    | add_480_4                  |
| add_x_12       | DW01_add       | width=24   | add_528                    |
| add_x_13       | DW01_add       | width=26   | add_529                    |
| eq_x_14        | DW_cmp         | width=10   | eq_553                     |
| lt_x_21        | DW_cmp         | width=8    | lt_615                     |
| lt_x_23        | DW_cmp         | width=8    | lt_619                     |
| add_x_24       | DW01_add       | width=3    | add_622                    |
| add_x_25       | DW01_add       | width=2    | add_623_ni                 |
| UL3            | DW_lzd         | a_width=24 | UL3                        |
| UL4            | DW_lzd         | a_width=24 | UL4                        |
| UM1            | DW02_multp     | a_width=24 | UM1                        |
|                |                | b_width=24 |                            |
|                |                | out_width=50 |                          |
|                |                | verif_en=1 |                            |
| DP_OP_108_153_7736              |            |                            |
|                | DP_OP_108_153_7736 |        |                            |
| DP_OP_109_154_8092              |            |                            |
|                | DP_OP_109_154_8092 |        |                            |
=============================================================================

Datapath Report for DP_OP_108_153_7736
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_108_153_7736   | add_384_4 sub_384_3 add_387 lte_399 lt_400          |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 8     |                                          |
| T58   | IFO  | Signed   | 8     | O1[7:0]                                  |
| O1    | PO   | Signed   | 10    | I1 + I2 - $unsigned(7'b1111111)          |
| O2    | PO   | Unsigned | 8     | T58 + $unsigned(1'b1)                    |
| O3    | PO   | Signed   | 1     | O1 <= $signed(1'b0)                      |
| O4    | PO   | Signed   | 1     | O1 < $signed(1'b0)                       |
==============================================================================

Datapath Report for DP_OP_109_154_8092
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_109_154_8092   | add_535 add_568 add_569                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 23    |                                          |
| I2    | PI   | Unsigned | 23    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| T69   | IFO  | Signed   | 22    | O1[21:0]                                 |
| T71   | IFO  | Signed   | 21    | O1[20:0]                                 |
| O1    | PO   | Unsigned | 23    | I1 + I2                                  |
| O2    | PO   | Unsigned | 22    | T69 + I3                                 |
| O3    | PO   | Unsigned | 21    | T71 + I4                                 |
==============================================================================


Resource Report for Ungrouped Hierarchy *cell*22305/UL2
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy *cell*22305/UL1
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL2 in file ./DW_fp_mult__str.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| gte_x_2        | DW_cmp         | width=9    | gte_401                    |
| gte_x_4        | DW_cmp         | width=9    | gte_403                    |
| add_x_11       | DW01_add       | width=7    | add_480_4                  |
| add_x_12       | DW01_add       | width=24   | add_528                    |
| add_x_13       | DW01_add       | width=26   | add_529                    |
| eq_x_14        | DW_cmp         | width=10   | eq_553                     |
| lt_x_21        | DW_cmp         | width=8    | lt_615                     |
| lt_x_23        | DW_cmp         | width=8    | lt_619                     |
| add_x_24       | DW01_add       | width=3    | add_622                    |
| add_x_25       | DW01_add       | width=2    | add_623_ni                 |
| UL3            | DW_lzd         | a_width=24 | UL3                        |
| UL4            | DW_lzd         | a_width=24 | UL4                        |
| UM1            | DW02_multp     | a_width=24 | UM1                        |
|                |                | b_width=24 |                            |
|                |                | out_width=50 |                          |
|                |                | verif_en=1 |                            |
| DP_OP_108_157_7736              |            |                            |
|                | DP_OP_108_157_7736 |        |                            |
| DP_OP_109_158_8092              |            |                            |
|                | DP_OP_109_158_8092 |        |                            |
=============================================================================

Datapath Report for DP_OP_108_157_7736
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_108_157_7736   | add_384_4 sub_384_3 add_387 lte_399 lt_400          |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 8     |                                          |
| T58   | IFO  | Signed   | 8     | O1[7:0]                                  |
| O1    | PO   | Signed   | 10    | I1 + I2 - $unsigned(7'b1111111)          |
| O2    | PO   | Unsigned | 8     | T58 + $unsigned(1'b1)                    |
| O3    | PO   | Signed   | 1     | O1 <= $signed(1'b0)                      |
| O4    | PO   | Signed   | 1     | O1 < $signed(1'b0)                       |
==============================================================================

Datapath Report for DP_OP_109_158_8092
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_109_158_8092   | add_535 add_568 add_569                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 23    |                                          |
| I2    | PI   | Unsigned | 23    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| T69   | IFO  | Signed   | 22    | O1[21:0]                                 |
| T71   | IFO  | Signed   | 21    | O1[20:0]                                 |
| O1    | PO   | Unsigned | 23    | I1 + I2                                  |
| O2    | PO   | Unsigned | 22    | T69 + I3                                 |
| O3    | PO   | Unsigned | 21    | T71 + I4                                 |
==============================================================================


Resource Report for Ungrouped Hierarchy *cell*32048/UL2
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy *cell*32048/UL1
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL1 in file ./DW_fp_mult__str.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| gte_x_2        | DW_cmp         | width=9    | gte_401                    |
| gte_x_4        | DW_cmp         | width=9    | gte_403                    |
| add_x_11       | DW01_add       | width=7    | add_480_4                  |
| add_x_12       | DW01_add       | width=24   | add_528                    |
| add_x_13       | DW01_add       | width=26   | add_529                    |
| eq_x_14        | DW_cmp         | width=10   | eq_553                     |
| lt_x_21        | DW_cmp         | width=8    | lt_615                     |
| lt_x_23        | DW_cmp         | width=8    | lt_619                     |
| add_x_24       | DW01_add       | width=3    | add_622                    |
| add_x_25       | DW01_add       | width=2    | add_623_ni                 |
| UL3            | DW_lzd         | a_width=24 | UL3                        |
| UL4            | DW_lzd         | a_width=24 | UL4                        |
| UM1            | DW02_multp     | a_width=24 | UM1                        |
|                |                | b_width=24 |                            |
|                |                | out_width=50 |                          |
|                |                | verif_en=1 |                            |
| DP_OP_108_161_7736              |            |                            |
|                | DP_OP_108_161_7736 |        |                            |
| DP_OP_109_162_8092              |            |                            |
|                | DP_OP_109_162_8092 |        |                            |
=============================================================================

Datapath Report for DP_OP_108_161_7736
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_108_161_7736   | add_384_4 sub_384_3 add_387 lte_399 lt_400          |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 8     |                                          |
| T58   | IFO  | Signed   | 8     | O1[7:0]                                  |
| O1    | PO   | Signed   | 10    | I1 + I2 - $unsigned(7'b1111111)          |
| O2    | PO   | Unsigned | 8     | T58 + $unsigned(1'b1)                    |
| O3    | PO   | Signed   | 1     | O1 <= $signed(1'b0)                      |
| O4    | PO   | Signed   | 1     | O1 < $signed(1'b0)                       |
==============================================================================

Datapath Report for DP_OP_109_162_8092
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_109_162_8092   | add_535 add_568 add_569                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 23    |                                          |
| I2    | PI   | Unsigned | 23    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| T69   | IFO  | Signed   | 22    | O1[21:0]                                 |
| T71   | IFO  | Signed   | 21    | O1[20:0]                                 |
| O1    | PO   | Unsigned | 23    | I1 + I2                                  |
| O2    | PO   | Unsigned | 22    | T69 + I3                                 |
| O3    | PO   | Unsigned | 21    | T71 + I4                                 |
==============================================================================


Resource Report for Ungrouped Hierarchy *cell*J3*108888/U1 in file
        ./DW_norm_rtl.vhd.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| U2             | DW01_ash       | A_width=27 | U2                         |
|                |                | SH_width=3 |                            |
=============================================================================


Resource Report for Ungrouped Hierarchy SUB1/U1 in file
        ./DW_fp_addsub__str.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| lt_x_1         | DW_cmp         | width=31   | lt_223                     |
| ashr_5         | DW_rightsh     | A_width=26 | srl_283_lsb_trim           |
|                |                | SH_width=8 |                            |
| ash_6          | DW_leftsh      | A_width=26 | sll_285                    |
|                |                | SH_width=8 |                            |
| ash_8          | DW_leftsh      | A_width=27 | sll_337                    |
|                |                | SH_width=6 |                            |
| add_x_9        | DW01_add       | width=5    | add_339                    |
| add_x_16       | DW01_inc       | width=23   | add_398                    |
| U2             | DW_lzd         | a_width=28 | U2                         |
| U1             | DW_norm        | a_width=27 | U1                         |
|                |                | srch_wind=3 |                           |
|                |                | exp_width=6 |                           |
|                |                | exp_ctr=0  |                            |
| DP_OP_65J3_195_7885             |            |                            |
|                | DP_OP_65J3_195_7885 |       |                            |
| DP_OP_66J3_196_3163             |            |                            |
|                | DP_OP_66J3_196_3163 |       |                            |
| DP_OP_67J3_197_9752             |            |                            |
|                | DP_OP_67J3_197_9752 |       |                            |
=============================================================================

Datapath Report for DP_OP_65J3_195_7885
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_65J3_195_7885  | sub_277 sub_add_279 add_279_ni                      |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 8     |                                          |
| T64   | IFO  | Signed   | 8     | O1[7:0]                                  |
| O1    | PO   | Signed   | 9     | I1 - I2                                  |
| O2    | PO   | Signed   | 8     | -T64 + $unsigned(8'b00000000)            |
==============================================================================

Datapath Report for DP_OP_66J3_196_3163
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_66J3_196_3163  | add_294 add_294_2                                   |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 27    |                                          |
| I2    | PI   | Unsigned | 28    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Unsigned | 28    | I1 + I2 + I3                             |
==============================================================================

Datapath Report for DP_OP_67J3_197_9752
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_67J3_197_9752  | add_402 sub_403                                     |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 5     |                                          |
| O1    | PO   | Unsigned | 9     | I1 + $unsigned(1'b1)                     |
| O2    | PO   | Signed   | 10    | O1 - I2                                  |
==============================================================================


Resource Report for Ungrouped Hierarchy SUM1/U1
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy SUB3/U1 in file
        ./DW_fp_addsub__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| lt_x_1         | DW_cmp         | width=31   | lt_191                     |
| sub_x_4        | DW01_sub       | width=8    | sub_232                    |
| ashr_5         | DW_rightsh     | A_width=26 | srl_237_lsb_trim           |
|                |                | SH_width=8 |                            |
| ash_6          | DW_leftsh      | A_width=26 | sll_239                    |
|                |                | SH_width=8 |                            |
| ash_8          | DW_leftsh      | A_width=26 | sll_266                    |
|                |                | SH_width=5 |                            |
| add_x_12       | DW01_inc       | width=23   | add_303                    |
| U1             | DW_lzd         | a_width=27 | U1                         |
| DP_OP_49J1_127_3163             |            |                            |
|                | DP_OP_49J1_127_3163 |       |                            |
| DP_OP_50J1_128_9752             |            |                            |
|                | DP_OP_50J1_128_9752 |       |                            |
=============================================================================

Datapath Report for DP_OP_49J1_127_3163
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_49J1_127_3163  | add_249 add_249_2                                   |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 27    |                                          |
| I2    | PI   | Unsigned | 28    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Unsigned | 28    | I1 + I2 + I3                             |
==============================================================================

Datapath Report for DP_OP_50J1_128_9752
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_50J1_128_9752  | add_306 sub_307                                     |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 5     |                                          |
| O1    | PO   | Unsigned | 9     | I1 + $unsigned(1'b1)                     |
| O2    | PO   | Signed   | 10    | O1 - I2                                  |
==============================================================================


Resource Report for Ungrouped Hierarchy SUB2/U1 in file
        ./DW_fp_addsub__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| lt_x_1         | DW_cmp         | width=31   | lt_191                     |
| sub_x_4        | DW01_sub       | width=8    | sub_232                    |
| ashr_5         | DW_rightsh     | A_width=26 | srl_237_lsb_trim           |
|                |                | SH_width=8 |                            |
| ash_6          | DW_leftsh      | A_width=26 | sll_239                    |
|                |                | SH_width=8 |                            |
| ash_8          | DW_leftsh      | A_width=26 | sll_266                    |
|                |                | SH_width=5 |                            |
| add_x_12       | DW01_inc       | width=23   | add_303                    |
| U1             | DW_lzd         | a_width=27 | U1                         |
| DP_OP_49J1_129_3163             |            |                            |
|                | DP_OP_49J1_129_3163 |       |                            |
| DP_OP_50J1_130_9752             |            |                            |
|                | DP_OP_50J1_130_9752 |       |                            |
=============================================================================

Datapath Report for DP_OP_49J1_129_3163
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_49J1_129_3163  | add_249 add_249_2                                   |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 27    |                                          |
| I2    | PI   | Unsigned | 28    |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Unsigned | 28    | I1 + I2 + I3                             |
==============================================================================

Datapath Report for DP_OP_50J1_130_9752
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_50J1_130_9752  | add_306 sub_307                                     |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 5     |                                          |
| O1    | PO   | Unsigned | 9     | I1 + $unsigned(1'b1)                     |
| O2    | PO   | Signed   | 10    | O1 - I2                                  |
==============================================================================


Resource Report for Ungrouped Hierarchy MUL4/U3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL4 in file ./DW_fp_mult__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_2        | DW01_inc       | width=8    | add_366                    |
| lte_x_3        | DW_cmp         | width=10   | lte_374                    |
| gte_x_5        | DW_cmp         | width=9    | gte_384                    |
| gte_x_7        | DW_cmp         | width=9    | gte_386                    |
| add_x_12       | DW01_add       | width=7    | add_471_4                  |
| mult_x_13      | DW_mult_uns    | a_width=24 | mult_477                   |
|                |                | b_width=24 |                            |
| eq_x_14        | DW_cmp         | width=10   | eq_478                     |
| lt_x_17        | DW_cmp         | width=8    | lt_492                     |
| lt_x_19        | DW_cmp         | width=8    | lt_497                     |
| add_x_20       | DW01_add       | width=24   | add_501                    |
| U1             | DW_lzd         | a_width=24 | U1                         |
| U2             | DW_lzd         | a_width=24 | U2                         |
| U3             | DW_lzd         | a_width=24 | U3                         |
| U4             | DW_lzd         | a_width=24 | U4                         |
| sub_x_33       | DW01_sub       | width=9    | add_363 sub_363            |
| add_x_34       | DW01_add       | width=10   | add_363 sub_363            |
=============================================================================


Resource Report for Ungrouped Hierarchy MAC3 in file ./DW_fp_mac__str.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| eq_x_4         | DW_cmp         | width=7    | eq_475                     |
| sub_x_5        | DW01_sub       | width=8    | sub_475_2                  |
| eq_x_6         | DW_cmp         | width=32   | eq_475_2                   |
| ashr_13        | DW_rightsh     | A_width=75 | srl_549                    |
|                |                | SH_width=7 |                            |
| eq_x_17        | DW_cmp         | width=24   | eq_562                     |
| ash_19         | DW_leftsh      | A_width=53 | sll_576                    |
|                |                | SH_width=6 |                            |
| add_x_20       | DW01_add       | width=10   | add_594_aco                |
| eq_x_21        | DW_cmp         | width=28   | eq_635                     |
| add_x_29       | DW01_inc       | width=23   | add_667                    |
| eq_x_31        | DW_cmp         | width=23   | eq_669                     |
| UM1            | DW02_multp     | a_width=24 | UM1                        |
|                |                | b_width=24 |                            |
|                |                | out_width=50 |                          |
|                |                | verif_en=1 |                            |
| ULSD           | DW_lsd         | a_width=53 | ULSD                       |
| DP_OP_207J10_198_9016           |            |                            |
|                | DP_OP_207J10_198_9016 |     |                            |
| DP_OP_208J10_199_5508           |            |                            |
|                | DP_OP_208J10_199_5508 |     |                            |
| DP_OP_209J10_200_153            |            |                            |
|                | DP_OP_209J10_200_153 |      |                            |
| DP_OP_210J10_201_6827           |            |                            |
|                | DP_OP_210J10_201_6827 |     |                            |
=============================================================================

Datapath Report for DP_OP_207J10_198_9016
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_207J10_198_9016 | add_435_5 sub_435_4 sub_435_5 add_435_6            |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 7     |                                          |
| I2    | PI   | Signed   | 7     |                                          |
| I3    | PI   | Signed   | 7     |                                          |
| O1    | PO   | Signed   | 7     | I1 + I2 - I3 + $unsigned(7'b0011101)     |
==============================================================================

Datapath Report for DP_OP_208J10_199_5508
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_208J10_199_5508 | add_559 add_559_2 add_559_3 sub_add_565 add_565_ni |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 77    |                                          |
| I2    | PI   | Unsigned | 77    |                                          |
| I3    | PI   | Unsigned | 75    |                                          |
| I4    | PI   | Unsigned | 2     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| T204  | IFO  | Unsigned | 53    | O1[76:24]                                |
| O1    | PO   | Unsigned | 77    | I1 + I2 + I3 + I4                        |
| O2    | PO   | Signed   | 53    | $signed(1'b1) - T204 + I5                |
==============================================================================

Datapath Report for DP_OP_209J10_200_153
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_209J10_200_153 | add_674 sub_674 gte_674                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 10    |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| T155  | IFO  | Signed   | 12    | I1 + I2 - $unsigned(8'b11111111)         |
| O1    | PO   | Signed   | 1     | T155 >= $signed(1'b0)                    |
==============================================================================

Datapath Report for DP_OP_210J10_201_6827
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_210J10_201_6827 | add_671_ni add_671_2                               |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Unsigned | 8     | I1 + I2 + I3                             |
==============================================================================


Resource Report for Ungrouped Hierarchy MAC2 in file ./DW_fp_mac__str.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| eq_x_4         | DW_cmp         | width=7    | eq_475                     |
| sub_x_5        | DW01_sub       | width=8    | sub_475_2                  |
| eq_x_6         | DW_cmp         | width=32   | eq_475_2                   |
| ashr_13        | DW_rightsh     | A_width=75 | srl_549                    |
|                |                | SH_width=7 |                            |
| eq_x_17        | DW_cmp         | width=24   | eq_562                     |
| ash_19         | DW_leftsh      | A_width=53 | sll_576                    |
|                |                | SH_width=6 |                            |
| add_x_20       | DW01_add       | width=10   | add_594_aco                |
| eq_x_21        | DW_cmp         | width=28   | eq_635                     |
| add_x_29       | DW01_inc       | width=23   | add_667                    |
| eq_x_31        | DW_cmp         | width=23   | eq_669                     |
| UM1            | DW02_multp     | a_width=24 | UM1                        |
|                |                | b_width=24 |                            |
|                |                | out_width=50 |                          |
|                |                | verif_en=1 |                            |
| ULSD           | DW_lsd         | a_width=53 | ULSD                       |
| DP_OP_207J11_198_9016           |            |                            |
|                | DP_OP_207J11_198_9016 |     |                            |
| DP_OP_208J11_199_5508           |            |                            |
|                | DP_OP_208J11_199_5508 |     |                            |
| DP_OP_209J11_200_153            |            |                            |
|                | DP_OP_209J11_200_153 |      |                            |
| DP_OP_210J11_201_6827           |            |                            |
|                | DP_OP_210J11_201_6827 |     |                            |
=============================================================================

Datapath Report for DP_OP_207J11_198_9016
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_207J11_198_9016 | add_435_5 sub_435_4 sub_435_5 add_435_6            |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 7     |                                          |
| I2    | PI   | Signed   | 7     |                                          |
| I3    | PI   | Signed   | 7     |                                          |
| O1    | PO   | Signed   | 7     | I1 + I2 - I3 + $unsigned(7'b0011101)     |
==============================================================================

Datapath Report for DP_OP_208J11_199_5508
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_208J11_199_5508 | add_559 add_559_2 add_559_3 sub_add_565 add_565_ni |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 77    |                                          |
| I2    | PI   | Unsigned | 77    |                                          |
| I3    | PI   | Unsigned | 75    |                                          |
| I4    | PI   | Unsigned | 2     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| T204  | IFO  | Unsigned | 53    | O1[76:24]                                |
| O1    | PO   | Unsigned | 77    | I1 + I2 + I3 + I4                        |
| O2    | PO   | Signed   | 53    | $signed(1'b1) - T204 + I5                |
==============================================================================

Datapath Report for DP_OP_209J11_200_153
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_209J11_200_153 | add_674 sub_674 gte_674                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 10    |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| T155  | IFO  | Signed   | 12    | I1 + I2 - $unsigned(8'b11111111)         |
| O1    | PO   | Signed   | 1     | T155 >= $signed(1'b0)                    |
==============================================================================

Datapath Report for DP_OP_210J11_201_6827
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_210J11_201_6827 | add_671_ni add_671_2                               |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Unsigned | 8     | I1 + I2 + I3                             |
==============================================================================


Resource Report for Ungrouped Hierarchy MAC1 in file ./DW_fp_mac__str.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| eq_x_4         | DW_cmp         | width=7    | eq_475                     |
| sub_x_5        | DW01_sub       | width=8    | sub_475_2                  |
| eq_x_6         | DW_cmp         | width=32   | eq_475_2                   |
| ashr_13        | DW_rightsh     | A_width=75 | srl_549                    |
|                |                | SH_width=7 |                            |
| eq_x_17        | DW_cmp         | width=24   | eq_562                     |
| ash_19         | DW_leftsh      | A_width=53 | sll_576                    |
|                |                | SH_width=6 |                            |
| add_x_20       | DW01_add       | width=10   | add_594_aco                |
| eq_x_21        | DW_cmp         | width=28   | eq_635                     |
| add_x_29       | DW01_inc       | width=23   | add_667                    |
| eq_x_31        | DW_cmp         | width=23   | eq_669                     |
| UM1            | DW02_multp     | a_width=24 | UM1                        |
|                |                | b_width=24 |                            |
|                |                | out_width=50 |                          |
|                |                | verif_en=1 |                            |
| ULSD           | DW_lsd         | a_width=53 | ULSD                       |
| DP_OP_207J12_198_9016           |            |                            |
|                | DP_OP_207J12_198_9016 |     |                            |
| DP_OP_208J12_199_5508           |            |                            |
|                | DP_OP_208J12_199_5508 |     |                            |
| DP_OP_209J12_200_153            |            |                            |
|                | DP_OP_209J12_200_153 |      |                            |
| DP_OP_210J12_201_6827           |            |                            |
|                | DP_OP_210J12_201_6827 |     |                            |
=============================================================================

Datapath Report for DP_OP_207J12_198_9016
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_207J12_198_9016 | add_435_5 sub_435_4 sub_435_5 add_435_6            |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 7     |                                          |
| I2    | PI   | Signed   | 7     |                                          |
| I3    | PI   | Signed   | 7     |                                          |
| O1    | PO   | Signed   | 7     | I1 + I2 - I3 + $unsigned(7'b0011101)     |
==============================================================================

Datapath Report for DP_OP_208J12_199_5508
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_208J12_199_5508 | add_559 add_559_2 add_559_3 sub_add_565 add_565_ni |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 77    |                                          |
| I2    | PI   | Unsigned | 77    |                                          |
| I3    | PI   | Unsigned | 75    |                                          |
| I4    | PI   | Unsigned | 2     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| T204  | IFO  | Unsigned | 53    | O1[76:24]                                |
| O1    | PO   | Unsigned | 77    | I1 + I2 + I3 + I4                        |
| O2    | PO   | Signed   | 53    | $signed(1'b1) - T204 + I5                |
==============================================================================

Datapath Report for DP_OP_209J12_200_153
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_209J12_200_153 | add_674 sub_674 gte_674                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Signed   | 10    |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| T155  | IFO  | Signed   | 12    | I1 + I2 - $unsigned(8'b11111111)         |
| O1    | PO   | Signed   | 1     | T155 >= $signed(1'b0)                    |
==============================================================================

Datapath Report for DP_OP_210J12_201_6827
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_210J12_201_6827 | add_671_ni add_671_2                               |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 1     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| O1    | PO   | Unsigned | 8     | I1 + I2 + I3                             |
==============================================================================


Resource Report for Ungrouped Hierarchy MAC3/ULSD
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| U1             | DW_lzod        | a_width=53 | U1                         |
|                |                | detect_1=0 |                            |
=============================================================================


Resource Report for Ungrouped Hierarchy MAC2/ULSD
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| U1             | DW_lzod        | a_width=53 | U1                         |
|                |                | detect_1=0 |                            |
=============================================================================


Resource Report for Ungrouped Hierarchy MAC1/ULSD
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| U1             | DW_lzod        | a_width=53 | U1                         |
|                |                | detect_1=0 |                            |
=============================================================================


Resource Report for Ungrouped Hierarchy MUL4/U4
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy SUB1/U1/U2
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MAC3/ULZD3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MAC2/ULZD3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MAC1/ULZD3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL3/UL4
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL2/UL4
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL1/UL4
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL2/UL3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL3/UL3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL1/UL3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy SUB3/U1/U1
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy SUB2/U1/U1
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_2            | DW01_inc         | apparch (area)     |                |
| add_x_5            | DW01_inc         | apparch (area)     |                |
| gt_x_8             | DW_cmp           | apparch (area)     |                |
| add_x_9            | DW01_inc         | apparch (area)     |                |
| add_x_37           | DW01_inc         | apparch (area)     |                |
| add_x_132          | DW01_inc         | apparch (area)     |                |
| MAC1               | DW_fp_mac        | str                |                |
| MAC2               | DW_fp_mac        | str                |                |
| MAC3               | DW_fp_mac        | str                |                |
| MUL1               | DW_fp_mult       | str                |                |
| MUL2               | DW_fp_mult       | str                |                |
| MUL3               | DW_fp_mult       | str                |                |
| MUL4               | DW_fp_mult       | rtl                |                |
| SUB1               | DW_fp_sub        | rtl                |                |
| SUB2               | DW_fp_sub        | rtl                |                |
| SUB3               | DW_fp_sub        | rtl                |                |
| SUM1               | DW_fp_sum3       | rtl                |                |
| CMP1               | DW_fp_cmp        | rtl                |                |
| CMP2               | DW_fp_cmp        | rtl                |                |
| CMP3               | DW_fp_cmp        | rtl                |                |
| gt_x_3             | DW_cmp           | apparch (area)     |                |
| gt_x_5             | DW_cmp           | apparch (area)     |                |
| eq_x_6             | DW_cmp           | apparch (area)     |                |
| gt_x_3             | DW_cmp           | apparch (area)     |                |
| gt_x_5             | DW_cmp           | apparch (area)     |                |
| eq_x_6             | DW_cmp           | apparch (area)     |                |
| gt_x_3             | DW_cmp           | apparch (area)     |                |
| gt_x_5             | DW_cmp           | apparch (area)     |                |
| eq_x_6             | DW_cmp           | apparch (area)     |                |
| eq_x_4             | DW_cmp           | apparch (area)     |                |
| eq_x_5             | DW_cmp           | apparch (area)     |                |
| eq_x_6             | DW_cmp           | apparch (area)     |                |
| gte_x_17           | DW_cmp           | apparch (area)     |                |
| gte_x_18           | DW_cmp           | apparch (area)     |                |
| gte_x_19           | DW_cmp           | apparch (area)     |                |
| gte_x_20           | DW_cmp           | apparch (area)     |                |
| sub_x_21           | DW01_sub         | pparch (area,speed)                 |
| sub_x_22           | DW01_sub         | pparch (area,speed)                 |
| sub_x_23           | DW01_sub         | pparch (area,speed)                 |
| ashr_28            | DW_rightsh       | astr (area)        |                |
| ash_29             | DW_leftsh        | astr (area)        |                |
| ashr_30            | DW_rightsh       | astr (area)        |                |
| ash_31             | DW_leftsh        | astr (area)        |                |
| ashr_32            | DW_rightsh       | astr (area)        |                |
| ash_33             | DW_leftsh        | astr (area)        |                |
| gt_x_34            | DW_cmp           | pparch (area,speed)                 |
| gt_x_35            | DW_cmp           | pparch (area,speed)                 |
| gt_x_36            | DW_cmp           | pparch (area,speed)                 |
| ash_46             | DW_leftsh        | astr (area)        |                |
| add_x_47           | DW01_add         | pparch (area,speed)                 |
| U1                 | DW_lzd           | cla                |                |
| U1                 | DW_fp_addsub     | rtl                |                |
| U1                 | DW_fp_addsub     | rtl                |                |
| U1                 | DW_fp_addsub     | str                |                |
| gte_x_2            | DW_cmp           | apparch (area)     |                |
| gte_x_4            | DW_cmp           | apparch (area)     |                |
| add_x_11           | DW01_add         | pparch (area,speed)                 |
| add_x_12           | DW01_add         | pparch (area,speed)                 |
| add_x_13           | DW01_add         | pparch (area,speed)                 |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_21            | DW_cmp           | apparch (area)     |                |
| lt_x_23            | DW_cmp           | apparch (area)     |                |
| add_x_24           | DW01_add         | apparch (area)     |                |
| add_x_25           | DW01_add         | apparch (area)     |                |
| UL3                | DW_lzd           | cla                |                |
| UL4                | DW_lzd           | cla                |                |
| UM1                | DW02_multp       | pparch (speed)     |                |
|                    |                  | mult_arch: benc_radix4              |
| gte_x_2            | DW_cmp           | apparch (area)     |                |
| gte_x_4            | DW_cmp           | apparch (area)     |                |
| add_x_11           | DW01_add         | pparch (area,speed)                 |
| add_x_12           | DW01_add         | pparch (area,speed)                 |
| add_x_13           | DW01_add         | pparch (area,speed)                 |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_21            | DW_cmp           | apparch (area)     |                |
| lt_x_23            | DW_cmp           | apparch (area)     |                |
| add_x_24           | DW01_add         | apparch (area)     |                |
| add_x_25           | DW01_add         | apparch (area)     |                |
| UL3                | DW_lzd           | cla                |                |
| UL4                | DW_lzd           | cla                |                |
| UM1                | DW02_multp       | pparch (speed)     |                |
|                    |                  | mult_arch: benc_radix4              |
| gte_x_2            | DW_cmp           | apparch (area)     |                |
| gte_x_4            | DW_cmp           | apparch (area)     |                |
| add_x_11           | DW01_add         | pparch (area,speed)                 |
| add_x_12           | DW01_add         | pparch (area,speed)                 |
| add_x_13           | DW01_add         | pparch (area,speed)                 |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_21            | DW_cmp           | apparch (area)     |                |
| lt_x_23            | DW_cmp           | apparch (area)     |                |
| add_x_24           | DW01_add         | apparch (area)     |                |
| add_x_25           | DW01_add         | apparch (area)     |                |
| UL3                | DW_lzd           | cla                |                |
| UL4                | DW_lzd           | cla                |                |
| UM1                | DW02_multp       | pparch (speed)     |                |
|                    |                  | mult_arch: benc_radix4              |
| U2                 | DW01_ash         | astr (area)        |                |
| lt_x_1             | DW_cmp           | pparch (area,speed)                 |
| ashr_5             | DW_rightsh       | astr (area)        |                |
| ash_6              | DW_leftsh        | astr (area)        |                |
| ash_8              | DW_leftsh        | astr (area)        |                |
| add_x_9            | DW01_add         | apparch (area)     |                |
| add_x_16           | DW01_inc         | pparch (area,speed)                 |
| U2                 | DW_lzd           | cla                |                |
| U1                 | DW_norm          | rtl                |                |
| lt_x_1             | DW_cmp           | pparch (area,speed)                 |
| sub_x_4            | DW01_sub         | pparch (area,speed)                 |
| ashr_5             | DW_rightsh       | astr (area)        |                |
| ash_6              | DW_leftsh        | astr (area)        |                |
| ash_8              | DW_leftsh        | astr (area)        |                |
| add_x_12           | DW01_inc         | pparch (area,speed)                 |
| U1                 | DW_lzd           | rtl                |                |
| lt_x_1             | DW_cmp           | pparch (area,speed)                 |
| sub_x_4            | DW01_sub         | pparch (area,speed)                 |
| ashr_5             | DW_rightsh       | astr (area)        |                |
| ash_6              | DW_leftsh        | astr (area)        |                |
| ash_8              | DW_leftsh        | astr (area)        |                |
| add_x_12           | DW01_inc         | pparch (area,speed)                 |
| U1                 | DW_lzd           | rtl                |                |
| add_x_2            | DW01_inc         | apparch (area)     |                |
| lte_x_3            | DW_cmp           | apparch (area)     |                |
| gte_x_5            | DW_cmp           | apparch (area)     |                |
| gte_x_7            | DW_cmp           | apparch (area)     |                |
| add_x_12           | DW01_add         | apparch (area)     |                |
| mult_x_13          | DW_mult_uns      | pparch (area,speed)                 |
|                    |                  | mult_arch: and     |                |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_17            | DW_cmp           | apparch (area)     |                |
| lt_x_19            | DW_cmp           | apparch (area)     |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| U3                 | DW_lzd           | rtl                |                |
| U4                 | DW_lzd           | rtl                |                |
| sub_x_33           | DW01_sub         | apparch (area)     |                |
| add_x_34           | DW01_add         | apparch (area)     |                |
| eq_x_4             | DW_cmp           | apparch (area)     |                |
| sub_x_5            | DW01_sub         | pparch (area,speed)                 |
| eq_x_6             | DW_cmp           | apparch (area)     |                |
| ashr_13            | DW_rightsh       | astr (area)        |                |
| eq_x_17            | DW_cmp           | apparch (area)     |                |
| ash_19             | DW_leftsh        | astr (area)        |                |
| add_x_20           | DW01_add         | apparch (area)     |                |
| eq_x_21            | DW_cmp           | apparch (area)     |                |
| add_x_29           | DW01_inc         | apparch (area)     |                |
| eq_x_31            | DW_cmp           | apparch (area)     |                |
| UM1                | DW02_multp       | pparch (area,speed)                 |
|                    |                  | mult_arch: benc_radix4              |
| ULSD               | DW_lsd           | str                |                |
| eq_x_4             | DW_cmp           | apparch (area)     |                |
| sub_x_5            | DW01_sub         | pparch (area,speed)                 |
| eq_x_6             | DW_cmp           | apparch (area)     |                |
| ashr_13            | DW_rightsh       | astr (area)        |                |
| eq_x_17            | DW_cmp           | apparch (area)     |                |
| ash_19             | DW_leftsh        | astr (area)        |                |
| add_x_20           | DW01_add         | apparch (area)     |                |
| eq_x_21            | DW_cmp           | apparch (area)     |                |
| add_x_29           | DW01_inc         | apparch (area)     |                |
| eq_x_31            | DW_cmp           | apparch (area)     |                |
| UM1                | DW02_multp       | pparch (area,speed)                 |
|                    |                  | mult_arch: benc_radix4              |
| ULSD               | DW_lsd           | str                |                |
| eq_x_4             | DW_cmp           | apparch (area)     |                |
| sub_x_5            | DW01_sub         | pparch (area,speed)                 |
| eq_x_6             | DW_cmp           | apparch (area)     |                |
| ashr_13            | DW_rightsh       | astr (area)        |                |
| eq_x_17            | DW_cmp           | apparch (area)     |                |
| ash_19             | DW_leftsh        | astr (area)        |                |
| add_x_20           | DW01_add         | apparch (area)     |                |
| eq_x_21            | DW_cmp           | apparch (area)     |                |
| add_x_29           | DW01_inc         | apparch (area)     |                |
| eq_x_31            | DW_cmp           | apparch (area)     |                |
| UM1                | DW02_multp       | pparch (area,speed)                 |
|                    |                  | mult_arch: benc_radix4              |
| ULSD               | DW_lsd           | str                |                |
| U1                 | DW_lzod          | cla                |                |
| U1                 | DW_lzod          | cla                |                |
| U1                 | DW_lzod          | cla                |                |
| DP_OP_160J1_122_9276                  |                    |                |
|                    | DP_OP_160J1_122_9276 | str (area,speed)                |
| DP_OP_161J1_123_406                   |                    |                |
|                    | DP_OP_161J1_123_406 | str (area,speed)                 |
| DP_OP_108_153_7736 | DP_OP_108_153_7736 | str (area,speed) |                |
| DP_OP_109_154_8092 | DP_OP_109_154_8092 | str (area,speed) |                |
| DP_OP_108_157_7736 | DP_OP_108_157_7736 | str (area,speed) |                |
| DP_OP_109_158_8092 | DP_OP_109_158_8092 | str (area,speed) |                |
| DP_OP_108_161_7736 | DP_OP_108_161_7736 | str (area,speed) |                |
| DP_OP_109_162_8092 | DP_OP_109_162_8092 | str (area,speed) |                |
| DP_OP_65J3_195_7885                   |                    |                |
|                    | DP_OP_65J3_195_7885 | str (area,speed)                 |
| DP_OP_66J3_196_3163                   |                    |                |
|                    | DP_OP_66J3_196_3163 | str (area,speed)                 |
| DP_OP_67J3_197_9752                   |                    |                |
|                    | DP_OP_67J3_197_9752 | str (area,speed)                 |
| DP_OP_49J1_127_3163                   |                    |                |
|                    | DP_OP_49J1_127_3163 | str (area,speed)                 |
| DP_OP_50J1_128_9752                   |                    |                |
|                    | DP_OP_50J1_128_9752 | str (area)      |                |
| DP_OP_49J1_129_3163                   |                    |                |
|                    | DP_OP_49J1_129_3163 | str (area,speed)                 |
| DP_OP_50J1_130_9752                   |                    |                |
|                    | DP_OP_50J1_130_9752 | str (area)      |                |
| DP_OP_207J10_198_9016                 |                    |                |
|                    | DP_OP_207J10_198_9016 | str (area)    |                |
| DP_OP_208J10_199_5508                 |                    |                |
|                    | DP_OP_208J10_199_5508 | str (area,speed)               |
| DP_OP_209J10_200_153                  |                    |                |
|                    | DP_OP_209J10_200_153 | str (area,speed)                |
| DP_OP_210J10_201_6827                 |                    |                |
|                    | DP_OP_210J10_201_6827 | str (area)    |                |
| DP_OP_207J11_198_9016                 |                    |                |
|                    | DP_OP_207J11_198_9016 | str (area)    |                |
| DP_OP_208J11_199_5508                 |                    |                |
|                    | DP_OP_208J11_199_5508 | str (area,speed)               |
| DP_OP_209J11_200_153                  |                    |                |
|                    | DP_OP_209J11_200_153 | str (area,speed)                |
| DP_OP_210J11_201_6827                 |                    |                |
|                    | DP_OP_210J11_201_6827 | str (area)    |                |
| DP_OP_207J12_198_9016                 |                    |                |
|                    | DP_OP_207J12_198_9016 | str (area)    |                |
| DP_OP_208J12_199_5508                 |                    |                |
|                    | DP_OP_208J12_199_5508 | str (area,speed)               |
| DP_OP_209J12_200_153                  |                    |                |
|                    | DP_OP_209J12_200_153 | str (area,speed)                |
| DP_OP_210J12_201_6827                 |                    |                |
|                    | DP_OP_210J12_201_6827 | str (area)    |                |
===============================================================================

1
