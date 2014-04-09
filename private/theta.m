function y = theta(delta, tau, coeffs)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
beta = coeffs{11};
A = coeffs{16};

y = (1 - tau) + A.*((delta - 1)^2).^(1./(2*beta(4:5))) ;
