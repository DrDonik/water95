function rho = densityTX(T, x)
% returns the density of wet steam given by temperature and dryness
% fraction
% parameters:
%   T        temperature
%   x        dryness fraction
% results:
%   rho      density

Tc = getCriticalValues();
Tt = getTriplePointTemperature();

if (T < Tt) || (T > Tc) || (x < 0) || (x > 1)
  rho = NaN;
else
  [pS, rhop, rhopp] = saturationPressure(T);
  rho = 1/(1/rhop + x*(1/rhopp - 1/rhop));
end
