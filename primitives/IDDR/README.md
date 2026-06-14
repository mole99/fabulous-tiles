# IDDR

The IDDR primitive is used for receiving double data rate (DDR) signals. 

![IDDR](images/svg/IDDR.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| CLK           | input     | 1     | The clock for the flip-flops. |
| EN            | input     | 1     | The enable for the flip-flops. |
| SR            | input     | 1     | The set-reset for the flip-flops (has priority over EN). |
| D             | input     | 1     | The input of the IDDR primitive. Must be connected to an input driver. |
| Q0            | output    | 1     | Data sampled on the rising edge. |
| Q1            | output    | 1     | Data sampled on the falling edge. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| INIT_Q0       | 1     | Reset state for the Q0 flip-flop. |
| INIT_Q1       | 1     | Reset state for the Q1 flip-flop. |
