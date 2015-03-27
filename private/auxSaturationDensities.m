function [rhop, rhopp] = auxSaturationDensities(T)
% computes approximate values of the saturation densities
% (rhop of water, rhopp of steam) according to [1, p.398f]
% returns [0 0] for T > Tc
%   and   [-1 0] for T < Tt

Tc = 647.096; 
Tt = 273.16;
margin = 1 + 5*eps;
if T > Tc*margin
  rhop = 0;
  rhopp = 0;
  return;
%elseif T < Tt/margin
%  rhop = -1;
%  rhopp = 0;
%  return;
end

rhoc = 322;

b1 = 1.99274064;
b2 = 1.09965342;
b3 = -0.510839303;
b4 = -1.75493479;
b5 = -45.5170352;
b6 = -6.74694450e5;

th = (1 - T/Tc).^(1/3);
t1 = 1 + b1*th + b2*th.^2 + b3*th.^5 + b4*th.^16 + ...
      b5*th.^43 + b6*th.^110;
rhop = rhoc*t1;

c1 = -2.03150240;
c2 = -2.68302940;
c3 = -5.38626492;
c4 = -17.2991605;
c5 = -44.7586581;
c6 = -63.9201063;

th = sqrt(th);
t2 = c1*th.^2 + c2*th.^4 + c3*th.^8 + c4*th.^18 + ...
      c5*th.^37 + c6*th.^71;
rhopp = rhoc*exp(t2);
