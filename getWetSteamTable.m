function [T, p, vp, vpp, hp, hpp, sp, spp] = getWetSteamTable()
% returns a wet steam table with a range of useful values
% parameters:
%   none
% results:
%   T       temperature values
%   p       pressure values
%   vp      specific volume values for x = 0
%   vpp     specific volume values for x = 1
%   hp      specific enthalpy values for x = 0
%   hpp     specific enthalpy values for x = 1
%   sp      specific entropy values for x = 0
%   spp     specific entropy values for x = 1

T = ...
[0.01,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,...
27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,...
52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,...
77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,...
102,104,106,108,110,112,114,116,118,120,125,130,135,140,145,150,160,170,...
180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,...
360,370,373,373.94];
T = celsiusToKelvin(T);

p = zeros(size(T));
vp = zeros(size(T));
hp = zeros(size(T));
sp = zeros(size(T));
vpp = zeros(size(T));
hpp = zeros(size(T));
spp = zeros(size(T));

for I=1:size(T,2)
  [p(I), rhop, rhopp] = saturationPressure(T(I));
  vp(I) = 1/rhop;
  hp(I) = enthalpy(rhop, T(I));
  sp(I) = entropy(rhop, T(I));
  vpp(I) = 1/rhopp;
  hpp(I) = enthalpy(rhopp, T(I));
  spp(I) = entropy(rhopp, T(I));
end
