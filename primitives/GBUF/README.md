# GBUF

The GBUF (global buffer) primitive is used to drive a global net, usually used for high-fanout and low-skew signals such as clock or reset.

![GBUF](images/svg/GBUF.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| IN            | input     |  1    | The input of the GBUF.   |
| OUT           | output    |  1    | The output of the GBUF, driving the global net. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| INVERT        | 1     | Invert the signal.       |
