# SYS_RESET

The SYS_RESET primitive can be used as an active high reset signal.

Its exact behavior is implementation dependent. It should be used to supply a system reset to the fabric and is normally active during a complete fabric reconfiguration.

![SYS_RESET](images/svg/SYS_RESET.svg){align=center}

## Signals

| Name          | Direction | Width | Description              |
|---------------|-----------|-------|--------------------------|
| RESET         | output    | 1     | The reset signal.        |


