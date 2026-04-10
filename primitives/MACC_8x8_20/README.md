# MACC_8x8_20

The MACC_8x8_20 primitive is used to perform multiply and accumulate operations.

![MACC_8x8_20](images/svg/MACC_8x8_20.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| CLK           | input     | 1     | The clock for all registers. |
| EN            | input     | 1     | Enable for all input registers and the accumulator register (ACC_RST has priority). |
| ACC_RST       | input     | 1     | Synchronous reset signal for the accumulator register. |
| ACC_CI        | input     | 1     | Carry in for the addtion. |
| ACC_CO        | input     | 1     | Carry out of the addtion. |
| A             | input     | 8     | Operand A (multiplication). |
| B             | input     | 8     | Operand B (multiplication). |
| C             | input     | 20    | Operand C (addition).    |
| Q             | output    | 20    | Result.                  |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| A_REG         | 1     | Register the A signal.   |
| B_REG         | 1     | Register the B signal.   |
| C_REG         | 1     | Register the C signal.   |
| SIGN_EXT      | 1     | Sign-extend the product. |
| ACC_SEL       | 1     | Accumulator select multiplexer. |
| ACC_OUT       | 1     | Accumulator output multiplexer. |
| CLK_INV       | 1     | Invert the clock.        |
