function s = entropyRaw(rho, T)
% computes the (raw) specific entropy as function of rho and T
% The value is directly derived from the IAPWS95 equations;
% it is not correct on the saturation curve.
% Parameters:
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

s = R*(tau*(phi0_t(delta,tau,IAPWS95_COEFFS) ...
             + phir_t(delta,tau,IAPWS95_COEFFS)) ...
      - phi0(delta,tau,IAPWS95_COEFFS) ...
      - phir(delta,tau,IAPWS95_COEFFS));
