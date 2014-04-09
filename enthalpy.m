function [h, x] = enthalpy(rho, T, cutOff)
% returns specific enthalpy and dryness fraction as functions of rho and T
% parameters:
%   rho      density
%   T        temperature
%   cutOff   optional. If false, values below T0C are computed.
% results:
%   h        specific enthalpy
%   x        dryness fraction

if (nargin < 3)
  cutOff = true;
end

[flag, x, rhop, rhopp, pS] = findRegion(rho, T);

switch flag
  case {1, 3, 4}          % supercritical, water, steam
    h = enthalpyRaw(rho, T);
  case 2                  % below Tt
    if T >= celsiusToKelvin(0.0) || ~cutOff
      h = enthalpyRaw(rho, T);
    else
      h = 0.0; 
    end
  case 5                  % on saturation curve
    hp = enthalpyRaw(rhop, T);
    hpp = enthalpyRaw(rhopp, T);
    h = hp + x*(hpp - hp);
end
