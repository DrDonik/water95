function y = Delta_dd(delta, tau, coeffs)
% Delta_dd = (d2 Delta)/(d delta2)
% auxiliary function in IAPWS95 formulation
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
beta = coeffs{11};
a = coeffs{14};
A = coeffs{16};
B = coeffs{17};

d1 = delta - 1;
y = 1./d1 .* Delta_d(delta, tau, coeffs)  + ...
  d1.^2.*( 4.*B.*a.*(a-1).*(d1.^2).^(a-2) + ...
  2.*A.^2.*beta(4:5).^-2.*((d1.^2).^(1./(2.*beta(4:5))-1)).^2 + ...
  A.*theta(delta,tau,coeffs).*4./beta(4:5).*(1./(2.*beta(4:5))-1).* ...
           (d1.^2).^(1./(2*beta(4:5))-2));
