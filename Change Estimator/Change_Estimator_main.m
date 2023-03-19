% ********** Geographically Weighted Regression (GWR) for Estimating Subsidence Change (∆s) ***********
% For a more detailed description of the GWR parameters, please refer to "gwr.m"

%
% s = Deformation (cm)
% h = Hydraulic Head (m)
% dh = hydraulic head change(∆h)
% ds = subsidence change(∆s)

% ∆s(t) = f(∆h(t))

% Compute ∆s & ∆h for each well from the h and s time series data given in 
% the file located in "Decomposition/Data"
% ∆s(t) = s(t) - s(t-1)
% ∆h(t) = h(t) - h(t-1)

% Training Period: - 2015 to 2018
% Testing Period: - 2019 & 2020

% Loading the Training Data
[II, text1, rawData1] =xlsread('Data/Training Data (2015-18).csv');

%  east = X-coordinates in space
%  north = Y-coordinates in space

dh = II(:,5);
ds= II(:,4);
east= II(:,2);
north= II(:,3);
n = size(ds,1);
dh(1:n,1) = 1;
dh(1:n,2) = II(:,5);

% Running The GWR model
GWR = gwr(ds,dh,east,north);

% Saving the Spatial Coefficients & Intercepts
coeff = GWR.beta;
coeff2 = array2table(coeff);
coeff2.Properties.VariableNames(1:2)={'Intercept' ,'Coefficient'};
station_id_coord = rawData1(2:n+1,1:3);
station_id_coord2 = array2table(station_id_coord);
station_id_coord2.Properties.VariableNames(1:3)={'Well ID' ,'X', 'Y'};
coefficient_file = [station_id_coord2, coeff2];
writetable(coefficient_file, "Spatial_Coefficient.csv")

% Use the coefficients for subsequent estimation of ∆s using ∆h as shown in
% file "Trend Estimation.csv" over each Groundwater Monitoring Well and 
% calculate their respective total subsidence (s(t)) in Microsoft Excel by 
% using the following equations:
% ***∆s(t) = Intercept(X,Y)+ Coefficient(X,Y)*∆h(t)***
% ***s(t) = s(t-1) + Δs(t)***