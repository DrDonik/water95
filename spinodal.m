function [p, rho] = spinodal (T)

    densities = 350:0.4:1050;
    T= T+273.15;
    T_ctr = 0;
    rho = zeros(size(T));
    p = zeros(size(T));
    for T_walking = T
        T_ctr=T_ctr+1;
        inverse_isothermal_comp = inverse_isocomp(densities,T_walking);
        for ctr = 1:size(densities,2)-1
            if inverse_isothermal_comp(ctr) < 0 && inverse_isothermal_comp(ctr+1) > 0
                break;
            end
        end
        rho (T_ctr) = densities(ctr);
        p (T_ctr) = pressureRaw(rho (T_ctr),T_walking)/1e5; %Convert from Pa to bar
    end
    rho=rho/1e3; %convert to g/cm^3
    return
end
        
function inverse_isocomp_comp = inverse_isocomp(rho_array, T)

    %Calculate the isothermal compressibility...

    R = 461.51805;
    Tc = 647.096; 
    rhoc = 322;
    tau = Tc/T;

    coeffs = readIAPWS95data();

    inverse_isocomp_comp = zeros(size(rho_array));
    for ctr = 1:length(rho_array)
        rho = rho_array(ctr);

        delta = rho/rhoc;
        inverse_isocomp_comp(ctr) = rho * ((2/rho*pressureRaw(rho,T) + rho^2*(R*T/rhoc^2*(phi0_dd(delta,tau) + phir_dd(delta,tau, coeffs)))));

    end
    return
end
