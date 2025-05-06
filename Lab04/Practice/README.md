# 2-dim IEEE-754 Float Dot Product
* Given two 2-dim float vectors, output the dot product of them
* Used DesignWare
  * 1 DW_fp_add
  * 1 DW_fp_mult
* [Reference design](./01_RTL/VIP_reference.v) takes 6 cycles, while the [improved design](./01_RTL/VIP.v) only takes 2

## Method
* For each dimension, calculate the product b/w two vectors while reading inputs
* The area is reduced by 15.5% compared to the reference
