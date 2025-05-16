 
****************************************
Report : resources
Design : NN
Version: S-2021.06-SP2
Date   : Fri May 16 22:27:40 2025
****************************************


Resource Report for this hierarchy in file ./../01_RTL/NN.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_2        | DW01_inc       | width=7    | add_198 (NN.v:198)         |
| add_x_5        | DW01_inc       | width=5    | add_210 (NN.v:210)         |
| add_x_32       | DW01_inc       | width=2    | add_308 (NN.v:308)         |
| add_x_105      | DW01_inc       | width=3    | add_646 (NN.v:646)         |
| MAC1           | DW_fp_mac      | sig_width=23 | MAC1 (NN.v:128)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MAC2           | DW_fp_mac      | sig_width=23 | MAC2 (NN.v:129)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MAC3           | DW_fp_mac      | sig_width=23 | MAC3 (NN.v:130)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL1           | DW_fp_mult     | sig_width=23 | MUL1 (NN.v:131)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL2           | DW_fp_mult     | sig_width=23 | MUL2 (NN.v:132)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL3           | DW_fp_mult     | sig_width=23 | MUL3 (NN.v:133)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| MUL4           | DW_fp_mult     | sig_width=23 | MUL4 (NN.v:134)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUB1           | DW_fp_sub      | sig_width=23 | SUB1 (NN.v:135)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUB2           | DW_fp_sub      | sig_width=23 | SUB2 (NN.v:136)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUB3           | DW_fp_sub      | sig_width=23 | SUB3 (NN.v:137)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| SUM1           | DW_fp_sum3     | sig_width=23 | SUM1 (NN.v:138)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
|                |                | arch_type=0 |                           |
| CMP1           | DW_fp_cmp      | sig_width=23 | CMP1 (NN.v:141)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| CMP2           | DW_fp_cmp      | sig_width=23 | CMP2 (NN.v:142)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| CMP3           | DW_fp_cmp      | sig_width=23 | CMP3 (NN.v:143)          |
|                |                | exp_width=8 |                           |
|                |                | ieee_compliance=0 |                     |
| DP_OP_27_166_7074               |            |                            |
|                | DP_OP_27_166_7074 |         |                            |
| DP_OP_28_167_7074               |            |                            |
|                | DP_OP_28_167_7074 |         |                            |
| DP_OP_27_162_5633               |            |                            |
|                | DP_OP_27_162_5633 |         |                            |
| DP_OP_28_163_5633               |            |                            |
|                | DP_OP_28_163_5633 |         |                            |
| DP_OP_27_164_1564               |            |                            |
|                | DP_OP_27_164_1564 |         |                            |
| DP_OP_28_165_1564               |            |                            |
|                | DP_OP_28_165_1564 |         |                            |
=============================================================================

Datapath Report for DP_OP_27_166_7074
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_27_166_7074    | add_443                                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 53    |                                          |
| I2    | PI   | Unsigned | 53    |                                          |
| O1    | PO   | Unsigned | 54    | I1 + I2                                  |
==============================================================================

Datapath Report for DP_OP_28_167_7074
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_28_167_7074    | sub_443                                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 53    |                                          |
| I2    | PI   | Unsigned | 53    |                                          |
| O1    | PO   | Signed   | 54    | I1 - I2                                  |
==============================================================================

Datapath Report for DP_OP_27_162_5633
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_27_162_5633    | add_443                                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 53    |                                          |
| I2    | PI   | Unsigned | 53    |                                          |
| O1    | PO   | Unsigned | 54    | I1 + I2                                  |
==============================================================================

Datapath Report for DP_OP_28_163_5633
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_28_163_5633    | sub_443                                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 53    |                                          |
| I2    | PI   | Unsigned | 53    |                                          |
| O1    | PO   | Signed   | 54    | I1 - I2                                  |
==============================================================================

