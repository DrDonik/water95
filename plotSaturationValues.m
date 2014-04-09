function plotSaturationValues()
% plots diagrams of pS(T), rho(T), h(T) and s(T) on the saturation curve
% parameters:
%   none
% results:
%   none

Tt = getTriplePointTemperature();
Tc = getCriticalValues() - 1e-6;
N1 = 100;
dT = (Tc - Tt)/N1;
T1 = Tt:dT:Tc-dT;

% some extra points near Tc
N2 = 10;
dT = dT/N2;
T2 = T1(N1)+dT:dT:Tc;

T = [T1 T2];
N = N1 + N2;

% vectorize1d has to be called 3x to get pS, rhop, rhopp -> too slow!
p = zeros(1,N);
vp = zeros(1,N);
vpp = zeros(1,N);
hp = zeros(1,N);
hpp = zeros(1,N);
sp = zeros(1,N);
spp = zeros(1,N);

for I = 1:N
  [p(I) rhop rhopp] = saturationPressure(T(I));
  vp(I) = 1/rhop;
  vpp(I) = 1/rhopp;
  hp(I) = enthalpy(rhop, T(I));
  hpp(I) = enthalpy(rhopp, T(I));
  sp(I) = entropy(rhop, T(I));
  spp(I) = entropy(rhopp, T(I));
end

T = T - celsiusToKelvin(0);
set(0,'defaultfigurecolor','white');   % weißer Hintergrund
subplot(2,2,1);
plot(T,p*1e-5);
title('Pressure');
xlabel('T [°C]');
ylabel('p [bar]');

subplot(2,2,2);
plot(T,1./vp, T, 1./vpp);
title('Density');
xlabel('T [°C]');
ylabel('\rho [kg/m^3]');

subplot(2,2,3);
plot(T,hp*1e-3, T, hpp*1e-3);
title('Enthalpy');
xlabel('T [°C]');
ylabel('h [kJ/kg]');

subplot(2,2,4);
plot(T,sp*1e-3, T, spp*1e-3);
title('Entropy');
xlabel('T [°C]');
ylabel('s [kJ/(kg K)]');
