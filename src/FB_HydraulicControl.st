FUNCTION_BLOCK FB_HydraulicControl
VAR_INPUT
    bRun            : BOOL;
    bEStop          : BOOL;
    rPressure1      : REAL;
    rPressure2      : REAL;
    rPressure3      : REAL;
    rSetpoint       : REAL;         (* Target working pressure, bar *)
    rMaxPressure    : REAL := 200.0;
END_VAR
VAR_OUTPUT
    rValveOut       : REAL;         (* 0.0-100.0% *)
    bFault          : BOOL;
    sFaultCode      : STRING;
END_VAR
VAR
    PID             : FB_PID;
    bPIDEnable      : BOOL;
END_VAR

(* Emergency stop or active fault — close valve immediately *)
IF bEStop OR bFault THEN
    rValveOut  := 0.0;
    bPIDEnable := FALSE;
    RETURN;
END_IF

(* Overpressure protection *)
IF rPressure2 > rMaxPressure THEN
    bFault     := TRUE;
    sFaultCode := 'ERR_OVERPRESSURE_P2';
    rValveOut  := 0.0;
    RETURN;
END_IF

(* Wire break on any sensor *)
IF rPressure1 <= 0.0 OR rPressure2 <= 0.0 OR rPressure3 <= 0.0 THEN
    bFault     := TRUE;
    sFaultCode := 'ERR_SENSOR_FAULT';
    rValveOut  := 0.0;
    RETURN;
END_IF

(* Normal run — PID controls proportional valve *)
bPIDEnable := bRun;
PID(
    bEnable        := bPIDEnable,
    fSetpointValue := rSetpoint,
    fActualValue   := rPressure2,
    fManSyncValue  := 0.0,
    eMode          := ePID_Mode.Active,
    fOut           => rValveOut
);

rValveOut := LIMIT(0.0, rValveOut, 100.0);