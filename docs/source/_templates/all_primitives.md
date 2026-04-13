# Pseudo Primitives

These are the pseudo-primitives which get packed into actual primitives by nextpnr.
LUT[k]s and LUTFF are packed into FABULOUS_LC (support for separate FABULOUS_COMB and FABULOUS_FF is incomplete).

## LUT[k]

LUT implements a look-up table with k inputs.

k = 1 ... 6

## LUT4_HA

4-input look-up table with carry chain

## LUTFF_[N][E][S|R|SS|SR]

LUTFF implements a flip-flop with various options:

```text
N  ... clock inversion (NEG_CLK=1)
E  ... clock enable (EN input)
S  ... async set (SET_NORESET=1, ASYNC_SR=1)
R  ... async reset (SET_NORESET=0, ASYNC_SR=1)
SS ... sync set (SET_NORESET=1, ASYNC_SR=0)
SR ... sync reset (SET_NORESET=0, ASYNC_SR=0)
```

For each LUTFF, nextpnr will create a FABULOUS_FF with appropriate parameters.
In the packing step, nextpnr will combine the FABULOUS_LC without FFs with FABULOUS_FF. (packed-LUTFF mode)

Note, there is also an unfinished split-LUTFF mode where FABULOUS_COMB and FABULOUS_FF stay separate.
Please note that FABULOUS_LC does not currently support `NEG_CLK` and `ASYNC_SR`.

# Primitives

%for name, doc in primitives:

${doc}

<hr />

%endfor
