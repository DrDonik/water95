function [p, x] = pressure(rho, T)
% returns pressure and dryness fraction as functions of rho and T
% parameters:
%   rho      density
%   T        temperature
% results:
%   p        pressure
%   x        dryness fraction

[flag, x, rhop, rhopp, pS] = findRegion(rho, T);

switch flag
  case {1, 2, 3, 4}          % supercritical, below zero, water, steam
    p = pressureRaw(rho, T);
  case 5                  % on saturation curve
    p = pS;
end
