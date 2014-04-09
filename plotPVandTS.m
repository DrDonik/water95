function plotPVandTS(pi, vi, Ti, si, N, pMax)
% plots a p-v and a T-s diagram for the given data
%
% create test values with
%   [pi,vi,Ti,si,xi, N] = clausiusRankine(773, 60e5, 0.1e5, 1);
%
% parameters:
%   pi     pressure values to plot
%   vi     specific volume values to plot
%   Ti     temperature values to plot
%   si     specific entropy values to plot
%   N      vector with numbers of points along the processes (optional)
%   pMax   maximal pressure in p-V diagram (optional)
% results:
%   none

if (nargin < 6)
  pMax = 250e5;
end

if (nargin < 5)
  N = length(pi);
end


% get edge points
corners = cumsum(N-1) + 1;    % index of corner points
corners = [1 corners];

pC = size(corners, 2);
vC = size(corners, 2);
TC = size(corners, 2);
sC = size(corners, 2);
for I = 1:size(corners, 2)
  idx = corners(I);
  pC(I) = pi(idx);
  vC(I) = vi(idx);
  TC(I) = Ti(idx);
  sC(I) = si(idx);
end

% add saturation curve
TS = [0.01:10:367.01, 367.945:0.1:373.946];
TS = celsiusToKelvin(TS);
nS = size(TS, 2);
pS = zeros(nS, 1);
vp = zeros(nS, 1);
vpp = zeros(nS, 1);
sp = zeros(nS, 1);
spp = zeros(nS, 1);

for I=1:nS
  [pS(I), rhop, rhopp] = saturationPressure(TS(I));
  vp(I) = 1/rhop;
  vpp(I) = 1/rhopp;
  sp(I) = entropy(rhop, TS(I));
  spp(I) = entropy(rhopp, TS(I));
end

set(0,'defaultfigurecolor','white');
fig1 = figure('Position',[0 0 750 360]);
subplot(1,2,1);
semilogx(vi, pi*1e-5, 'b-', vC, pC*1e-5, 'r*', ...
      vp, pS*1e-5, 'k-.', vpp, pS*1e-5, 'k-.');
xlabel('v [m^3/kg]', 'FontSize', 14);
ylabel('p [bar]', 'FontSize', 14);
axis([1e-4 1e3 0 pMax*1e-5]);

subplot(1,2,2)
plot(si*1e-3, Ti, 'b-', sC*1e-3, TC, 'r*', ...
    sp*1e-3, TS, 'k-.', spp*1e-3, TS, 'k-.');
xlabel('s [kJ/(kg K)]', 'FontSize', 14);
ylabel('T [K]', 'FontSize', 14);
axis([-1 10 250 800]);
