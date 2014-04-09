function pm = auxMeltingPressureI(T)
% computes approximate value of the melting pressure of ice I
% according to [1, p.401]

pn = 611.657;
Tn = 273.16;
Tmin = 251.165;
Tmax = 273.16;
th = T/Tn;

pm = pn*(1 - 0.626e6*(1 - th.^(-3)) + 0.197135e6*(1 - th.^21.2));
pm((T < Tmin) | (T > Tmax)) = NaN;
