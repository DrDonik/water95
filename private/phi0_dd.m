function y = phi0_dd(delta, tau, coeffs)
% second partial derivative for delta of phi0
% where phi0 = ideal gas part of free energy, dimensionless
% parameters:
%     delta = rho/rhoc     dimensionless density
%     tau = Tc/T           dimensionless inverse temperature
%     coeff                cell array with all needed parameters

% unpack coefficients
y=-1./delta.^2;
