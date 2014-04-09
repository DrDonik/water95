function pm = auxMeltingPressureIII(T)
% computes approximate value of the melting pressure of ice III
% according to [1, p.401]

pn = 209.9e6;
Tn = 251.165;
Tmin = 251.165;
Tmax = 256.164;
th = T/Tn;

pm = pn*(1 - 0.295252*(1 - th.^60));
pm((T < Tmin) | (T > Tmax)) = NaN;
