# Primitives

These are the default primitives available in FABulous.

## IOBUF

The IOBUF primitive is used to interface the fabric with external signals through the package pins.

![IOBUF](images/svg/IOBUF.svg){align=center}

### Signals

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| IN            | 1     | The input of the IOBUF primitive from the fabric (therefore the output the the PAD). |
| OUT           | 1     | The output of the IOBUF primitive to the fabric (therefore the input from the PAD). |
| EN            | 1     | The output enable for the output driver. |
| CLK           | 1     | The clock for the flip-flops. When none of the registers are enabled, it can be tied low. |

### Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| IN_REG        | 1     | Register the IN signal.  |
| OUT_REG       | 1     | Register the OUT signal. |
| EN_REG        | 1     | Register the EN signal.  |

Note that the registers are physically close to the input/output drivers and therefore allow for a low skew.


<hr />

## LUT4_C_DFFESR

4-input look-up table with carry chain and D-FF with enable and set-reset input.

![LUT4_C_DFFESR](images/svg/LUT4_C_DFFESR.svg){align=center}

### Signals

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| I             | 4     | Input to LUT4_C_DFFESR.  |
| O             | 1     | Output of LUT4_C_DFFESR. |
| CI            | 1     | Carry-in of the carry-chain. |
| CO            | 1     | Carry-out of the carry-chain. |
| SR            | 1     | Set the D-FF to SR_VALUE (synchronous). |
| EN            | 1     | Enable the FF. |
| CLK           | 1     | Clock of the FF. |

### Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| INIT          | 16    | Init values for the look-up table. |
| USE_FF        | 1     | Output the signal of the D-FF, else output the combinatorial signal fo the LUT. |
| I0_MUX        | 1     | Mux for the carry-chain. |
| SR_VALUE      | 1     | Set-reset value.         |


<hr />