Datapath Report for DP_OP_27_164_1564
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_27_164_1564    | add_443                                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 53    |                                          |
| I2    | PI   | Unsigned | 53    |                                          |
| O1    | PO   | Unsigned | 54    | I1 + I2                                  |
==============================================================================

Datapath Report for DP_OP_28_165_1564
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_28_165_1564    | sub_443                                             |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 53    |                                          |
| I2    | PI   | Unsigned | 53    |                                          |
| O1    | PO   | Signed   | 54    | I1 - I2                                  |
==============================================================================


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


Resource Report for Ungrouped Hierarchy MUL3 in file ./DW_fp_mult__rtl.v.e
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


Resource Report for Ungrouped Hierarchy MUL2 in file ./DW_fp_mult__rtl.v.e
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


Resource Report for Ungrouped Hierarchy MUL1 in file ./DW_fp_mult__rtl.v.e
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


Resource Report for Ungrouped Hierarchy MAC3 in file ./DW_fp_mac__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| mult_x_9       | DW_mult_uns    | a_width=24 | mult_402                   |
|                |                | b_width=24 |                            |
| ashr_14        | DW_rightsh     | A_width=52 | srl_432                    |
|                |                | SH_width=9 |                            |
| ash_15         | DW_leftsh      | A_width=52 | sll_434                    |
|                |                | SH_width=9 |                            |
| add_x_20       | DW01_add       | width=55   | add_497                    |
| add_x_23       | DW01_add       | width=8    | add_502                    |
| gte_x_24       | DW_cmp         | width=10   | gte_522                    |
| U1             | DW_fp_ifp_conv | sig_widthi=23 | U1                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
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
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U5             | DW_ifp_mult    | sig_widthi=25 | U5                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=31 |                         |
|                |                | exp_widtho=9 |                          |
| U6             | DW_ifp_mult    | sig_widthi=25 | U6                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=31 |                         |
|                |                | exp_widtho=9 |                          |
| U7             | DW_ifp_addsub  | sig_widthi=31 | U7                      |
|                |                | exp_widthi=9 |                          |
|                |                | sig_widtho=32 |                         |
|                |                | exp_widtho=10 |                         |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U8             | DW_ifp_fp_conv | sig_widthi=32 | U8                      |
|                |                | exp_widthi=10 |                         |
|                |                | sig_width=23 |                          |
|                |                | exp_width=8 |                           |
|                |                | use_denormal=0 |                        |
| U9             | DW_lzd         | a_width=52 | U9                         |
| U10            | DW01_ash       | A_width=54 | U10                        |
|                |                | SH_width=10 |                           |
| DP_OP_103J1_133_4033            |            |                            |
|                | DP_OP_103J1_133_4033 |      |                            |
| DP_OP_104J1_134_9309            |            |                            |
|                | DP_OP_104J1_134_9309 |      |                            |
| sub_x_29       | DW01_sub       | width=54   | add_449_ni sub_add_449     |
=============================================================================

