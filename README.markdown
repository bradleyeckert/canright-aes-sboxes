# David Canright's tiny AES S-boxes

David Canright's designs.

(Note that these are *former* record-holders for AES S-boxes; [Rene
Peralta's](http://cs-www.cs.yale.edu/homes/peralta/CircuitStuff/CMT.html) are smaller.)

Forked from [here](https://github.com/coruus/canright-aes-sboxes/tree/master)
with the addition of a testbench.
Since publishing Verilog without a testbench is a little naughty.

- `sboxalg.c` creates a "golden ROM" file usable in a Verilog testbench.
- `sboxmask_tb.v` sweeps through M and N looking for a mismatch.

Notes on synthesis: On an Efinix T20, the test module `Sbox_m` had a 67 MHz
estimated frequency. Maybe not so great for FPGAs.

