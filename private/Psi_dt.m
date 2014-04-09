function y = Psi_dt(delta, tau, coeffs)
% Psi_t = (d2 Psi)/(d delta tau)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
D = coeffs{19};
C = coeffs{18};

y = 4*C.*D.*(delta - 1).*(tau - 1).*Psi(delta,tau,coeffs);
