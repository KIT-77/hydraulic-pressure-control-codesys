PROGRAM MAIN
VAR
    Scale1    : FB_PressureScale;
    Scale2    : FB_PressureScale;
    Scale3    : FB_PressureScale;
    Hydraulic : FB_HydraulicControl;

    (* Simulated ADC inputs — connect to real AI channels in production *)
    iADC1     : INT := 16000;
    iADC2     : INT := 18000;
    iADC3     : INT := 14000;
END_VAR

(* Scale 4-20mA sensor signals to bar *)
Scale1(iRawADC := iADC1, rMinBar := 0.0, rMaxBar := 250.0, rPressure => GVL.rPressure1);
Scale2(iRawADC := iADC2, rMinBar := 0.0, rMaxBar := 250.0, rPressure => GVL.rPressure2);
Scale3(iRawADC := iADC3, rMinBar := 0.0, rMaxBar := 250.0, rPressure => GVL.rPressure3);

(* Hydraulic control with PID and fault handling *)
Hydraulic(
    bRun       := GVL.bSystemRun,
    bEStop     := GVL.bEmergencyStop,
    rPressure1 := GVL.rPressure1,
    rPressure2 := GVL.rPressure2,
    rPressure3 := GVL.rPressure3,
    rSetpoint  := 120.0,
    rValveOut  => GVL.rValveOutput,
    bFault     => GVL.bFault,
    sFaultCode => GVL.sFaultCode
);