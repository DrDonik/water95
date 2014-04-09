function rho = density(p, T, rho0)
% returns the density as function of p and T
% returns rho' (water), if (p,T) is on the saturation curve
% parameters:
%   p        pressure
%   T        temperature
%   rho0     start value or interval of rho for iteration (optional)
% results:
%   rho      density

if nargin == 2
  rho0 = findInitialDensity(p,T);
  if rho0 == -1     % (p,T) is on the saturation curve!
     [pS, rho] = saturationPressure(T);
    return;
  end
end

func = @(x) pressureRaw(x,T) - p; 
rho = fzero(func, rho0);


%--------------------------------------------------------
function rho0 = findInitialDensity(p,T)
% returns a start value for the inversion of p(rho)
% that gives the correct answer
% returns -1, if the point is on the saturation curve
%    (within a certain error bound)

% first find the region with very large rho (above 1100)
if p > boundary1100(T)
  rho0 = 1200;
  return;
end

% now estimate, whether the point is left, right or above 
% the saturation curve
pc = 220.64e5;
if (p > pc)         % supercritical
  rho0 = 1000;
  return;
end  

% bounds of aux model from auxModelAccuracy()
pS = auxSaturationPressure(T);
if p <= 0.9999*pS        % steam
  if p < 5e4
    rho0 = 0.1;
  elseif p > 100e5
    rho0 = 100;  
  else
    rho0 = 1;
  end
  return;
elseif p >= 1.00005*pS    % water
  if p < boundary800(T)
    rho0 = 800;
  else
    rho0 = 1000;      
  end
  return;
end

% ok, the saturation curve is close by. Therefore:
[pS, rhop, rhopp] = saturationPressure(T);
margin = 1 + 5*eps;
if p <= pS/margin    % steam
  rho0 = rhopp;
  return;
elseif p >= pS*margin   % water
  rho0 = rhop;
  return;
end

% we hit the saturation curve!
rho0 = -1;
return;

%----------------------------------------------------------
function p1100 = boundary1100(T)
% returns lower pressure bound for rho0 = 1100
% fit values come from isochore1100Fit()

a1 = 24.60396371*1e5;
a0 = -4695.30045565*1e5;

p1100 = a1*T + a0;
%----------------------------------------------------------
function p800 = boundary800(T)
% returns upper pressure bound for rho0 = 800
% fit values come from isochore800Fit()

a1 = 13.7263594135030e5;
a0 = -7130.8669147992003e5;

p800 = a1*T + a0;
