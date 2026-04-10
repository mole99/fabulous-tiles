# FABULOUS_LC

4-input look-up table with carry chain and D-FF with enable and set-reset input.

![FABULOUS_LC](images/svg/FABULOUS_LC.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| I             | input     | 4     | Input to FABULOUS_LC.  |
| O             | output    | 1     | Output of FABULOUS_LC. |
| Ci            | input     | 1     | Carry-in of the carry-chain. |
| Co            | output    | 1     | Carry-out of the carry-chain. |
| SR            | input     | 1     | Set the D-FF to SR_VALUE (synchronous). |
| EN            | input     | 1     | Enable the FF. |
| CLK           | input     | 1     | Clock of the FF. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| INIT          | 16    | Init values for the look-up table. |
| FF            | 1     | Output the signal of the D-FF, else output the combinatorial signal of the LUT. |
| I0_MUX        | 1     | Mux for the carry-chain. |
| SET_NORESET   | 1     | Set-reset value.         |
