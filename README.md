# ESTS
Estimator of Subsidence Trend and Seasonality (ESTS) is an open-source integrated model that combines Geographically Weighted Regression (GWR) & Random Forest (RF) for estimating the trend and seasonality of subsidence by only using groundwater (hydraulic head) observations.

## 1. Seasonality and trend decomposition (STD) of subsidence and groundwater
**Decomposition.py**: - Conducts Time series decomposition of original hydraulic head (h) & deformation (s) time series dataset.

## 2. Modeling the non-trend dataset of subsidence (s<sub>non-trend</sub>) and groundwater (h<sub>non-trend</sub>)
**Non-trend Model.ipynb**: -  Estimates the non-trend subsidence (s<sub>non-trend</sub>) through groundwater (h<sub>non-trend</sub>) using the Random Forest (RF) model.

## 3. Estimated subsidence change (&Delta;s) based on groundwater change (&Delta;h)
**main.m**: - Estimates subsidence change (&Delta;s) through hydraulic head change (&Delta;h) using GWR