Datapath Report for DP_OP_103J1_133_4033
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_103J1_133_4033 | add_405 lt_423 add_407 sub_431 add_453              |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 8     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| I6    | PI   | Unsigned | 1     |                                          |
| I7    | PI   | Unsigned | 8     |                                          |
| I8    | PI   | Unsigned | 1     |                                          |
| I9    | PI   | Unsigned | 1     |                                          |
| T10   | IFO  | Unsigned | 9     | I1 + I2                                  |
| T11   | IFO  | Unsigned | 9     | { I3, I4 } ? $unsigned(1'b0) : T10       |
| T12   | IFO  | Unsigned | 9     | I7 + $unsigned(7'b1111111)               |
| T13   | IFO  | Unsigned | 9     | { I5, I6 } ? $unsigned(1'b0) : T12       |
| T15   | IFO  | Signed   | 9     | { I8, I9 } ? T13 : T11                   |
| T18   | IFO  | Signed   | 9     | { I8, I9 } ? T11 : T13                   |
| O1    | PO   | Unsigned | 1     | T11 < T13                                |
| O2    | PO   | Signed   | 9     | T15 - T18                                |
| O3    | PO   | Unsigned | 9     | T15 + $unsigned(2'b10)                   |
==============================================================================

Datapath Report for DP_OP_104J1_134_9309
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_104J1_134_9309 | sub_453 gt_458 lt_458 sub_458 gte_472 sub_472       |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 9     |                                          |
| I2    | PI   | Signed   | 7     |                                          |
| I3    | PI   | Signed   | 10    |                                          |
| T30   | IFO  | Signed   | 10    | I1 - $unsigned(7'b1111111)               |
| O1    | PO   | Signed   | 1     | T30 > I2                                 |
| O2    | PO   | Signed   | 1     | T30 < $signed(2'b01)                     |
| O3    | PO   | Signed   | 10    | T30 - $unsigned(1'b1)                    |
| O4    | PO   | Signed   | 1     | T30 >= $signed(1'b0)                     |
| O5    | PO   | Signed   | 10    | T30 - I3                                 |
==============================================================================


Resource Report for Ungrouped Hierarchy MAC2 in file ./DW_fp_mac__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| mult_x_9       | DW_mult_uns    | a_width=24 | mult_402                   |
|                |                | b_width=24 |                            |
| ashr_14        | DW_rightsh     | A_width=52 | srl_432                    |
|                |                | SH_width=9 |                            |
| ash_15         | DW_leftsh      | A_width=52 | sll_434                    |
|                |                | SH_width=9 |                            |
| add_x_20       | DW01_add       | width=55   | add_497                    |
| add_x_23       | DW01_add       | width=8    | add_502                    |
| gte_x_24       | DW_cmp         | width=10   | gte_522                    |
| U1             | DW_fp_ifp_conv | sig_widthi=23 | U1                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
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
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U5             | DW_ifp_mult    | sig_widthi=25 | U5                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=31 |                         |
|                |                | exp_widtho=9 |                          |
| U6             | DW_ifp_mult    | sig_widthi=25 | U6                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=31 |                         |
|                |                | exp_widtho=9 |                          |
| U7             | DW_ifp_addsub  | sig_widthi=31 | U7                      |
|                |                | exp_widthi=9 |                          |
|                |                | sig_widtho=32 |                         |
|                |                | exp_widtho=10 |                         |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U8             | DW_ifp_fp_conv | sig_widthi=32 | U8                      |
|                |                | exp_widthi=10 |                         |
|                |                | sig_width=23 |                          |
|                |                | exp_width=8 |                           |
|                |                | use_denormal=0 |                        |
| U9             | DW_lzd         | a_width=52 | U9                         |
| U10            | DW01_ash       | A_width=54 | U10                        |
|                |                | SH_width=10 |                           |
| DP_OP_103J1_136_4033            |            |                            |
|                | DP_OP_103J1_136_4033 |      |                            |
| DP_OP_104J1_137_9309            |            |                            |
|                | DP_OP_104J1_137_9309 |      |                            |
| sub_x_29       | DW01_sub       | width=54   | add_449_ni sub_add_449     |
=============================================================================

Datapath Report for DP_OP_103J1_136_4033
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_103J1_136_4033 | add_405 lt_423 add_407 sub_431 add_453              |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 8     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| I6    | PI   | Unsigned | 1     |                                          |
| I7    | PI   | Unsigned | 8     |                                          |
| I8    | PI   | Unsigned | 1     |                                          |
| I9    | PI   | Unsigned | 1     |                                          |
| T10   | IFO  | Unsigned | 9     | I1 + I2                                  |
| T11   | IFO  | Unsigned | 9     | { I3, I4 } ? $unsigned(1'b0) : T10       |
| T12   | IFO  | Unsigned | 9     | I7 + $unsigned(7'b1111111)               |
| T13   | IFO  | Unsigned | 9     | { I5, I6 } ? $unsigned(1'b0) : T12       |
| T15   | IFO  | Signed   | 9     | { I8, I9 } ? T13 : T11                   |
| T18   | IFO  | Signed   | 9     | { I8, I9 } ? T11 : T13                   |
| O1    | PO   | Unsigned | 1     | T11 < T13                                |
| O2    | PO   | Signed   | 9     | T15 - T18                                |
| O3    | PO   | Unsigned | 9     | T15 + $unsigned(2'b10)                   |
==============================================================================

Datapath Report for DP_OP_104J1_137_9309
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_104J1_137_9309 | sub_453 gt_458 lt_458 sub_458 gte_472 sub_472       |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 9     |                                          |
| I2    | PI   | Signed   | 7     |                                          |
| I3    | PI   | Signed   | 10    |                                          |
| T30   | IFO  | Signed   | 10    | I1 - $unsigned(7'b1111111)               |
| O1    | PO   | Signed   | 1     | T30 > I2                                 |
| O2    | PO   | Signed   | 1     | T30 < $signed(2'b01)                     |
| O3    | PO   | Signed   | 10    | T30 - $unsigned(1'b1)                    |
| O4    | PO   | Signed   | 1     | T30 >= $signed(1'b0)                     |
| O5    | PO   | Signed   | 10    | T30 - I3                                 |
==============================================================================


Resource Report for Ungrouped Hierarchy MAC1 in file ./DW_fp_mac__rtl.v.e
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| mult_x_9       | DW_mult_uns    | a_width=24 | mult_402                   |
|                |                | b_width=24 |                            |
| ashr_14        | DW_rightsh     | A_width=52 | srl_432                    |
|                |                | SH_width=9 |                            |
| ash_15         | DW_leftsh      | A_width=52 | sll_434                    |
|                |                | SH_width=9 |                            |
| add_x_20       | DW01_add       | width=55   | add_497                    |
| add_x_23       | DW01_add       | width=8    | add_502                    |
| gte_x_24       | DW_cmp         | width=10   | gte_522                    |
| U1             | DW_fp_ifp_conv | sig_widthi=23 | U1                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
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
|                |                | sig_widtho=25 |                         |
|                |                | exp_widtho=8 |                          |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U5             | DW_ifp_mult    | sig_widthi=25 | U5                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=31 |                         |
|                |                | exp_widtho=9 |                          |
| U6             | DW_ifp_mult    | sig_widthi=25 | U6                      |
|                |                | exp_widthi=8 |                          |
|                |                | sig_widtho=31 |                         |
|                |                | exp_widtho=9 |                          |
| U7             | DW_ifp_addsub  | sig_widthi=31 | U7                      |
|                |                | exp_widthi=9 |                          |
|                |                | sig_widtho=32 |                         |
|                |                | exp_widtho=10 |                         |
|                |                | use_denormal=0 |                        |
|                |                | use_1scmpl=0 |                          |
| U8             | DW_ifp_fp_conv | sig_widthi=32 | U8                      |
|                |                | exp_widthi=10 |                         |
|                |                | sig_width=23 |                          |
|                |                | exp_width=8 |                           |
|                |                | use_denormal=0 |                        |
| U9             | DW_lzd         | a_width=52 | U9                         |
| U10            | DW01_ash       | A_width=54 | U10                        |
|                |                | SH_width=10 |                           |
| DP_OP_103J1_139_4033            |            |                            |
|                | DP_OP_103J1_139_4033 |      |                            |
| DP_OP_104J1_140_9309            |            |                            |
|                | DP_OP_104J1_140_9309 |      |                            |
| sub_x_29       | DW01_sub       | width=54   | add_449_ni sub_add_449     |
=============================================================================

Datapath Report for DP_OP_103J1_139_4033
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_103J1_139_4033 | add_405 lt_423 add_407 sub_431 add_453              |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 8     |                                          |
| I2    | PI   | Unsigned | 8     |                                          |
| I3    | PI   | Unsigned | 1     |                                          |
| I4    | PI   | Unsigned | 1     |                                          |
| I5    | PI   | Unsigned | 1     |                                          |
| I6    | PI   | Unsigned | 1     |                                          |
| I7    | PI   | Unsigned | 8     |                                          |
| I8    | PI   | Unsigned | 1     |                                          |
| I9    | PI   | Unsigned | 1     |                                          |
| T10   | IFO  | Unsigned | 9     | I1 + I2                                  |
| T11   | IFO  | Unsigned | 9     | { I3, I4 } ? $unsigned(1'b0) : T10       |
| T12   | IFO  | Unsigned | 9     | I7 + $unsigned(7'b1111111)               |
| T13   | IFO  | Unsigned | 9     | { I5, I6 } ? $unsigned(1'b0) : T12       |
| T15   | IFO  | Signed   | 9     | { I8, I9 } ? T13 : T11                   |
| T18   | IFO  | Signed   | 9     | { I8, I9 } ? T11 : T13                   |
| O1    | PO   | Unsigned | 1     | T11 < T13                                |
| O2    | PO   | Signed   | 9     | T15 - T18                                |
| O3    | PO   | Unsigned | 9     | T15 + $unsigned(2'b10)                   |
==============================================================================

Datapath Report for DP_OP_104J1_140_9309
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_104J1_140_9309 | sub_453 gt_458 lt_458 sub_458 gte_472 sub_472       |
==============================================================================

==============================================================================
|       |      | Data     |       |                                          |
| Var   | Type | Class    | Width | Expression                               |
==============================================================================
| I1    | PI   | Unsigned | 9     |                                          |
| I2    | PI   | Signed   | 7     |                                          |
| I3    | PI   | Signed   | 10    |                                          |
| T30   | IFO  | Signed   | 10    | I1 - $unsigned(7'b1111111)               |
| O1    | PO   | Signed   | 1     | T30 > I2                                 |
| O2    | PO   | Signed   | 1     | T30 < $signed(2'b01)                     |
| O3    | PO   | Signed   | 10    | T30 - $unsigned(1'b1)                    |
| O4    | PO   | Signed   | 1     | T30 >= $signed(1'b0)                     |
| O5    | PO   | Signed   | 10    | T30 - I3                                 |
==============================================================================


Resource Report for Ungrouped Hierarchy *cell*J2*44190/U1 in file
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
| DP_OP_65J2_156_7885             |            |                            |
|                | DP_OP_65J2_156_7885 |       |                            |
| DP_OP_66J2_157_3163             |            |                            |
|                | DP_OP_66J2_157_3163 |       |                            |
| DP_OP_67J2_158_9752             |            |                            |
|                | DP_OP_67J2_158_9752 |       |                            |
=============================================================================

Datapath Report for DP_OP_65J2_156_7885
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_65J2_156_7885  | sub_277 sub_add_279 add_279_ni                      |
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

Datapath Report for DP_OP_66J2_157_3163
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_66J2_157_3163  | add_294 add_294_2                                   |
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

Datapath Report for DP_OP_67J2_158_9752
==============================================================================
| Cell                 | Contained Operations                                |
==============================================================================
| DP_OP_67J2_158_9752  | add_402 sub_403                                     |
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


Resource Report for Ungrouped Hierarchy MAC3/U9
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MAC1/U9
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MAC2/U9
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL3/U4
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL3/U3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL1/U4
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL2/U4
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL1/U3
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
=============================================================================


Resource Report for Ungrouped Hierarchy MUL2/U3
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
| add_x_32           | DW01_inc         | apparch (area)     |                |
| add_x_105          | DW01_inc         | apparch (area)     |                |
| MAC1               | DW_fp_mac        | rtl                |                |
| MAC2               | DW_fp_mac        | rtl                |                |
| MAC3               | DW_fp_mac        | rtl                |                |
| MUL1               | DW_fp_mult       | rtl                |                |
| MUL2               | DW_fp_mult       | rtl                |                |
| MUL3               | DW_fp_mult       | rtl                |                |
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
| lte_x_3            | DW_cmp           | apparch (area)     |                |
| gte_x_5            | DW_cmp           | apparch (area)     |                |
| gte_x_7            | DW_cmp           | apparch (area)     |                |
| add_x_12           | DW01_add         | apparch (area)     |                |
| mult_x_13          | DW_mult_uns      | pparch (area,speed)                 |
|                    |                  | mult_arch: benc_radix4              |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_17            | DW_cmp           | apparch (area)     |                |
| lt_x_19            | DW_cmp           | apparch (area)     |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| U3                 | DW_lzd           | rtl                |                |
| U4                 | DW_lzd           | rtl                |                |
| sub_x_33           | DW01_sub         | apparch (area)     |                |
| add_x_34           | DW01_add         | apparch (area)     |                |
| lte_x_3            | DW_cmp           | apparch (area)     |                |
| gte_x_5            | DW_cmp           | apparch (area)     |                |
| gte_x_7            | DW_cmp           | apparch (area)     |                |
| add_x_12           | DW01_add         | apparch (area)     |                |
| mult_x_13          | DW_mult_uns      | pparch (speed)     |                |
|                    |                  | mult_arch: benc_radix4              |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_17            | DW_cmp           | apparch (area)     |                |
| lt_x_19            | DW_cmp           | apparch (area)     |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| U3                 | DW_lzd           | cla                |                |
| U4                 | DW_lzd           | cla                |                |
| sub_x_33           | DW01_sub         | apparch (area)     |                |
| add_x_34           | DW01_add         | pparch (area,speed)                 |
| lte_x_3            | DW_cmp           | apparch (area)     |                |
| gte_x_5            | DW_cmp           | apparch (area)     |                |
| gte_x_7            | DW_cmp           | apparch (area)     |                |
| add_x_12           | DW01_add         | apparch (area)     |                |
| mult_x_13          | DW_mult_uns      | pparch (speed)     |                |
|                    |                  | mult_arch: benc_radix4              |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_17            | DW_cmp           | apparch (area)     |                |
| lt_x_19            | DW_cmp           | apparch (area)     |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| U3                 | DW_lzd           | cla                |                |
| U4                 | DW_lzd           | cla                |                |
| sub_x_33           | DW01_sub         | apparch (area)     |                |
| add_x_34           | DW01_add         | pparch (area,speed)                 |
| lte_x_3            | DW_cmp           | apparch (area)     |                |
| gte_x_5            | DW_cmp           | apparch (area)     |                |
| gte_x_7            | DW_cmp           | apparch (area)     |                |
| add_x_12           | DW01_add         | apparch (area)     |                |
| mult_x_13          | DW_mult_uns      | pparch (speed)     |                |
|                    |                  | mult_arch: benc_radix4              |
| eq_x_14            | DW_cmp           | apparch (area)     |                |
| lt_x_17            | DW_cmp           | apparch (area)     |                |
| lt_x_19            | DW_cmp           | apparch (area)     |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| U3                 | DW_lzd           | cla                |                |
| U4                 | DW_lzd           | cla                |                |
| sub_x_33           | DW01_sub         | apparch (area)     |                |
| add_x_34           | DW01_add         | pparch (area,speed)                 |
| mult_x_9           | DW_mult_uns      | pparch (area,speed)                 |
|                    |                  | mult_arch: benc_radix4              |
| ashr_14            | DW_rightsh       | astr (area)        |                |
| ash_15             | DW_leftsh        | astr (area)        |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| add_x_23           | DW01_add         | apparch (area)     |                |
| gte_x_24           | DW_cmp           | apparch (area)     |                |
| U9                 | DW_lzd           | cla                |                |
| U10                | DW01_ash         | astr (area)        |                |
| sub_x_29           | DW01_sub         | pparch (area,speed)                 |
| mult_x_9           | DW_mult_uns      | pparch (area,speed)                 |
|                    |                  | mult_arch: benc_radix4              |
| ashr_14            | DW_rightsh       | astr (area)        |                |
| ash_15             | DW_leftsh        | astr (area)        |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| add_x_23           | DW01_add         | apparch (area)     |                |
| gte_x_24           | DW_cmp           | apparch (area)     |                |
| U9                 | DW_lzd           | cla                |                |
| U10                | DW01_ash         | astr (area)        |                |
| sub_x_29           | DW01_sub         | pparch (area,speed)                 |
| mult_x_9           | DW_mult_uns      | pparch (area,speed)                 |
|                    |                  | mult_arch: benc_radix4              |
| ashr_14            | DW_rightsh       | astr (area)        |                |
| ash_15             | DW_leftsh        | astr (area)        |                |
| add_x_20           | DW01_add         | pparch (area,speed)                 |
| add_x_23           | DW01_add         | apparch (area)     |                |
| gte_x_24           | DW_cmp           | apparch (area)     |                |
| U9                 | DW_lzd           | cla                |                |
| U10                | DW01_ash         | astr (area)        |                |
| sub_x_29           | DW01_sub         | pparch (area,speed)                 |
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
| DP_OP_27_166_7074  | DP_OP_27_166_7074 | str (area,speed)  |                |
| DP_OP_28_167_7074  | DP_OP_28_167_7074 | str (area,speed)  |                |
| DP_OP_27_162_5633  | DP_OP_27_162_5633 | str (area,speed)  |                |
| DP_OP_28_163_5633  | DP_OP_28_163_5633 | str (area,speed)  |                |
| DP_OP_27_164_1564  | DP_OP_27_164_1564 | str (area,speed)  |                |
| DP_OP_28_165_1564  | DP_OP_28_165_1564 | str (area,speed)  |                |
| DP_OP_160J1_122_9276                  |                    |                |
|                    | DP_OP_160J1_122_9276 | str (area,speed)                |
| DP_OP_161J1_123_406                   |                    |                |
|                    | DP_OP_161J1_123_406 | str (area,speed)                 |
| DP_OP_103J1_133_4033                  |                    |                |
|                    | DP_OP_103J1_133_4033 | str (area)     |                |
| DP_OP_104J1_134_9309                  |                    |                |
|                    | DP_OP_104J1_134_9309 | str (area,speed)                |
| DP_OP_103J1_136_4033                  |                    |                |
|                    | DP_OP_103J1_136_4033 | str (area)     |                |
| DP_OP_104J1_137_9309                  |                    |                |
|                    | DP_OP_104J1_137_9309 | str (area,speed)                |
| DP_OP_103J1_139_4033                  |                    |                |
|                    | DP_OP_103J1_139_4033 | str (area)     |                |
| DP_OP_104J1_140_9309                  |                    |                |
|                    | DP_OP_104J1_140_9309 | str (area,speed)                |
| DP_OP_65J2_156_7885                   |                    |                |
|                    | DP_OP_65J2_156_7885 | str (area,speed)                 |
| DP_OP_66J2_157_3163                   |                    |                |
|                    | DP_OP_66J2_157_3163 | str (area,speed)                 |
| DP_OP_67J2_158_9752                   |                    |                |
|                    | DP_OP_67J2_158_9752 | str (area,speed)                 |
| DP_OP_49J1_129_3163                   |                    |                |
|                    | DP_OP_49J1_129_3163 | str (area,speed)                 |
| DP_OP_50J1_130_9752                   |                    |                |
|                    | DP_OP_50J1_130_9752 | str (area)      |                |
| DP_OP_49J1_127_3163                   |                    |                |
|                    | DP_OP_49J1_127_3163 | str (area,speed)                 |
| DP_OP_50J1_128_9752                   |                    |                |
|                    | DP_OP_50J1_128_9752 | str (area)      |                |
===============================================================================

1
