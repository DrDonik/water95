function y = Delta_b_t(delta, tau, coeffs)
% Delta_b_t = (d Delta^b)/(d tau)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
b = coeffs{15};

y = -2*theta(delta,tau,coeffs).*b.*Delta(delta,tau,coeffs).^(b-1);
