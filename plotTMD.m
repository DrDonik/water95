function [T, rho] = plotTMD(p)
%plotTMD plots the temperature of maximum density line in a p-T diagram
% parameters:
%   p        pressure [Pa]
% results:
%   T        temperature  on the TMD [K]
%   rho      density on the TMD [kg/m^3]

TmD = @(x) -localDensity(p, x);

[T, rho] = fminbnd(TmD, 2+273.15, 6+273.15);

rho = -rho;

end

function rho = localDensity(p, T)

func = @(x) pressureRaw(x,T) - p; 
rho = fzero(func, 999);

return
end