# OBUF

The OBUF primitive is used to interface the fabric with external signals through the package pins.

![OBUF](images/svg/OBUF.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| IN            | input     | 1     | The input of the IOBUF primitive from the fabric (therefore the output the the PAD). |
| EN            | input     | 1     | The output enable for the output driver. |
| CLK           | input     | 1     | The clock for the flip-flops. When none of the registers are enabled, it can be tied low. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| IN_REG        | 1     | Register the IN signal.  |
| EN_REG        | 1     | Register the EN signal.  |

Note that the registers are physically close to the output driver and therefore allow for a low skew.
