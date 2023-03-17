%
%  Groundwater levels estimation from GPS deformation (DEMO version)
%
%   £Ght =f(£GSt),  ht+1=ht+£Ght
%   
%  
%
% Input % 
%
% xloc,yloc, X, Y: Observation location x, location y, GPS deformation, Groundwater change  
% Img1: GPS deformation matrix (Fig1)
% Img3: Inital groundwater level matrix
%
% Chou.shp: Study area shapefile
%
%  
% Output %
%
% Ch1: Groundwater level change matrix (Fig2)
% ZZ:  Estimated next-time groundwater level matrix (Fig3)
%
%
% Release 04/23/2021
% 
% Refrences: 
%  Spatio-temporal estimation of monthly groundwater levels from GPS-based
%  land deformation (submitted)

clear all; close all;
%%%%%%%%%%Input data CSV%%%%%%%%% %
% % load XY data
[num,txt,raw] = xlsread('.\Excel data\Dec.csv');
loc=find(num(:,5)==9999); num(loc,:)=[];
loc=find(num(:,4)==-9999);num(loc,:)=[];

Y =num(:,4);
m = size(Y,1); row=m; 

XXX(:,1)=(num(:,5));
xloc=num(:,2);
yloc=num(:,3);
% 
%%%%%%%%%%Input variable tiff input%%%%%%%% 
[Img1,R] = geotiffread('.\Delta GPS\Dec');
Img1=double(Img1);
%lower and upper bound setting
Img1(find(Img1<-4))=nan; 
Img1(find(Img1>100))=nan;

%Display of the input image
figure;
h=imagesc(Img1);
set(h,'alphadata',~isnan(Img1));
axis equal;axis off;colorbar;

% % For changing its sign from negative to poitive
% 
 Img2=-1.*Img1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%Modelling for Estimation%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % GWR regression
result = gwr(Y,XXX,xloc,yloc);
% GWR  Mapping
x1=xloc; y1=yloc; 
[x] =(R.XWorldLimits(1,1):1000:R.XWorldLimits(1,2)-1000)';
[y] =(R.YWorldLimits(1,2):-1000:R.YWorldLimits(1,1)+1000)';
% Study area extraction from overall results
SS = shaperead('.\Study area\Chou.shp');
  for i=1:length(SS)
    XX{i}=SS(i,1).X;
    YY{i}=SS(i,1).Y;
   end;
  [X00,Y00] = meshgrid(x,y);
  in = inpolygon(X00,Y00,SS(i,1).X',SS(i,1).Y');

v0=result.beta(:,1);
z0=IDW(x1,y1,v0,x,y,-2,'ng',length(x1));
zz=(z0);
zz((in~=1))=nan;

%%%%%Spatial Estimation mapping of Groundwater Change%%%%
Ch1=zz.*Img2;
%lower and upper bound setting
Ch1(find(Ch1<-7))=nan;
Ch1(find(Ch1>100))=nan;
Ch1((in~=1))=nan;
 
%%%%%%%%%Ouput map of Spatial estimation%%%%%%%%
figure;
h2=imagesc(Ch1);
set(h2,'alphadata',~isnan(Ch1));
axis equal;axis off; colorbar;
 % % 
for k=1:row
X0=xloc(k);
Y0=yloc(k);
Z0(k,1)=Y(k);
row1(k,1)=ceil( size(Ch1,1)-(Y0-R.YWorldLimits (1,1))/R.CellExtentInWorldY+1);
col1(k,1)=ceil((X0-R.XWorldLimits (1,1))/R.CellExtentInWorldX);

end
% Boundary setting
loc1=find(row1>79|col1>66);
row1(loc1)=[];
col1(loc1)=[];
Z0(loc1)=[];
for k=1: length(col1)
%  Error
   E(1,k)=Ch1((row1(k)),(col1(k)))-Z0(k);
end
%Emean=mean(abs(E'));
  RMSE = sqrt(nanmean((E').^2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%Monthly Groundwater table estimation%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
[Img3,R] = geotiffread('.\Water table data\Dec');
Img3=double(Img3);
%lower and upper bound setting 
Img3(find(Img3<-40))=nan;
Img3(find(Img3>150))=nan;

ZZ=Img3+Ch1;

%%%%%%%%Output results of Groundwater table%%%%%%%%%%
figure;
h3=imagesc(ZZ);
set(h3,'alphadata',~isnan(ZZ));
axis equal;axis off; colorbar;