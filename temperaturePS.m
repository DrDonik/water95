function [T, x] = temperaturePS(p, s, T0)
% returns temperature and dryness fraction as functions of p and s
% x is 0 (1) below (above) the saturation curve
% parameters:
%   rho      density
%   s        specific entropy
%   T0       start temperature (optional)
% results:
%   T        temperature
%   x        dryness fraction

Tc = getCriticalValues();
Tt = getTriplePointTemperature();

if p > saturationPressure(Tc)
  if nargin == 2 
    T0 = 700;
  end
  func = @(T) entropy(density(p,T), T) - s;
  T = fzero(func, T0); 
  x = NaN;
  return;
end

% check, if we are on saturation curve
TS = saturationTemperature(p);
[pS, rhop, rhopp] = saturationPressure(TS);
sp = entropy(rhop, TS);
spp = entropy(rhopp, TS);
x = (s - sp)/(spp - sp);

if (x >= 0) && (x <= 1)    % on the saturation curve
  T = TS;
else
  if nargin == 2       % find a reasonable start value
    if x < 0              % water
      T0 = findInitialTemperatureW(s);
    else                  % vapor
      T0 = findInitialTemperatureV(s, spp, TS);       
    end
  end
  
  func = @(T) entropy(density(p,T), T) - s;
  T = fzero(func, T0);
  x = min(1, max(0, x));
end

%--------------------------------------------------------
function T0 = findInitialTemperatureW(s)
% returns a start value for the inversion of s(T) for water
% that gives the correct answer
Tt = getTriplePointTemperature();
cp = 4200;
T0 = Tt*exp(s/cp);

%--------------------------------------------------------
function T0 = findInitialTemperatureV(s, spp, TS)
% returns a start value for the inversion of s(T) for vapor
% that gives the correct answer
cp = 2000;
T0 = TS*exp((s - spp)/cp);
