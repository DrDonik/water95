function y = Psi_t(delta, tau, coeffs)
% Psi_t = (d Psi)/(d tau)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
D = coeffs{19};

y = -2*D.*(tau - 1).*Psi(delta,tau,coeffs);
