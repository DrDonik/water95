function [eta rW] = efficiencyCR(T1, p1, p2)
% returns the efficiency eta and the work efficiency rW for a 
% Clausius-Rankine process given by its highest temperature and its pressures
% parameters:
%   T1      highest temperature of the CR process
%   p1      highest pressuere of the CR process
%   p2      lowest pressuere of the CR process
% results:
%   eta      thermodynamical efficiency
%   rW       work efficiency

[pi,vi,Ti,si,xi,hi] = clausiusRankineCornerPoints(T1, p1, p2);

eta = 1 + (hi(3) - hi(2))/(hi(1) - hi(4));
rW = 1 - (hi(4) - hi(3))/(hi(1) - hi(2));
