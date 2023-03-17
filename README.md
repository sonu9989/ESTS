# STSE
Subsidence Trend and Seasonality Estimator (STSE) is an open-source integrated model that combines Geographically Weighted Regression (GWR) & Random Forest (RF) for estimating the trend and seasonality of subsidence by only using groundwater (hydraulic head) observations.

## 1. Seasonality and trend decomposition (STD) of subsidence and groundwater
**Decomposition.py**: - time series decomposition of hydraulic head (h) & deformation (s)

## 2. Modeling the non-trend dataset of subsidence (s<sub>non-trend</sub>) and groundwater (h<sub>non-trend</sub>)
**Non-trend Model.ipynb**: -  estimation of non-trend subsidence (s<sub>non-trend</sub>) using Random Forest (RF) 

## 3. Estimated subsidence change (&Delta;s) based on groundwater change (&Delta;h)
**main.m** estimation of subsidence change using GWR
