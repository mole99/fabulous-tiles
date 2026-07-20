# TT_PROJECT

The `TT_PROJECT` primitive implements an interface to a [Tiny Tapeout](https://tinytapeout.com/) project.

![TT_PROJECT](images/svg/TT_PROJECT.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| ENA           | input     | 1     | always 1 when the design is powered. |
| CLK           | input     | 1     | clock. |
| RST_N         | input     | 1     | reset_n - low to reset. |
| UI_IN         | input     | 16    | Dedicated inputs. |
| UO_OUT        | output    | 16    | Dedicated outputs. |
| UIO_IN        | input     | 16    | IOs: Input path. |
| UIO_OUT       | output    | 16    | IOs: Output path. |
| UIO_OE        | output    | 16    | IOs: Enable path (active high: 0=input, 1=output). |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| ENABLE_POWER  | 1     | Enable the power gate.   |
