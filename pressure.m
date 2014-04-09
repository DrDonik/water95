function [p, x] = pressure(rho, T)
% returns pressure and dryness fraction as functions of rho and T
% simply returns 0 for T < 0°C !!
% parameters:
%   rho      density
%   T        temperature
% results:
%   p        pressure
%   x        dryness fraction

[flag, x, rhop, rhopp, pS] = findRegion(rho, T);

switch flag
  case {1, 3, 4}          % supercritical, water, steam
    p = pressureRaw(rho, T);
  case 2                  % below Tt
    if T >= celsiusToKelvin(0.0)
      p = pressureRaw(rho, T);
    else  
      p = 0.0;      % simple cutoff
    end
  case 5                  % on saturation curve
    p = pS;
end
