function f = freeEnergyRaw(rho, T)
% computes the specific free energy as function of rho and T
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

f = R*T*(phi0(delta,tau,IAPWS95_COEFFS) ...
          + phir(delta,tau,IAPWS95_COEFFS));
