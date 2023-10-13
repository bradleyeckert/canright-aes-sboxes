# David Canright's tiny AES S-boxes

Forked from [here](https://github.com/coruus/canright-aes-sboxes/tree/master)
with the addition of a testbench.
Since publishing Verilog without a testbench is a little naughty.

- `sboxalg.c` makes a "golden ROM" file usable in a Verilog testbench.
- `sboxmask_tb.v` sweeps through M and N looking for a mismatch.

The `Sbox_m` module at the end of `sboxmaskcorr.verilog` has registered inputs
so quick and dirty synthesis produces an estimated clock frequency.

On an Efinix T20C4, the test module `Sbox_m` used 302 LEs at 73 MHz.
So, it's not very fast but it is small.
If you want fast in an FPGA, use BRAMs for S-boxes.
They can be initialized by a `bSbox` module. 
