function [pi,vi,Ti,si,xi] = isothermal(p1, v1, v2, N, NP,logFlag)
% returns values of p, v, T, s, x along an isothermal going from (p1,v1) to v2.
% steps are with constant volume increment
% optionally additional steps with pressure increments can be
%   added at the start or end (wherever v is smaller)
%
% parameters:
%   p1       start pressure
%   v1       start volume
%   v2       end volume
%   N        number of points (optional)
%   NP       number of additional steps with pressure increment (optional)
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

if logFlag == 0
  vi = v1:(v2-v1)/(N-1):v2;
else
  dl = log(v2/v1)/(N-1);
  vi = exp(log(v1):dl:log(v2));    
end

T1 = temperature(p1, 1/v1);
Ti = T1*ones(1,N);
pi = zeros(1,N);
si = zeros(1,N);
xi = zeros(1,N);

if (v1 < v2) && (NP > 0)
  % pressure steps at the beginning
  p2 = pressure(1/vi(2), T1);
  [piP,viP,TiP,siP,xiP] = pressureSteps(p1, T1, p2, NP);
end

% volume steps
for I=1:N
  rho = 1/vi(I); 
  pi(I) = pressure(rho, T1);
  [si(I), xi(I)] = entropy(rho, T1);
end

if (v1 > v2) && (NP > 0)
  % pressure steps at the end
  p1 = pressure(1/vi(end-1), T1);
  p2 = pressure(1/vi(end), T1);
  [piP,viP,TiP,siP,xiP] = pressureSteps(p1, T1, p2, NP);
end

% splice everything together
if  (v1 < v2) && (NP > 0)
   pi = [piP pi(2:end)]; 
   vi = [viP vi(2:end)]; 
   Ti = [TiP Ti(2:end)]; 
   si = [siP si(2:end)]; 
   xi = [xiP xi(2:end)]; 
elseif (v1 > v2) && (NP > 0)
   pi = [pi(1:end-1) piP]; 
   vi = [vi(1:end-1) viP]; 
   Ti = [Ti(1:end-1) TiP]; 
   si = [si(1:end-1) siP]; 
   xi = [xi(1:end-1) xiP]; 
end

%----------------------------------------------------------
function [pi,vi,Ti,si,xi] = pressureSteps(p1, T1, p2, NP)
% returns values for NP pressure steps between (p1,T1) and (p2,T1)
% values are bounded by the saturation pressure

Tc = getCriticalValues();

if (T1 < Tc)
  pS = saturationPressure(T1)*(1+5*eps);
  p1 = max(p1, pS);    
  p2 = max(p2, pS);
end

pi = p1:(p2-p1)/(NP-1):p2;
Ti = T1*ones(1,NP);
vi = zeros(1,NP);
si = zeros(1,NP);
xi = zeros(1,NP);

for I=1:NP
  rho = density(pi(I), T1);
  vi(I) = 1/rho;
  [si(I), xi(I)] = entropy(rho, T1);
end
