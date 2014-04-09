function y = phi0_tt(delta, tau, coeffs)
% second partial derivative for tau of phi0
% where phi0 = ideal gas part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
[n0,gamma0] = coeffs{4:5};
    
y = -n0(3)/tau.^2;
y = y - n0(4:8)' * ( gamma0(4:8).^2 .* ...
          exp(-gamma0(4:8).*tau).*(1-exp(-gamma0(4:8).*tau)).^-2 );
