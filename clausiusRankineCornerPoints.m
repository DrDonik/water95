function [pi,vi,Ti,si,xi,hi] = clausiusRankineCornerPoints(T1, p1, p2)
% returns corner points of a Clausius-Rankine cycle defined by p1, p2 and T1.
% parameters:
%   p1       highest pressure of the CR process
%   p2       lowest pressure of the CR process
%   T1       highest temperature of the CR process
% results:
%   pi       pressure values at the four corner points
%   vi       specific volume values at the four corner points
%   Ti       temperature values at the four corner points
%   si       specific entropy values at the four corner points
%   xi       dryness fraction values at the four corner points
%   hi       specific enthalpy values at the four corner points

% point 1
rho1 = density(p1, T1);
v1 = 1/rho1;
s1 = entropy(rho1, T1);
x1 = 1;
h1 = enthalpy(rho1, T1);

% point 2
s2 = s1;
T2 = temperaturePS(p2, s2);
x2 = drynessFractionTS(T2, s2); 
if (x2 > 0) && (x2 < 1)    % on the saturation curve
  rho2 = densityTX(T2, x2);
else
  rho2 = density(p2, T2);   
  x2 = max(0, min(1, x2));
end
v2 = 1/rho2;
h2 = enthalpy(rho2, T2);

% point 3
p3 = p2;
T3 = saturationTemperature(p3);
[pS, rho3] = saturationPressure(T3);
if (abs(pS - p3)/p3 > 1e-6)
  warning('water95:inconsistentState', ...
        'inconsistent results in temperature T3');
end
v3 = 1/rho3;
s3 = entropy(rho3, T3);
x3 = 0;
h3 = enthalpy(rho3, T3);

% point 4
p4 = p1;
s4 = s3;
T4 = temperaturePS(p4, s4);
rho4 = density(p4, T4);
v4 = 1/rho4;
x4 = 0;
h4 = enthalpy(rho4, T4);

% collect everything
pi = [p1 p2 p3 p4];
vi = [v1 v2 v3 v4];
Ti = [T1 T2 T3 T4];
si = [s1 s2 s3 s4];
xi = [x1 x2 x3 x4];
hi = [h1 h2 h3 h4];
