function [rhop, rhopp] = directAuxSaturationDensities(T)
    % exposes the helper function to calculate approximate values for the
    % saturation densities
    
    [rhop, rhopp] = auxSaturationDensities(T);
    
    return
end