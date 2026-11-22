# MUL_8x8

The MUL_8x8 primitive is used to perform multiply and accumulate operations.

![MUL_8x8](images/svg/MUL_8x8.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| CLK           | input     | 1     | The clock for all registers. |
| EN            | input     | 1     | Enable for all input and output registers. |
| A             | input     | 8     | Operand A (multiplication). |
| B             | input     | 8     | Operand B (multiplication). |
| Y             | output    | 16    | Result.                  |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| A_REG         | 1     | Register the A signal.   |
| B_REG         | 1     | Register the B signal.   |
| Y_REG         | 1     | Register the Y signal.   |
| CLK_INV       | 1     | Invert the clock.        |
