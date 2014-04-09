function publishSaturationTable(T, p, vp, vpp, hp, hpp, sp, spp)
% creates a HTML document displaying the given values in table form
% parameters:
%   T       temperature values
%   p       pressure values
%   vp      specific volume values for x = 0
%   vpp     specific volume values for x = 1
%   hp      specific enthalpy values for x = 0
%   hpp     specific enthalpy values for x = 1
%   sp      specific entropy values for x = 0
%   spp     specific entropy values for x = 1
% results:
%   none

% convert to display units
T = T - celsiusToKelvin(0.0);   % in °C
p = p*1e-5;       % in bar
hp = hp*1e-3;       % in kJ/kg
hpp = hpp*1e-3;       % in kJ/kg
sp = sp*1e-3;       % in kJ/(kg K)
spp = spp*1e-3;       % in kJ/(kg K)

fid = startFile('tableS.html', 'Wet Steam Table');

% sort p in ascending order
[p, idx] = sort(p);
T = T(idx);
vp = vp(idx);
vpp = vpp(idx);
hp = hp(idx);
hpp = hpp(idx);
sp = sp(idx);
spp = spp(idx);

for I=1:size(T,2)
  fprintf(fid, '<tr>\n');
  fprintf(fid, '  <td>%6.2f</td>', T(I));
  fprintf(fid, '  <td>%10.4f</td>  <td>%10.7f</td> <td>%10.4f</td> <td>%10.2f</td>', ...
           p(I), vp(I), vpp(I), hp(I));
  fprintf(fid, '  <td>%10.2f</td> <td>%10.4f</td> <td>%10.4f</td>', ...
           hpp(I), sp(I), spp(I));
  fprintf(fid, '\n</tr>\n');
end

endFile(fid);


%------------------------------------------------------------
function fid = startFile(name, title)
%
fid = fopen(name, 'w');

fprintf(fid,'<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">\n');
fprintf(fid,'<html>\n');
fprintf(fid,'  <head>\n');
fprintf(fid,'    <meta content="text/html; charset=utf-8" http-equiv="content-type">\n');
fprintf(fid,'    <title>%s</title>\n', title);
fprintf(fid,'  </head>\n');

fprintf(fid,'  <body>\n');
fprintf(fid,'    <h1>%s</h1>\n', title);
fprintf(fid,'    <table border="1">\n');

fprintf(fid,'  <tr>\n');
fprintf(fid,'    <th>T</th> <th>p</th> <th>v''</th> <th>v''''</th> <th>h''</th>');
fprintf(fid,'    <th>h''''</th> <th>s''</th> <th>s''''</th>\n');
fprintf(fid,'  </tr>\n');

fprintf(fid,'  <tr>\n');
fprintf(fid,'    <th>°C</th> <th>bar</th> <th>m<sup>3</sup>/kg</th> <th>m<sup>3</sup>/kg</th> <th>kJ/kg</th>\n');
fprintf(fid,'      <th>kJ/kg</th> <th>kJ/(kg K)</th> <th>kJ/(kg K)</th>\n');
fprintf(fid,'  </tr>\n');

return;

%------------------------------------------------------------
function endFile(fid)
%
fprintf(fid,'    </table>\n');
fprintf(fid,'  </body>\n');
fprintf(fid,'</html>\n');

fclose(fid);
return;
