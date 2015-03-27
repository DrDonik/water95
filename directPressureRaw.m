function p = directPressureRaw(rho, T)
    % exposes the helper function to calculate the raw pressure from
    % iapws95

    p = pressureRaw(rho, T);
    
    return
end