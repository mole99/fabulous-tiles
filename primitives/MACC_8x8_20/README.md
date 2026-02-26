# IOBUF

The IOBUF primitive is used to interface the fabric with external signals through the package pins.

![IOBUF](images/svg/IOBUF.svg){align=center}

## Signals

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| IN            | 1     | The input of the IOBUF primitive from the fabric (therefore the output the the PAD). |
| OUT           | 1     | The output of the IOBUF primitive to the fabric (therefore the input from the PAD). |
| EN            | 1     | The output enable for the output driver. |
| CLK           | 1     | The clock for the flip-flops. When none of the registers are enabled, it can be tied low. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| IN_REG        | 1     | Register the IN signal.  |
| OUT_REG       | 1     | Register the OUT signal. |
| EN_REG        | 1     | Register the EN signal.  |

Note that the registers are physically close to the input/output drivers and therefore allow for a low skew.
