function y = phir_d(delta, tau, coeffs)
% partial derivative for delta of phir
% where phir = residual part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
[n,c,d,t,alpha,beta,gamma,epsilon,a,b] = coeffs{6:15};
      
y = n(1:7)' * (d(1:7).*delta.^(d(1:7)-1) .* tau.^t(1:7));

y = y + n(8:51)' * ( exp(-delta.^c(8:51)) .* ...
      ( delta.^(d(8:51)-1) .* tau.^t(8:51) .* ...
         (d(8:51) - c(8:51).*delta.^c(8:51)) ) );

y = y + n(52:54)' * ( delta.^d(52:54) .* tau.^t(52:54) ...
    .* exp(-alpha.*(delta - epsilon).^2 ...
           -beta(1:3).*(tau - gamma).^2) ...
    .* (d(52:54)/delta - 2*alpha.*(delta - epsilon)) );

tPsi = Psi(delta,tau,coeffs);
y = y + n(55:56)' * ( Delta(delta,tau,coeffs).^b ...
          .* (tPsi + delta*Psi_d(delta,tau,coeffs)) ...
       + (Delta_b_d(delta,tau,coeffs).*delta.*tPsi) ); 
