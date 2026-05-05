FUNCTION_BLOCK FB_PressureScale
VAR_INPUT
    iRawADC     : INT;      (* 0-32767 from AI module *)
    rMinBar     : REAL;     (* Engineering min, e.g. 0.0 *)
    rMaxBar     : REAL;     (* Engineering max, e.g. 250.0 *)
END_VAR
VAR_OUTPUT
    rPressure   : REAL;
    bWireBroken : BOOL;     (* TRUE if signal < 3.8 mA *)
END_VAR
VAR
    rScaled     : REAL;
END_VAR

(* 4mA = ~6554, 20mA = 32767 on 0-32767 range *)
IF iRawADC < 5900 THEN
    bWireBroken := TRUE;
    rPressure   := 0.0;
ELSE
    bWireBroken := FALSE;
    rScaled := (INT_TO_REAL(iRawADC) - 6554.0) / (32767.0 - 6554.0);
    rPressure := rMinBar + rScaled * (rMaxBar - rMinBar);
    rPressure := LIMIT(rMinBar, rPressure, rMaxBar);
END_IF