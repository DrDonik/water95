function [pi,vi,Ti,si,xi] = isobaric(p1, v1, v2, N, logFlag)
% returns values of p, v, T, s, x along an isobaric going from (p1,v1) to v2.
% parameters:
%   p1       start pressure
%   v1       start volume
%   v2       end volume
%   N        number of points (optional)
%   logFlag  if 1, volume steps are chosen for a log plot (optional)
% results:
%   pi       pressure values along the isothermal
%   vi       specific volume values along the isothermal
%   Ti       temperature values along the isothermal
%   si       specific entropy values along the isothermal
%   xi       dryness fraction values along the isothermal

if (nargin < 5)
  logFlag = 0;
end
if (nargin < 4)
  N = 100;
end

if logFlag == 0
  vi = v1:(v2-v1)/(N-1):v2;
else
  dl = log(v2/v1)/(N-1);
  vi = exp(log(v1):dl:log(v2));    
end
vi = addBoundaryPoints(vi, p1);
N = size(vi,2);      % may have changed

pi = p1*ones(1,N);
si = zeros(1,N);
Ti = zeros(1,N);
xi = zeros(1,N);

Tguess = 300;   % initial guess
for I=1:N
  rho = 1/vi(I);
  Ti(I) = temperature(pi(I), rho, Tguess);  % use last value as guess
  Tguess = Ti(I);
  [si(I), xi(I)] = entropy(rho, Ti(I));
end


%----------------------------------------------------------
function vNew = addBoundaryPoints(vOld, p1)
% if the isobaric crosses the phase boundary, the crossing
% points are included

TS = saturationTemperature(p1);
if isnan(TS)
  vNew = vOld;
  return;
end
[pS rhop rhopp] = saturationPressure(TS);
vp = 1/rhop;
vpp = 1/rhopp;

vNew = vOld;
if vOld(1) < vOld(end)        % vi ascending
  if vOld(1) < vp
    vNew = [vp vNew];
  end
  if vpp < vOld(end)
    vNew = [vpp vNew];
  end
  vNew = sort(vNew);
elseif vOld(1) > vOld(end)    % vi descending
  if vOld(end) < vp
    vNew = [vp vNew];
  end
  if vpp < vOld(1)
    vNew = [vpp vNew];
  end
  vNew = sort(vNew, 'descend');
end
