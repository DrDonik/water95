function y = Delta(delta, tau, coeffs)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
a = coeffs{14};
B = coeffs{17};

y = theta(delta, tau, coeffs).^2 + B.*((delta - 1)^2).^a;
