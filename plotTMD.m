function [p, rho] = plotTMD(T)
%plotTMD plots the temperature of maximum density line in a p-T diagram
% parameters:
%   T        temperature
% results:
%   p        pressure on the TMD
%   rho      density on the TMD

global IAPWS95_COEFFS;
if isempty(IAPWS95_COEFFS)
    IAPWS95_COEFFS = readIAPWS95data();
end

% unpack coefficients
[R,Tc,rhoc] = IAPWS95_COEFFS{1:3};

dp_dtau = -pressureRaw(rho, T)/tau*delta*phir_dt(delta, tau, coeffs);


func = @(x) directPressureRaw(x, T);
[rho, p] = fminsearch(func, 0);
end
