function y = phir_dd(delta, tau, coeffs)
% second partial derivative for delta of phir
% where phir = residual part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
[n,c,d,t,alpha,beta,gamma,epsilon,a,b] = coeffs{6:15};

y = n(1:7)' * (d(1:7).*(d(1:7)-1).*delta.^(d(1:7)-2).* tau.^t(1:7));
      
y = y + n(8:51)' * ( exp(-delta.^c(8:51)) .* ...
       ( delta.^(d(8:51)-2) .* tau.^t(8:51) .* ...
        ((d(8:51) - c(8:51).*delta.^c(8:51)).* ...
          (d(8:51) - 1 - c(8:51).*delta.^c(8:51)) - ...
	 (c(8:51)).^2.*delta.^c(8:51)) ) );

y = y + n(52:54)' * ( tau.^t(52:54).* ...
     exp(-alpha.*(delta - epsilon).^2 ...
         -beta(1:3).*(tau - gamma).^2) ...
      .* (-2*alpha.*delta.^d(52:54) ...
          + 4*alpha.^2.*delta.^d(52:54).*(delta-epsilon).^2 ...
          - 4*d(52:54).*alpha.*delta.^(d(52:54)-1).*(delta-epsilon) ...
          + d(52:54).*(d(52:54)-1).*delta.^(d(52:54)-2)));

tPsi = Psi(delta,tau,coeffs);
dPsi = Psi_d(delta,tau,coeffs);
y = y + n(55:56)' * ( Delta(delta,tau,coeffs).^b ...
      .* (2.*dPsi + delta.* Psi_dd(delta,tau,coeffs)) ...
   + 2*Delta_b_d(delta,tau,coeffs).*(tPsi + delta.*dPsi) ...
   + Delta_b_dd(delta,tau,coeffs).*delta.*tPsi);
