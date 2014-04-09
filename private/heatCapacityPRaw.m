function cp = heatCapacityPRaw(rho, T)
% computes the (raw) specific isobaric heat capacity as function of rho and T
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

phi_rd = phir_d(delta,tau,IAPWS95_COEFFS);
cp = -R*tau.^2*(phi0_tt(delta,tau,IAPWS95_COEFFS) ...
                + phir_tt(delta,tau,IAPWS95_COEFFS)) ...
     + R*(1 + delta*phi_rd ...
            - delta*tau*phir_dt(delta,tau,IAPWS95_COEFFS)).^2 ...
              ./(1 + 2*delta*phi_rd + delta.^2*phir_dd(delta,tau,IAPWS95_COEFFS));
