function pS = auxSaturationPressure(T)
% computes approximate value of the saturation pressure
% according to [1, p.398f]
% they are better than 0.2% (cf. clausiusClapeyronFit) therefore
%   use [0.998*pS, 1.002*pS] as bounds
% values outside [Tt, Tc] are clamped to allow simpler inversion

Tc = 647.096; 
pc = 22.064e6;
a1 = -7.85951783; 
a2 = 1.84408259;
a3 = -11.7866497;
a4 = 22.6807411;
a5 = -15.9618719;
a6 = 1.80122502;

T = min(Tc, max(T, 0));
th = 1 - T/Tc;

t1 = a1*th + a2*th.^1.5 + a3*th.^3 + a4*th.^3.5 + ...
      a5*th.^4 + a6*th.^7.5;
pS = pc*exp(Tc*t1./T);
