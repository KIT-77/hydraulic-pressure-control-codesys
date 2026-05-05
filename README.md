# Hydraulic Pressure Control — CODESYS 3.5

PLC control program for an industrial hydraulic system with three pressure sensors, a proportional valve, PID-based pressure regulation, and fault diagnostics.

## Overview

This project demonstrates a complete control solution typical of food and meat-processing machinery (fish-processing lines, separators, press systems). It was developed as a standalone demo based on real commissioning experience.

## System Description

| Component | Details |
|---|---|
| Pressure sensors | 3× 4–20 mA transmitters (0–250 bar) |
| Proportional valve | 0–100% analogue output |
| Control strategy | PID closed-loop on working pressure |
| Fault handling | Overpressure, wire-break, E-stop |

## Project Structure

```
src/
  GVL.st                  — Global variable list
  FB_PressureScale.st     — 4-20mA scaling with wire-break detection
  FB_HydraulicControl.st  — Main hydraulic control FB (PID + faults)
  MAIN.st                 — Main program (entry point)
```

## Tech Stack

- **Platform:** CODESYS 3.5
- **Language:** Structured Text (ST) — IEC 61131-3
- **PID:** CODESYS standard `FB_PID` library
- **Signal:** 4–20 mA scaled via 0–32767 ADC range

## How It Works

1. `FB_PressureScale` reads raw ADC values from each sensor, scales them to bar, and flags wire-break faults if the signal drops below 3.8 mA.
2. `FB_HydraulicControl` runs PID control on the working pressure (P2), driving the proportional valve output.
3. Overpressure on P2 or any sensor fault triggers an immediate valve close and sets a fault code.
4. `MAIN` wires sensors → control FB → global outputs each scan cycle.

## Author

**Nikita Poliakov** — Automation & Instrumentation Engineer  
2+ years delivering end-to-end control systems for food and meat-processing equipment.  
[LinkedIn](https://www.linkedin.com/in/nikita-poliakov-62a3003b9) | work.nikita@bk.ru