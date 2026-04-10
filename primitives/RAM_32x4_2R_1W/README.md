# RAM_32x4_2R_1W

The `RAM_32x4_2R_1W` primitive implements a memory that is 4 bit wide and 32 words deep.
It has two read ports and one write port.

The write is synchronous and the reads can be configured as asynchronous or as asynchronous.
All synchronous read/writes can be on different clock domains.

![RAM_32x4_2R_1W](images/svg/RAM_32x4_2R_1W.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| A_CLK         | input     | 1     | The clock input for the A port. |
| A_ADDR        | input     | 5     | The address for the A port. |
| A_WEN         | input     | 1     | The write enable signal for the A port. |
| A_DIN         | input     | 4     | The write data for the A port. |
| B_CLK         | input     | 1     | The clock input for the B port. |
| B_ADDR        | input     | 5     | The address for the B port. |
| B_REN         | input     | 1     | The read enable signal for the B port. |
| B_DOUT        | output    | 4     | The read data for the B port. |
| C_CLK         | input     | 1     | The clock input for the B port. |
| C_ADDR        | input     | 5     | The address for the B port. |
| C_REN         | input     | 1     | The read enable signal for the B port. |
| C_DOUT        | output    | 4     | The read data for the B port. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| B_REG         | 1     | Register the B_OUT signal. |
| C_REG         | 1     | Register the C_OUT signal. |
