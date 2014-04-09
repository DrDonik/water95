function pm = auxMeltingPressureVII(T)
% computes approximate value of the melting pressure of ice VII
% according to [1, p.401]

pn = 2216e6;
Tn = 355;
Tmin = 355;
Tmax = 715;
th = T/Tn;

pp = 1.73683*(1 - 1./th) - 0.0544606*(1 - th.^5)  ...
       + 0.806106e-7*(1 - th.^22);
pm = pn*exp(pp);
pm((T < Tmin) | (T > Tmax)) = NaN;
