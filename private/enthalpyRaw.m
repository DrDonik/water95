function h = enthalpyRaw(rho, T)
% computes the (raw) specific enthalpy as function of rho and T
% parameters:
%     rho      density [kg/m^3]
%     T        temperature [K]

h = freeEnergyRaw(rho, T) + T*entropyRaw(rho, T) + pressureRaw(rho, T)/rho;
