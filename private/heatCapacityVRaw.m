function cv = heatCapacityVRaw(rho, T)
% computes the (raw) specific isochoric heat capacity as function of rho and T
% parameters:
%     rho      density [kg/m^3]
%     T        temperature [K]

global IAPWS95_COEFFS;
if isempty(IAPWS95_COEFFS)
   IAPWS95_COEFFS = readIAPWS95data();
end 

% unpack coefficients
[R,Tc,rhoc] = IAPWS95_COEFFS{1:3};
delta = rho/rhoc;
tau = Tc/T;

cv = -R*tau.^2*(phi0_tt(delta,tau,IAPWS95_COEFFS) ...
                + phir_tt(delta,tau,IAPWS95_COEFFS)) ;
