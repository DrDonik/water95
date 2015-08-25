function [rhop, rhopp] = directAuxSaturationDensities(T)
    % exposes the helper function to calculate approximate values for the
    % saturation densities
    
    [rhop, rhopp] = auxSaturationDensities(T);
    
    % auxSaturationDensity for the liquid phase is only valid down to -36
    % centigrades. Below that, we rely on a fit for values calculated along
    % an iso_Th curves.
    if T < 273.15-36
        rhop = 16.31*sqrt(0.2167*(T-273.15+39.56))+958.4;
    end

    return
end