function [pi,vi,Ti,si,xi] = isentropic(p1, v1, v2, N, logFlag)
% returns values of p, v, T, s, x along an isentropic going from (p1,v1) to v2.
% parameters:
%   p1       start pressure
%   v1       start volume
%   v2       end volume
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
if (nargin == 3)
  N = 100;
end

if logFlag == 0
  vi = v1:(v2-v1)/(N-1):v2;
else
  dl = log(v2/v1)/(N-1);
  vi = exp(log(v1):dl:log(v2));    
end

T1 = temperature(p1, 1/v1);
s1 = entropy(1/v1, T1);

si = s1*ones(1,N);
pi = zeros(1,N);
Ti = zeros(1,N);
xi = zeros(1,N);

Tguess = 300;   % initial guess
for I=1:N
  rho = 1/vi(I);
  Ti(I) = temperatureRS(rho, s1, Tguess);  % use last value as guess
  Tguess = Ti(I);
  [pi(I), xi(I)] = pressure(rho, Ti(I));
end
