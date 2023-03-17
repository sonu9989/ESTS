% ********** Geographically Weighted Regression (GWR) for Estimating Subsidence Change (∆s) ***********
% For a detailed description of the GWR parameters, please refer to "gwr.m"


% Loading the Training Data
[II, text1, rawData1] =xlsread('Training (2015-18)_GWR.csv');


x = II(:,4);
y= II(:,3);
east= II(:,1);
north= II(:,2);
n = size(y,1);
x(1:n,1) = 1;
x(1:n,2) = II(:,4);

% Running The GWR model
GWR = gwr(y,x,east,north);
