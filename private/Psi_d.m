function y = Psi_d(delta, tau, coeffs)
% Psi_d = (d Psi)/(d delta)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
C = coeffs{18};

y = -2*C.*(delta - 1).*Psi(delta,tau,coeffs);
