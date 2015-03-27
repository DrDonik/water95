function p = pressureRaw(rho, T)
% computes the (raw) pressure as function of rho and T
% The value is directly derived from the IAPWS95 equations.
% It is not correct on the saturation curve, where it has to be
%   extended using the Maxwell construction
%   (cf. saturationPressure.m).
% parameters:
%     rho      density [kg/m^3]
%     T        temperature [K]
%

global IAPWS95_COEFFS;
if isempty(IAPWS95_COEFFS)
    IAPWS95_COEFFS = readIAPWS95data();
end

% unpack coefficients
[R,Tc,rhoc] = IAPWS95_COEFFS{1:3};

% very near to the critical point the usual routine returns NaN
% in that case simply return pc, which has been computed with
% devel/getCriticalPressure()
pc =  220.6400000000213e+05;
epsi = 1e-13;

delta = rho/rhoc;
tau = Tc/T;

if (abs(rho - rhoc) < epsi) && (abs(T - Tc) < epsi)
    p = pc;
else
    p = R*T*rho*(1 + delta*phir_d(delta,tau,IAPWS95_COEFFS));
end
