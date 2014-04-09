function [T, x] = temperature(p, rho, T0)
% returns temperature and dryness fraction as functions of p and rho
% x is simply 0 (1) below (above) the saturation curve
% parameters:
%   p        pressure
%   rho      density
%   T0       start temperature (optional)
% results:
%   T        temperature
%   x        dryness fraction

if nargin == 2
  T0 = findInitialTemperature(p,rho);
end

func = @(T) pressure(rho,T) - p;
T = fzero(func, T0);

[pNew, x] = pressure(rho, T);

errRel = abs(p - pNew)/p;
if (errRel > 1e-6)
  warning('water95:inconsistentState', ...
          'inconsistent results in temperature, rel. error = %f', errRel);
end
    
%--------------------------------------------------------
function T0 = findInitialTemperature(p,rho)
% returns a start value for the inversion of p(T)
% that gives the correct answer

% works always! But may be slow...
T0 = 300;
