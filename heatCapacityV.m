function [cV, x] = heatCapacityV(rho, T)
% returns specific isochoric heat capacity and dryness fraction 
%    as functions of rho and T
% parameters:
%   rho      density
%   T        temperature
% results:
%   cV       specific isochoric heat capacity
%   x        dryness fraction

[flag, x, rhop, rhopp, pS] = findRegion(rho, T);

switch flag
  case {1, 2, 3, 4}          % supercritical, below Tt, water, steam
    cV = heatCapacityVRaw(rho, T);
  case 5                  % on saturation curve
    if x < 5*eps  % allow for a small overlap
      cV = heatCapacityVRaw(rhop, T);
    elseif(x > 1 - 5*eps)
      cV = heatCapacityVRaw(rhopp, T);
    else
      cV = Inf;
    end
end
