function [w, x] = soundVelocity(rho, T)
% returns sound velocity and dryness fraction as functions of rho and T
% parameters:
%   rho      density
%   T        temperature
% results:
%   w        velocity of sound waves
%   x        dryness fraction

[flag, x, rhop, rhopp, pS] = findRegion(rho, T);

switch flag
  case {1, 2, 3, 4}          % supercritical, below Tt, water, steam
    w = soundVelocityRaw(rho, T);
  case 5                     % on saturation curve
    if x < 5*eps  % allow for a small overlap
      w = soundVelocityRaw(rhop, T);
    elseif(x > 1 - 5*eps)
      w = soundVelocityRaw(rhopp, T);
    else
      % this is a complicated question
      % simple answer: 
      %   approximately = wpp
      %   cf. R. E. Collingham, J. C. Firey:
      %     Velocity of Sound Measurements in Wet Steam
      %     Ind. Eng. Chem. Process Des. Dev., 1963, 2 (3), pp 197–202
      % better answer: very complicated, depending e.g. on frequency
      %   cf. Jinliang Xu, Tingkuan Chen:
      %     Acoustic wave prediction in flowing steam–water two-phase mixture
      %     Int. J. Heat Mass Transfer, 43 (7), 2000, 1079-1088.
      % better give the honest answer:
      w = NaN;
    end
end
