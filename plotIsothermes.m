function plotIsothermes()
% plots a semilog p-v-diagram with isothermes for several (fixed) Ts
% parameters:
%   none
% results:
%   none

T = celsiusToKelvin([100 200 300 350 400 500]);
N = 100;
NP = 30;
p1 = 250e5;
p2 = 0.25e5;

n = size(T,2);
colors = [0 0 1; 0.2 0 0.8; 0.4 0 0.6; ...
          0.6 0 0.4; 0.8 0 0.2; 1 0 0];

set(0,'defaultfigurecolor','white');
fig1 = figure('Position',[0 0 450 400]);
axes('Parent',fig1,'XScale','log','XMinorTick','on');
hold all;

for I=1:n
  [pi,vi] = isothermalTPP(T(I), p1, p2, N, NP, 1);
  semilogx(vi, 1e-5*pi, 'Color', colors(I,:));
end

axis([1e-3 10 0 250]);
xlabel('v [m^3/kg)]','FontSize',12);
ylabel('p [bar]','FontSize',12);
legend('100 °C', '200 °C', '300 °C', '350 °C', '400 °C', '500 °C', ...
'Location', 'Best');

% add saturation curve
TS = [0.01:10:367.01, 367.945:0.1:373.946];
TS = celsiusToKelvin(TS);
nS = size(TS, 2);
pS = zeros(nS, 1);
rhopS = zeros(nS, 1);
rhoppS = zeros(nS, 1);

for I=1:nS
  [pS(I), rhopS(I), rhoppS(I)] = saturationPressure(TS(I));
end
pS = 1e-5*pS;
semilogx(1./rhopS, pS, 'k-', 1./rhoppS, pS, 'k-')

hold off; 
