function plotPhaseDiagram()
% plots the phase boundaries in a p-T diagram
% parameters:
%   none
% results:
%   none

Tc = getCriticalValues();
Tt = getTriplePointTemperature();

T = 200.16:700;

pw = vectorize1d(@saturationPressure,T);
ps = auxSublimationPressure(T);
pm1 = auxMeltingPressureI(T);
pm3 = auxMeltingPressureIII(T);
pm5 = auxMeltingPressureV(T);
pm6 = auxMeltingPressureVI(T);
pm7 = auxMeltingPressureVII(T);

set(0,'defaultfigurecolor','white');

semilogy(T, ps, 'k', T, pw, 'k', T, pm1, 'k', T, pm3, 'k', T, pm5, 'k',...
         T, pm6, 'k', T, pm7, 'k');
title('Phase Diagram of Water', 'FontSize', 16);
xlabel('T [K]', 'FontSize', 14);
ylabel('p [Pa]', 'FontSize', 14);
hold on;

plot(Tt, saturationPressure(Tt), 'k*');
plot(Tc, saturationPressure(Tc), 'k*');
text(Tt, 60, 'Tr', 'FontSize', 12)
text(Tc, 3e6, 'C', 'FontSize', 12)
hold off;
