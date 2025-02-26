# Static Timing Analysis (STA)

## Terminologies

* $T_{cd}$ (Contamination delay)

  * Def: The time it takes for a signal to travel from the input to the output of a combinational logic gate, **under best-case conditions**.
  * Instead of an absolute value, it is obtained by analysis or simulations (using tools like SPICE)

* $T_{pd}$ (Propagation delay)

  * Def: The time it takes for a signal to travel from the input to the output of a combinational logic gate, **under worst-case conditions**.
  * Instead of an absolute value, it is obtained bt analysis or simulations (using tools like SPICE)

* **Hence, whether it takes $T_{pd}$ or $T_{cd}$ to the output of the comb logic or not, does not neccessarily violate the setup-/hold-time violations**