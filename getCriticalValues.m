function [Tc rhoc] = getCriticalValues()
% returns the critical values of T and rho
% parameters:
%   none
% results:
%   Tc       temperature at the critical point
%   rhoc     density at the critical point

global IAPWS95_COEFFS;
if isempty(IAPWS95_COEFFS)
   IAPWS95_COEFFS = readIAPWS95data();
end 

% unpack coefficients
[Tc rhoc] = IAPWS95_COEFFS{2:3};
