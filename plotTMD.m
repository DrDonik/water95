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

% dp_dtau = @(rho,T) -pressureRaw(rho, T)/(Tc/T)*(rho/rhoc)*phir_dt((rho/rhoc), (Tc/T), coeffs);
dp_dtau = @(rho,T) pressureRaw(rho, T)*T - R*T*rho*(1 + (rho/rhoc)*phir_dt((rho/rhoc), (Tc/T), coeffs)*T^2/Tc);

[rho, p] = fzero(dp_dtau, [0, 0]);

end
