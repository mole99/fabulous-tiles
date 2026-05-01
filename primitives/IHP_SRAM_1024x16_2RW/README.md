# IHP_SRAM_1024x32

The `IHP_SRAM_1024x32` primitive provides an SRAM with 1024x32 bits of data and one synchronous read/write port.
It has a per-bit write mask (`BM`) which allows to only write individual bits or bytes of data.

When `WEN` and `REN` is active at the same time, the SRAM will return the current `DIN` at `DOUT`.

![IHP_SRAM_1024x32](images/svg/IHP_SRAM_1024x32.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| CLK         | input     | 1     | The clock input for the R/W port. |
| ADDR        | input     | 5     | The address for the R/W port. |
| DIN         | input     | 4     | The write data.            |
| BM          | input     | 4     | The per-bit write mask.    |
| WEN         | input     | 1     | The write enable signal.   |
| WEN         | input     | 1     | The memory enable signal.  |
| REN         | input     | 1     | The read enable signal.    |
| DOUT        | output    | 4     | The read data.             |

