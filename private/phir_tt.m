function y = phir_tt(delta, tau, coeffs)
% second partial derivative for tau of phir
% where phir = residual part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
[n,c,d,t,alpha,beta,gamma,epsilon,a,b] = coeffs{6:15};
     
y = n(1:7)' * (t(1:7).*(t(1:7)-1).*delta.^d(1:7) .* tau.^(t(1:7)-2));

y = y + n(8:51)' * (t(8:51).*(t(8:51)-1) .* delta.^d(8:51) .* ...
       tau.^(t(8:51)-2) .* exp(-delta.^c(8:51)) );

y = y + n(52:54)' * ( delta.^d(52:54) .* tau.^t(52:54) ...
    .* exp(-alpha.*(delta - epsilon).^2 -beta(1:3).*(tau - gamma).^2) ...
    .* ( (t(52:54)/tau - 2*beta(1:3).*(tau - gamma)).^2 ...
     - t(52:54)./tau.^2 - 2.*beta(1:3) ));

y = y + n(55:56)' * delta * ( ...
    Delta_b_tt(delta,tau,coeffs) .* Psi(delta,tau,coeffs) ...
    + 2.*Delta_b_t(delta,tau,coeffs).*Psi_t(delta,tau,coeffs) ...
    + Delta(delta,tau,coeffs).^b .* Psi_tt(delta,tau,coeffs)); 
