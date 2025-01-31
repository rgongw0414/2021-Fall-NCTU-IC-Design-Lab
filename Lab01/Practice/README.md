## What I learned: 
* Note: The input is 3-bit unsigned number, and the output is 4-bit signed number. 
* If the input in signed, then we cannot use this solution, because the last output bit will be wrong.
* Since the output is 4-bit, we need to use 4-bit adder, however, the input is 3-bit, so we need to convert it to 4-bit.
* Also, to minimize the resulting area, the last bit of in_n0 is 0 (it is unsigned, hence does not contribute to out_n[3] in HA), so we can use a HA instead of a FA in the last stage.