function y = Psi_dd(delta, tau, coeffs)
% Psi_dd = (d2 Psi)/(d delta2)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
C = coeffs{18};

y = (2*C.*(delta - 1)^2 - 1)*2.*C.*Psi(delta,tau,coeffs);
