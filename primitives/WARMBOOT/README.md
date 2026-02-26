# WARMBOOT

The WARMBOOT primitive is used to perform a full fabric reconfiguration.

Its exact behavior is implementation dependent. The slot index is supplied to the SLOT input, a high level on the TRIGGER input starts the reconfiguration. One possible implementation would be to reconfigure the fabric using one of several bitstream slots of an external SPI flash.

![WARMBOOT](images/svg/WARMBOOT.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| SLOT          | input     | 4     | The bitstream slot       |
| TRIGGER       | input     | 1     | Active high trigger.     |
