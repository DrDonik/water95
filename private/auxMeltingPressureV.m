function pm = auxMeltingPressureV(T)
% computes approximate value of the melting pressure of ice V
% according to [1, p.401]

pn = 350.1e6;
Tn = 256.164;
Tmin = 256.164;
Tmax = 273.31;
th = T/Tn;

pm = pn*(1 - 1.18721*(1 - th.^8));
pm((T < Tmin) | (T > Tmax)) = NaN;
