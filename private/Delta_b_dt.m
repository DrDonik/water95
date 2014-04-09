function y = Delta_b_dt(delta, tau, coeffs)
% Delta_b_dt = (d2 Delta^b)/(d delta tau)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
beta = coeffs{11};
b = coeffs{15};
A = coeffs{16};

d1 = delta - 1;

y = -A.*b.*2./beta(4:5).*Delta(delta,tau,coeffs).^(b-1) ...
       .* d1.*(d1.^2).^(1./(2*beta(4:5))-1) ...
   - 2*theta(delta,tau,coeffs).*b.*(b-1).*Delta(delta,tau,coeffs).^(b-2) ...
       .* Delta_d(delta,tau,coeffs);
