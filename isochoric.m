function [pi,vi,Ti,si,xi] = isochoric(p1, v1, p2, N)
% returns values of p, v, T, s, x along an isochoric going from (p1,v1) to p2.
% parameters:
%    p1   start pressure [Pa]
%    v1   start volume [m^3]
%    p2   end pressure [Pa]
%    N    number of points (optional)

if (nargin == 3)
  N = 100;
end

vi = v1*ones(1,N);
pi = p1:(p2-p1)/(N-1):p2;

rho = 1/v1;
si = zeros(1,N);
Ti = zeros(1,N);
xi = zeros(1,N);

Tguess = 300;   % initial guess
for I=1:N
  Ti(I) = temperature(pi(I), rho, Tguess);  % use last value as guess
  Tguess = Ti(I);
  [si(I), xi(I)] = entropy(rho, Ti(I));
end
