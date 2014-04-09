function y = phi0_d(delta, tau, coeffs)
% partial derivative for delta of phi0
% where phi0 = ideal gas part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

y=1./delta;
