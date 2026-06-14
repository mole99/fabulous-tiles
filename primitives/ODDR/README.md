# ODDR

The ODDR primitive is used for transmitting double data rate (DDR) signals. 

![ODDR](images/svg/ODDR.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| CLK           | input     | 1     | The clock for the flip-flops. |
| D0            | input     | 1     | Data sampled on the rising edge. |
| D1            | input     | 1     | Data sampled on the falling edge. |
| EN            | input     | 1     | The enable for the flip-flops. |
| SR            | input     | 1     | The set-reset for the flip-flops (has priority over EN). |
| Q             | output    | 1     | The output of the ODDR primitive. Must be connected to an output driver. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| INIT_Q0       | 1     | Reset state for the Q0 flip-flop. |
| INIT_Q1       | 1     | Reset state for the Q1 flip-flop. |
