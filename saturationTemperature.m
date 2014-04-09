function T = saturationTemperature(pS, T0)
% returns the saturation temperature as function of p
% returns NaN if p > pc or p < pt
% parameters:
%   pS       saturation pressure
%   T0       start temperature (optional)
% results:
%   T        temperature

Tc = getCriticalValues();
Tt = getTriplePointTemperature();

pt = saturationPressure(Tt);
pc = saturationPressure(Tc);
if (pS > pc) | (pS < pt)
  T = NaN;
  return;
end

if nargin < 2
  T0 =  [Tt Tc];
end

func = @(T) saturationPressure(T) - pS;
T = fzero(func, T0);
