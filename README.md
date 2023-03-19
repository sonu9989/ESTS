# ESTS
Estimator of Subsidence Trend and Seasonality (ESTS) is an open-source integrated framework and model that combines Seasonality and trend decomposition (STD),  Geographically Weighted Regression (GWR) & Random Forest (RF) models for identifying and estimating the trend and seasonality in subsidence by only using groundwater (hydraulic head) observations as input variable.

## 1. Seasonality and Trend Decomposition (STD) of Subsidence (s) and Groundwater (h)
**Decomposition_main.py**: - Conducts Time series decomposition of original hydraulic head (h) & deformation (s) time series dataset using the Seasonal-Trend Decomposition Procedure Based on Loess (STL) approach. Furthermore, this code also computes the Relative Importance (RI) of each decomposed components i.e., Trend, Seasonality, and Residue.

## 2. Model for the Non-trend (Seasonality) Dataset of Subsidence (s<sub>non-trend</sub>) and Groundwater (h<sub>non-trend</sub>)
**Non-trend Model_main.ipynb**: -  Estimates the non-trend subsidence (s<sub>non-trend</sub>) through non-trend groundwater (h<sub>non-trend</sub>) using the Random Forest (RF) model.

s<sub>non-trend</sub> = f(h<sub>non-trend</sub>)

## 3. Change Estimator for Subsidence Change (&Delta;s) based on Groundwater Change (&Delta;h)
**Change_Estimator_main.m**: - Estimates subsidence change (&Delta;s) through hydraulic head change (&Delta;h) using GWR. Also provides spatial Intercepts & Coefficients for each Wells.

&Delta;s = f(&Delta;h)

## 4. Trend Estimator for Computing Trends in Subsidence i.e., s<sub>trend</sub>
**Trend Estimator.xlsx**: - Provides calculation to estimate s<sub>trend</sub> using the &Delta;s and s<sub>non-trend</sub> from "*Change_Estimator_main.m*" and  "*Non-trend Model_main.ipynb*", respectively in 4 sample wells.

# System Environment at the time of Experiment
**OS**: - Microsoft Windows 10 Home

**CPU**: - Inter(R) Core(TM) i7 7700HQ 2.80 GHz

**RAM**: - 16.00 GB

1. The "*Decomposition_main.py*", "*Change_Estimator_main.m*", and  "*Non-trend Model_main.ipynb*" were tested on Python Programming Language (Version 3.9)

2. The "*Change_Estimator_main.m*" was tested on MATLAB (2022a) Environment.

# Important References
1. Breiman, L., 2001. Random Forests. Mach. Learn. 45, 5–32. https://doi.org/10.1023/A:1010933404324
2. Cleveland, R.B., Cleveland, W.S., McRae, J.E., Terpenning, I., 1990. STL: A Seasonal-Trend Decomposition Procedure Based on Loess. J. Off. Stat. 6, 3–73.
3. LeSage, J., & Pace, R. K. (2009). Introduction to spatial econometrics. Chapman and Hall/CRC.
