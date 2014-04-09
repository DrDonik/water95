function pm = auxMeltingPressureVI(T)
% computes approximate value of the melting pressure of ice VI
% according to [1, p.401]

pn = 632.4e6;
Tn = 273.31;
Tmin = 273.31;
Tmax = 355;
th = T/Tn;

pm = pn*(1 - 1.07476*(1 - th.^4.6));
pm((T < Tmin) | (T > Tmax)) = NaN;
