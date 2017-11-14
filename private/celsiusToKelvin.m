function T = celsiusToKelvin(t)
% converts temperatures from Celsius to Kelvin
% parameters:
%   t        temperature in °C
% results:
%   T        temperature in K

T0C = 273.15;
T = t + T0C;
