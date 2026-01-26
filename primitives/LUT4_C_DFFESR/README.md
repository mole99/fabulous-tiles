# LUT4_C_DFFESR

4-input look-up table with carry chain and D-FF with enable and set-reset input.

![LUT4_C_DFFESR](images/svg/LUT4_C_DFFESR.svg){align=center}

## Signals

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| I             | 4     | Input to LUT4_C_DFFESR.  |
| O             | 1     | Output of LUT4_C_DFFESR. |
| CI            | 1     | Carry-in of the carry-chain. |
| CO            | 1     | Carry-out of the carry-chain. |
| SR            | 1     | Set the D-FF to SR_VALUE (synchronous). |
| EN            | 1     | Enable the FF. |
| CLK           | 1     | Clock of the FF. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| INIT          | 16    | Init values for the look-up table. |
| USE_FF        | 1     | Output the signal of the D-FF, else output the combinatorial signal fo the LUT. |
| I0_MUX        | 1     | Mux for the carry-chain. |
| SR_VALUE      | 1     | Set-reset value.         |
