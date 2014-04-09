function y = phi0(delta, tau, coeffs)
% ideal gas part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
[n0,gamma0] = coeffs{4:5};
      
y = log(delta) + n0(1) + n0(2)*tau + n0(3)*log(tau);
y = y + n0(4:8)'*log(1 - exp(-gamma0(4:8)*tau));
