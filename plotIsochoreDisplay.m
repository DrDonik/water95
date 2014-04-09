function plotIsochoreDisplay()
% plots p-T diagrams of isochores for several (fixed) rhos
% parameters:
%   none
% results:
%   none

T = celsiusToKelvin(0.01:5:800);
rho = [1000 500 324 100 10 1];
pMax = [2e4 4e3 2e3 7e2 70 7];    % in bar

% saturation curve
TS = celsiusToKelvin(3:10:373);
pS = zeros(size(TS));
for I=1:size(TS,2)
  pS(I) = saturationPressure(TS(I));
end
pC = 220.64;       % bar
T0C = celsiusToKelvin(0.0);
TC = getCriticalValues() - T0C;    % °C

fig1 = figure('Position', [0 0 900 600]);

for I=1:size(rho,2)
  p = vectorize2d(@pressure,rho(I), T);
  subplot(3,2,I)
  plot(T-T0C, p*1e-5, 'k-', TS-T0C, pS*1e-5, 'm-.', ...
      TC, pC, 'r*')
  axis([0 800 0 pMax(I)])
  title(strcat('\rho =', sprintf('%.0f kg/m^3', rho(I))));
  xlabel('t [°C]');
  ylabel('p [bar]');
end
