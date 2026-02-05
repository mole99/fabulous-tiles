# IBUF

The IBUF primitive is used to interface the fabric with external signals through the package pins.

![IBUF](images/svg/IBUF.svg){align=center}

## Signals

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| OUT           | 1     | The output of the IOBUF primitive to the fabric (therefore the input from the PAD). |
| CLK           | 1     | The clock for the flip-flops. When none of the registers are enabled, it can be tied low. |

## Attributes

| Name          | Width | Description              |
|---------------|-------|--------------------------|
| OUT_REG       | 1     | Register the OUT signal. |

Note that the register is physically close to the input driver and therefore allows for a low skew.
