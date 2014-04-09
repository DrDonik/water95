function [flag, x, rhop, rhopp, pS] = findRegion(rho, T)
% auxiliary function that finds the region corresponding to rho and T.
% it tries to avoid the expensive saturation curve computations.
%
% parameters:
%   rho     density
%   T       temperature
%
% results:
%   flag    region code
%              1   supercritical
%              2   below Tt
%              3   water
%              4   steam
%              5   saturation curve
%   x       dryness fraction  
%   rhop    density of water, if on the saturation curve (else NaN)
%   rhopp   density of steam, if on the saturation curve (else NaN)
%   pS      saturation pressure, if on the saturation curve (else NaN)

rhop = NaN;
rhopp = NaN;
pS = NaN;

[rhopA, rhoppA] = auxSaturationDensities(T);
if rhopA == 0      % supercritical
  x = NaN;
  flag = 1;
  return;
elseif rhopA == -1      % below Tt
  flag = 2;
  x = 1;
  return;
end

if rho > 1.004*rhopA            % water
  flag = 3;
  x = 0;
  return;
elseif rho < 0.996*rhoppA       % steam
  flag = 4;
  x = 1;
  return;
end

% saturation curve is near, look closer
[pSA, rhopA, rhoppA] = saturationPressure(T);
margin = 1 + 5*eps;
if rho > margin*rhopA            % water
  flag = 3;
  x = 0;
  return;
elseif rho < rhoppA/margin       % steam
  flag = 4;
  x = 1;
  return;
end

% we are on the saturation curve (within numeric accuracy)
flag = 5;
rhop = rhopA;
rhopp = rhoppA;
pS = pSA;
x = (rhop - rho)/(rhop - rhopp) * (rhopp/rho);
x = min(1, max(0, x));     % to cope with numerical errors  
