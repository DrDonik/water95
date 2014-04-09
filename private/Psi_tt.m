function y = Psi_tt(delta, tau, coeffs)
% Psi_tt = (d2 Psi)/(d tau2)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
D = coeffs{19};

y = (2*D.*(tau - 1)^2 - 1)*2.*D.*Psi(delta,tau,coeffs);
