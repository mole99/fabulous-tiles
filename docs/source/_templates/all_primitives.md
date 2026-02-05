# Primitives

These are the default primitives available in FABulous.

Note, there are pseudo-primitives which get packed into actual primitives by nextpnr.

LUTs and LUTFF are packed into FABULOUS_LC (or FABULOUS_COMB and FABULOUS_FF incomplete)

## LUT[k]

LUT implements a look-up table.

k = 1 ... 6

## LUT4_HA

LUT4 with carry chain


## LUTFF_[N][E][S|R|SS|SR]

LUTFF implements a flip-flop-

N ... clock inversion (`NEG_CLK`=1)
E ... clock enable (`EN` input)
S ... async set (`SET_NORESET`=1, `ASYNC_SR`=1)
R ... async reset (`SET_NORESET`=0, `ASYNC_SR`=1)
SS ... sync set (`SET_NORESET`=1, `ASYNC_SR`=0)
SR ... sync reset (`SET_NORESET`=0, `ASYNC_SR`=0)

nextpnr will create for each LUTFF a FABULOUS_FF with appropriate parameters.

In the packing step, nextpnr will combine the FABULOUS_LC without FFs with FABULOUS_FF. (packed-LUTFF mode)

Note, there is also an unfinished split-LUTFF mode where FABULOUS_COMB and FABULOUS_FF stay separate.

Please note that FABULOUS_LC does not currently support `NEG_CLK` and `ASYNC_SR`.


TODO FABULOUS_LC

with LUT4 and carry chain

%for name, doc in primitives:

${doc}

<hr />

%endfor
