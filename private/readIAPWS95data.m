function coeffs = readIAPWS95data()
% returns all constants and coefficients needed for the 
% IAPWS95 formulation, packed into a cell array

fid = fopen('iapws95.dat', 'r');

R       = getNextData(fid, 1);
Tc      = getNextData(fid, 1);
rhoc    = getNextData(fid, 1);
n0      = getNextData(fid, 8);
gamma0  = getNextData(fid, 8);
n       = getNextData(fid, 56);
c       = getNextData(fid, 51);
d       = getNextData(fid, 54);
t       = getNextData(fid, 54);
alpha   = getNextData(fid, 3);
beta    = getNextData(fid, 5);
gamma   = getNextData(fid, 3);
epsilon = getNextData(fid, 3);
a       = getNextData(fid, 2);
b       = getNextData(fid, 2);
A       = getNextData(fid, 2);
B       = getNextData(fid, 2);
C       = getNextData(fid, 2);
D       = getNextData(fid, 2);
         
fclose(fid);

coeffs = {R,Tc,rhoc,n0,gamma0,n,c,d,t,...
          alpha,beta,gamma,epsilon,a,b,A,B,C,D};

%--------------------------------------------------------
function y = getNextData(fid, n)
% returns next n numbers as vector y
yc = textscan(fid, '%f', n, 'delimiter', ',', 'commentStyle', '%');
y = yc{1,1};
