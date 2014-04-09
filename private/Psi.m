function y = Psi(delta, tau, coeffs)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
[C,D] = coeffs{18:19};

y = exp(-C*(delta-1)^2 - D*(tau - 1)^2);
