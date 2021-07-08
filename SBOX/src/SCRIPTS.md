## Yosys Script

```
# read design 
read_verilog sbox.v

# elaborate design hierarchy
hierarchy -check -top sbox

# the high-level stuff
proc; opt; fsm; opt; memory; opt

# mapping to internal cell library
techmap; opt

write_blif sbox.blif
```


## ABC Script

```
# read the library of standard
# gates for the map command
read_library 2-gates.genlib

# read blif produced by yosys
read_blif sbox.blif

# transform to AIG
strash

# synthesis script
dch; map; mfs; balance
...
[20 iterations]
...
dch; map; mfs; balance

# write output
write_aiger sbox.aig
```


