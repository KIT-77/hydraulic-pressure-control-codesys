VAR_GLOBAL
    (* Pressure sensors — raw 4-20mA scaled to bar *)
    rPressure1      : REAL;   (* Inlet pressure *)
    rPressure2      : REAL;   (* Working pressure *)
    rPressure3      : REAL;   (* Return line pressure *)

    (* Proportional valve output 0.0-100.0% *)
    rValveOutput    : REAL;

    (* System state *)
    bSystemRun      : BOOL;
    bEmergencyStop  : BOOL;
    bFault          : BOOL;
    sFaultCode      : STRING;
END_VAR