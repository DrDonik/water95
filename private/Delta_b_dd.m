function y = Delta_b_dd(delta, tau, coeffs)
% Delta_b_dd = (d2 Delta^b)/(d delta2)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
b = coeffs{15};

y = b .* ( Delta(delta,tau,coeffs).^(b-1).*Delta_dd(delta,tau,coeffs) + ...
   (b-1).*Delta(delta,tau,coeffs).^(b-2).*(Delta_d(delta,tau,coeffs)).^2);
