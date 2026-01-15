# Solar Analemma Simulation and Ground Projection

## Overview
This project simulates the apparent motion of the Sun over the course of a full year and reproduces the **solar analemma**. The model computes the Sun’s daily altitude and azimuth for a fixed geographic location and projects the resulting shadow path onto the ground at solar noon.
---

## Physical Model
The simulation applies standard solar geometry and time-correction models, including solar declination derived from Earth’s axial tilt, the Equation of Time to correct clock time to apparent solar time, and the solar hour angle relative to local solar noon. Solar altitude and azimuth are calculated using spherical trigonometry, and the Sun’s position is projected onto a horizontal ground plane.

---

## Inputs
- Geographic latitude and longitude of the observation site  
- Height of a vertical reference object used for shadow projection  
- Local clock time (set to solar noon)  
- Day of year (1–365)

These parameters may be adjusted to simulate different locations or geometries.

---

## Output
The model generates a two-dimensional ground projection of the solar analemma. The continuous curve represents the Sun’s apparent annual path, while markers indicate equinoxes and solstices. Axes are scaled equally to preserve geometric accuracy.
