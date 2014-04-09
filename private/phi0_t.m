function y = phi0_t(delta, tau, coeffs)
% partial derivative for tau of phi0
% where phi0 = ideal gas part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
[n0,gamma0] = coeffs{4:5};
    
y = n0(2) + n0(3)/tau;
y = y + n0(4:8)' * ( gamma0(4:8) .* ...
     (1.0./(1.0 - exp(-gamma0(4:8)*tau)) - 1.0) );
