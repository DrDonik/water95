function ps = auxSublimationPressure(T)
% computes approximate value of the sublimation pressure of water
% according to [1, p.401]

pn = 611.657;
Tn = 273.16;
th = T/Tn;

pp = -13.928169*(1 - th.^(-1.5)) + 34.7078238*(1 - th.^(-1.25));
ps = pn*exp(pp);
ps((T < 200) | (T > 273.16)) = NaN;
