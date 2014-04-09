function T = temperatureRS(rho, s, T0)
% returns the temperature as function of rho and s
% parameters:
%   rho      density
%   s        specific entropy
%   T0       start temperature (optional)
% results:
%   T        temperature

if nargin == 2
  T0 = findInitialTemperature(rho, s);
end

func = @(T) entropy(rho,T) - s;
T = fzero(func, T0);

%--------------------------------------------------------
function T0 = findInitialTemperature(rho, s)
% returns a start value for the inversion of s(T)
% that gives the correct answer

% works always! But may be slow...
T0 = 300;
