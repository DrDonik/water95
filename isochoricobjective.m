function [ f, g, h ] = isochoricobjective(gm, dg, tau, A, stprime, coeffs, dm)

% this is the objective function to be minimized with respect to gm, dg
% we also supply gradient
% note that we require 0 < gm < 1-dm/dmax; 
% dmax is maximal density of water
% we also require 0 < dg < dm
dl = (dm - dg .* gm)./(1 - gm);
phiL = phi0(dl, tau, coeffs) + phir(dl, tau, coeffs);
phig = phi0(dg, tau, coeffs) + phir(dg, tau, coeffs);
f = (dm - dg * gm) * phiL + dg * gm * phig;

if nargout > 1
    % gradients
    phiL_d = phi0_d(dl, tau, coeffs) + phir_d(dl, tau, coeffs);
    phig_d = phi0_d(dg, tau, coeffs) + phir_d(dg, tau, coeffs);
    %note that there is an extremum (metastable valley?) at dg=dm -> dg=dl
    %another problem is the line gamma=0

    gg = dg * (phig - phiL) + dl * (dl - dg) * phiL_d;
    gd = gm * (phig - phiL + dg * phig_d - dl * phiL_d);
        
    if nargout > 2
        % Hessian
        phiL_dd = phi0_dd(dl, tau, coeffs) + phir_dd(dl, tau, coeffs);
        phig_dd = phi0_dd(dg, tau, coeffs) + phir_dd(dg, tau, coeffs);
        
        hgg = (dl - dg)^2 / ( 1 - gm ) * ( 2 * phiL_d + dl * phiL_dd);
        hdd = gm * ( gm / (1 - gm) * (2 * phiL_d + dl * phiL_dd) + 2 * phig_d + dg * phig_dd);
        hdg = phig - phiL + dg * ( phig_d + phiL_d * gm / (1 - gm) ) + (-2 * dl * gm / (1 - gm) + dg * gm / (1 - gm) - dl) * phiL_d - (dl^2 - dl * dg) * phiL_dd * gm / (1 - gm);
    end;
end

% if desired, we include osmotic terms 
if A > 0
    f = f - A * log(1-gm); %diff(ln(1-gm))=-1/(1-gm)
    if nargout > 1
        gg = gg + A/(1-gm);
        if nargout > 2
            hgg = hgg + A/(1-gm)^2;
        end;
    end;
end

% if desired, we include surface tension
% actually, surface tension should depend on dl-dg!!!
% but we try with IAPWS temperature formula
if stprime > 0
    dfD = gm^(2/3) * stprime;
    f = f + dfD;
    if nargout > 1
        gg = gg + (2/3) * dfD/gm;
        if nargout > 2
            hgg = hgg - (2/9) * dfD/gm^2;
        end;
    end;
end

if nargout > 1
    g = [gg,gd];
    if nargout > 2
        h = [hgg, hdg; hdg, hdd];
    end;
end;

end

