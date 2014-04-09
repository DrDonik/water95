function plotIsochore(rho, Tmax, Tmin)
% plots a p-T diagram of an isochore for given rho from Tmin to Tmax
% Tmin is optional, default = Tt 
%
% nice test cases:
%   999.9, 283.15  
%   1000, 283.15  
%   100, 1000
% parameters:
%   rho     density
%   Tmax    maximal temperature  
%   Tmin    minimal temperature (optional)
% results:
%   none

if nargin == 2
  Tmin = celsiusToKelvin(0.01);
end

dT = (Tmax - Tmin)/100;
T = Tmin:dT:Tmax;
p = vectorize2d(@pressure,rho, T);

% find state of water
f1 = @(rho, T) getSecondResult2d(@pressure,rho, T);
x = vectorize2d(f1,rho, T);
idxW = find(x~=0);
idxH = find(x~=1);
idxS = find((x==1) | (x==0) | isnan(x));
idxX = find(~isnan(x));

pW = 1e-5*p;
pW(idxW) = NaN;
pH = 1e-5*p;
pH(idxH) = NaN;
pS = 1e-5*p;
pS(idxS) = NaN;
pX = 1e-5*p;
pX(idxX) = NaN;

plot(T, pW, 'b', T, pS, 'c', T, pH, 'r', T, pX, 'm' )
title(strcat('Isochore \rho = ', sprintf('%.2f kg/m^3', rho)));
xlabel('T [K]');
ylabel('p [bar]');
legend('liquid', 'liquid & vapor', 'vapor', 'supercritical', ...
       'Location', 'Best');