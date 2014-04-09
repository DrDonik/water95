function x = drynessFractionTS(T, s)
% returns the dryness fraction x as function of T and s.
% If the given state doesn't lie in the wet steam region, the value
% returned is > 1 (for pure gas) or < 0 (for pure water).
% parameters:
%   T      temperature
%   s      specific entropy
% results:
%   x      dryness fraction

Tc = getCriticalValues();
Tt = getTriplePointTemperature();

if (T < Tt) || (T > Tc)
  x = NaN;
else
  [pS, rhop, rhopp] = saturationPressure(T);
  sp = entropy(rhop, T);
  spp = entropy(rhopp, T);
  x = (s - sp)/(spp - sp);
end
