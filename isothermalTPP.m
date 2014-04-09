function [pi,vi,Ti,si,xi] = isothermalTPP(T1, p1, p2, N, NP, logFlag)
% returns values of p, v, T, s, x along an isothermal going from (T1,p1) to p2.
% parameters:
%    T1      start temperature
%    p1      start pressure
%    p2      end pressure
%    N       number of points (optional)
%    NP      number of additional steps with pressure increment (optional)
%   logFlag  if 1, volume steps are chosen for a log plot (optional)
% results:
%   pi       pressure values along the isothermal
%   vi       specific volume values along the isothermal
%   Ti       temperature values along the isothermal
%   si       specific entropy values along the isothermal
%   xi       dryness fraction values along the isothermal

if (nargin < 6)
  logFlag = 0;
end
if (nargin < 5)
  NP = 0;
end
if (nargin < 4)
  N = 100;
end

v1 = 1/density(p1, T1);
v2 = 1/density(p2, T1);
[pi,vi,Ti,si,xi] = isothermal(p1, v1, v2, N, NP,logFlag);
