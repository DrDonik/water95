function y = Delta_b_tt(delta, tau, coeffs)
% Delta_b_tt = (d2 Delta^b)/(d tau2)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
b = coeffs{15};

y = 2*b.*Delta(delta,tau,coeffs).^(b-1) + ...
  4*(theta(delta,tau,coeffs)).^2.*b.*(b-1).*Delta(delta,tau,coeffs).^(b-2);
