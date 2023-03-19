import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from statsmodels.tsa.seasonal import STL

#Importing Station Data Either Hydraulic Head (h) or Deformation (s)
df = pd.read_csv("Data\Well-1.csv", header= 0)


#Coverting Time Column from the DataFrame to "datetime" format for Python
df["Time"] = pd.to_datetime(df["Time"], format="%Y%m")


#Setting Date Column as Index for DataFrame
df = df.set_index('Time')


#Accessing Deformation (s) or Hydraulic Head (h) column values
series = df["s"]
series.sort_index(inplace= True)


#Seasonal and Trend Decomposition (STD)
'''Derived from Seasonal and Trend Decomposition using LOESS (STL)

Original Citation: - Cleveland, R.B., Cleveland, W.S., McRae, J.E., Terpenning, I., 1990. STL: A Seasonal-Trend Decomposition Procedure Based on Loess. J. Off. Stat. 6, 3–73.

**PARAMETERS
period (np): - the number of observations in each cycle of the seasonal component,
low-pass (nl): - the smoothing parameter for the low-pass filter
trend (nt): - the smoothing parameter for the trend component
seasonal (ns): - the smoothing parameter for the seasonal component
robust: - Flag indicating whether to use a weighted version that is robust to some forms of outliers
'''
decompose_STL = STL(series, period = 12, trend= 13, seasonal=7, low_pass= 13, robust=True)


#Inner and Outer Iteration
'''
inner_iter (ni): - the number of passes through the inner loop,
outer_iter (no): - the number of robustness iterations of the outer loop

Usually included in the STL.fit([inner_iter, outer_iter])
'''
stl_decompose= decompose_STL.fit()


#Accessing Decomposition Components (Eg. Seasonal, Trend & Residue)
residue = stl_decompose.resid
trend = stl_decompose.trend
season = stl_decompose.seasonal


#Calculating Variance for each Component
var_residue = np.var(residue)
var_trend = np.var(trend)
var_season = np.var(season)


#Computing Relative Importance (RI) for Each Component {Eqs: (2), (3), (4)}
RI_trend = (var_trend/np.var(series))*100
RI_season = (var_season/np.var(series))*100
RI_residue = (var_residue/np.var(series))*100


#Printing RI Values for Each Component
print("RI for residue, trend and seasonal are: ",ratio_residue, ratio_trend, ratio_season)


#Visualzing Decomposition
stl_decompose.plot()
plt.plot(stl_decompose.resid)
plt.bar(series.index, stl_decompose.resid, width= 3)
plt.show()


#Saving the Decomposed Time Series in the CSV format
resid_df = pd.DataFrame([stl_decompose.observed,stl_decompose.trend, stl_decompose.seasonal, stl_decompose.resid])
decomp_csv = resid_df.T
decomp_csv.to_csv("Well_1_decomposed_s.csv", header=["Original","Trend", "Seasonal","Residual"], index_label= "Time")