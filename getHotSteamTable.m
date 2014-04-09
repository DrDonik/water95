function [p, T, v, h, s] = getHotSteamTable()
% returns a hot steam table with a range of useful values
% parameters:
%   none
% results:
%   p       pressure values
%   T       temperature values
%   v       specific volume values
%   h       specific enthalpy values
%   s       specific entropy values

p = ...
[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.2,0.2,0.2,0.2,0.2,0.2,...
0.2,0.2,0.2,0.2,0.2,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.4,0.6,0.6,...
0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.6,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8,...
0.8,0.8,1,1,1,1,1,1,1,1,1,1,1,1.2,1.2,1.2,1.2,1.2,1.2,1.2,1.2,1.2,1.2,1.5,...
1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,2,2,2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4,4,...
4,6,6,6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8,8,8,10,10,10,10,10,10,10,10,10,10,15,...
15,15,15,15,15,15,15,15,15,20,20,20,20,20,20,20,20,20,20,30,30,30,30,30,30,...
30,30,30,30,40,40,40,40,40,40,40,40,40,40,50,50,50,50,50,50,50,50,50,50,60,...
60,60,60,60,60,60,60,60,60,80,80,80,80,80,80,80,80,80,80,100,100,100,100,...
100,100,100,100,100,100,150,150,150,150,150,150,150,150,150,150,200,200,...
200,200,200,200,200,200,200,300,300,300,300,300,300,300,300,300,300,...
300,300,300,300,300,300,500,500,500,500,500,500,500,500,500,500,500,500,...
500,500,500,500] * 1e5;

T = ...
[50,100,150,200,250,300,350,400,450,500,550,600,100,150,200,250,300,350,...
400,450,500,550,600,100,150,200,250,300,350,400,450,500,550,600,100,150,...
200,250,300,350,400,450,500,550,600,100,150,200,250,300,350,400,450,500,...
550,600,100,150,200,250,300,350,400,450,500,550,600,150,200,250,300,350,...
400,450,500,550,600,150,200,250,300,350,400,450,500,550,600,150,200,250,...
300,350,400,450,500,550,600,150,200,250,300,350,400,450,500,550,600,200,...
250,300,350,400,450,500,550,600,650,200,250,300,350,400,450,500,550,600,...
650,200,250,300,350,400,450,500,550,600,650,200,250,300,350,400,450,500,...
550,600,650,250,300,350,400,450,500,550,600,650,700,250,300,350,400,450,...
500,550,600,650,700,300,350,400,450,500,550,600,650,700,750,300,350,400,...
450,500,550,600,650,700,750,300,350,400,450,500,550,600,650,700,750,300,...
350,400,450,500,550,600,650,700,750,350,400,450,500,550,600,650,700,750,...
800,350,400,450,500,550,600,650,700,750,800,400,450,500,550,600,650,...
700,750,800,50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800,...
50,100,150,200,250,300,350,400,450,500,550,600,650,700,750,800];
T = celsiusToKelvin(T);

v = zeros(size(p));
h = zeros(size(p));
s = zeros(size(p));

for I=1:size(p,2)
  rho = density(p(I), T(I));
  v(I) = 1/rho;
  h(I) = enthalpy(rho, T(I));
  s(I) = entropy(rho, T(I));
end
