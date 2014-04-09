function [pi,vi,Ti,si,xi] = isentropicTPP(T1, p1, p2, N, logFlag)
% returns values of p, v, T, s, x along an isentropic going from (T1,p1) to p2.
% (T1,p1) mustn't be on the saturation curve!
% parameters:
%   p1       start pressure
%   v1       start volume
%   p2       end pressure
%   N        number of points (optional)
%   logFlag  if 1, volume steps are chosen for a log plot (optional)
% results:
%   pi       pressure values along the isentropic
%   vi       specific volume values along the isentropic
%   Ti       temperature values along the isentropic
%   si       specific entropy values along the isentropic
%   xi       dryness fraction values along the isentropic

if (nargin < 5)
  logFlag = 0;
end
if (nargin < 4)
  N = 100;
end

rho1 = density(p1, T1);
v1 = 1/rho1;
s1 = entropy(rho1, T1);
s2 = s1;
T2 = temperaturePS(p2, s2);
x2 = drynessFractionTS(T2, s2); 

if (x2 > 0) && (x2 < 1)    % on the saturation curve
  v2 = 1/densityTX(T2, x2);
else
  v2 = 1/density(p2, T2);    
end

[pi,vi,Ti,si,xi] = isentropic(p1, v1, v2, N, logFlag);
