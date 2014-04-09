function [cP, x] = heatCapacityP(rho, T)
% returns specific isobaric heat capacity and dryness fraction 
%    as functions of rho and T
% parameters:
%   rho      density
%   T        temperature
% results:
%   cP       specific isobaric heat capacity
%   x        dryness fraction

[flag, x, rhop, rhopp, pS] = findRegion(rho, T);

switch flag
  case {1, 2, 3, 4}          % supercritical, below Tt, water, steam
    cP = heatCapacityPRaw(rho, T);
  case 5                  % on saturation curve
    if x < 5*eps  % allow for a small overlap
      cP = heatCapacityPRaw(rhop, T);
    elseif(x > 1 - 5*eps)
      cP = heatCapacityPRaw(rhopp, T);
    else
      cP = Inf;
    end
end
