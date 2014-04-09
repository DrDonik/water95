function [pi,vi,Ti,si,xi, N] = clausiusRankine(T1, p1, p2, logFlag, N)
% returns points along a Clausius-Rankine cycle defined by p1, p2 and T1.
% parameters:
%   T1       highest temperature of the CR process
%   p1       highest pressure of the CR process
%   p2       lowest pressure of the CR process
%   logFlag  if 1, volume steps are chosen for a log plot (optional)
%   N        vector with numbers of points along the processes (optional)
% results:
%   pi       pressure values along the CR cycle
%   vi       specific volume values along the CR cycle
%   Ti       temperature values along the CR cycle
%   si       specific entropy values along the CR cycle
%   xi       dryness fraction values along the CR cycle
%   N        numbers of points along the processes (may have been changed
%              due to the addition of points on the phase boundaries

if (nargin < 5)
  N = [100 100 100 100];
end
if (nargin < 4)
  logFlag = 0;
end

[pi1,vi1,Ti1,si1,xi1] = isentropicTPP(T1, p1, p2, N(1), logFlag);
N(1) = size(pi1, 2);

v2 = vi1(end);
T2 = Ti1(end);
[pS, rhop] = saturationPressure(T2);
v3 = 1/rhop;
[pi2,vi2,Ti2,si2,xi2] = isobaric(p2, v2, v3, N(2), logFlag);
N(2) = size(pi2, 2);

% can't use isentropicTPP on the saturation curve!
s3 = si2(end);
T4 = temperaturePS(p1, s3);
v4 = 1/density(p1, T4);
[pi3,vi3,Ti3,si3,xi3] = isentropic(p2, v3, v4, N(3), logFlag);
N(3) = size(pi3, 2);

v4 = vi3(end);
v1 = vi1(1);
[pi4,vi4,Ti4,si4,xi4] = isobaric(p1, v4, v1, N(4), logFlag);
N(4) = size(pi4, 2);

pi = [pi1(1:end-1) pi2(1:end-1) pi3(1:end-1) pi4];
vi = [vi1(1:end-1) vi2(1:end-1) vi3(1:end-1) vi4];
Ti = [Ti1(1:end-1) Ti2(1:end-1) Ti3(1:end-1) Ti4];
si = [si1(1:end-1) si2(1:end-1) si3(1:end-1) si4];
xi = [xi1(1:end-1) xi2(1:end-1) xi3(1:end-1) xi4];
