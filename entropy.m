function [s, x] = entropy(rho, T)
% returns specific entropy and dryness fraction as functions of rho and T
% parameters:
%   rho      density
%   T        temperature
% results:
%   s        specific entropy
%   x        dryness fraction

[flag, x, rhop, rhopp, pS] = findRegion(rho, T);

switch flag
  case {1, 3, 4}          % supercritical, water, steam
    s = entropyRaw(rho, T);
  case 2                  % below Tt
    if T >= 240.0   
      s = entropyRaw(rho, T);
    else  
      s = -575;      % simple cutoff
    end
  case 5                  % on saturation curve
    sp = entropyRaw(rhop, T);
    spp = entropyRaw(rhopp, T);
    s = sp + x*(spp - sp);
end
