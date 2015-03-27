function [pS, rhop, rhopp] = saturationPressure(T)
% returns saturation pressure and densities of the liquid and vapor phase
% as functions of T
% parameters:
%   T        temperature
% results:
%   pS       saturation pressure
%   rhop     density for x = 0
%   rhopp    density for x = 1

global IAPWS95_COEFFS;
if isempty(IAPWS95_COEFFS)
    IAPWS95_COEFFS = readIAPWS95data();
end

% unpack coefficients
[R,Tc,rhoc] = IAPWS95_COEFFS{1:3};
tau = Tc/T;
Tt = getTriplePointTemperature();
epsi = 1e-12;

if T > Tc
    pS = NaN;
    rhop = NaN;
    rhopp = NaN;
    return;
end

if T*(1+eps) < Tt
%  pS = NaN;
%  rhop = NaN;
%  rhopp = NaN;
%  For @inclusion, we need to extend into the metastable region and NOT stop
%  here. For now, we use the IAP version 
%  Coefficients in the equation for the pressure on the liquid-vapor
%  equilibrium curve
    a1 = -7.85951783;
    a2 = 1.84408259;
    a3 = -11.7866497;
    a4 = 22.6807411;
    a5 = -15.9618719;
    a6 = 1.80122502;

    pc = 22.064 * 10^6; %Pressure in Pa at the critical point of water
    x = 1 - 1/tau;

    pS = pc * exp(tau*(a1*x + a2*x.^1.5 + a3*x.^3 + a4*x.^3.5 + a5*x.^4 + a6*x.^7.5));
    return
end

% get start values from auxiliary model
pS = auxSaturationPressure(T);
[rhop, rhopp] = auxSaturationDensities(T);
pS0 = pS;
diff = 1;

%
% If T is not close to Tc, the bounds suffice to get
% reasonable start values for rhop/rhopp.
%
if T <= Tc - 3.5e-3
    while diff > epsi
        pS = R*T*(phir(rhop/rhoc, tau, IAPWS95_COEFFS) ...
            - phir(rhopp/rhoc, tau, IAPWS95_COEFFS) ...
            + log(rhop/rhopp)) / (1/rhopp - 1/rhop);
        rhop = density(pS, T, rhop);
        rhopp = density(pS, T, rhopp);
        diff = abs((pS - pS0)/pS);
        pS0 = pS;
    end
    %
    % Near Tc find the two extrema and search only in one direction
    % to find good start values for rhop/rhopp.
    % After one iteration one is quite close to the correct values,
    % but fzero can still run away for wrong solutions!
    % To prevent that, provide an interval around the first value
    % which contains the correct result.
    % All magic numbers are taken from a few plots with plotMaxwellRho
    % and have to be chosen carefully to guarantee convergence.
    %
elseif T <= Tc - 6e-6
    rhoMin = fminbnd(@(x) pressureRaw(x,T), rhopp, rhop);
    rhoMax = fminbnd(@(x) -pressureRaw(x,T), rhopp, rhop);
    drho = 1;
    while diff > epsi
        pS = R*T*(phir(rhop/rhoc, tau, IAPWS95_COEFFS) ...
            - phir(rhopp/rhoc, tau, IAPWS95_COEFFS) ...
            + log(rhop/rhopp)) / (1/rhopp - 1/rhop);
        rhop = density(pS, T, [rhoMin, rhop + drho]);
        rhopp = density(pS, T, [rhopp - drho, rhoMax]);
        diff = abs((pS - pS0)/pS);
        pS0 = pS;
    end
    %
    % If T is VERY near to Tc, use the critical behaviour
    % for start values of a single iteration or directly
    %
else
    [pS, rhop, rhopp] = nearCriticalValues(T, Tc, rhoc);
    pS = (pressureRaw(rhop, T) + pressureRaw(rhopp, T))/2;
    
    if T <= Tc - 5e-8
        drho = 0.03;
        rhop = density(pS, T, [rhop-drho, rhop+drho]);
        rhopp = density(pS, T, [rhopp-drho, rhopp+drho]);
    end
end

%---------------------------------------------------------
function [pS, rhop, rhopp] = nearCriticalValues(T, Tc, rhoc)
% In the vicinity of the critical point the values are fitted
% linearly (p) or with a power law (rho).
% Fit values from showNearlyCriticalDensities()

pc = pressureRaw(rhoc, Tc);
a = 2.672407766194239e+05;
b = 1.470566737429767e+02;      % exp(yFit(2))
c = 0.485237103597738;          % yFit(1)

pS = pc - a*(Tc - T);
rhop = rhoc + b*(Tc - T)^c;
rhopp = rhoc - b*(Tc - T)^c;
