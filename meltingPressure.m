function [pm, rho] = meltingPressure(T)

%Calculate the pressure on the melting curve
%Refer to equation (2.16) of Wagner and Pruss, J. Phys. Chem. Ref. Data, 31, p 387 (2002)


T_ctr = 0;
rho = zeros(size(T));
pm = zeros(size(T));
Tn = 273.16;
pn = 0.000611657 * 10^6;

for T_walking = T;
    T_ctr= T_ctr+1;
    theta = T_walking/Tn;
    pm (T_ctr) = pn * (1 - 0.626*10^6*(1-theta.^-3)+0.197135*10^6*(1-theta.^21.2));
    
    func = @(x) pressureRaw(x,T_walking) - pm(T_ctr);
    rho (T_ctr) = fzero(func, 1000);

   
end