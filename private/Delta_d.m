function y = Delta_d(delta, tau, coeffs)
% Delta_d = (d Delta)/(d delta)
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
y = d1 * ( A.*theta(delta,tau,coeffs).*2./beta(4:5) ...
                   .* (d1^2).^(1./(2*beta(4:5))-1) ...
           + 2*B.*a.*(d1^2).^(a-1) );
