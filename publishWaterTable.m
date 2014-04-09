function publishWaterTable(p, T, v, h, s, outfile, title)
% creates a HTML document displaying the given values in table form
% parameters:
%   p        pressure values
%   T        temperature values
%   v        specific volume values
%   h        specific enthalpy values
%   s        specific entropy values
%   outfile  name of the HTML file (optional)
%   title    title of HTML file (optional)
% results:
%   none

if nargin == 5
  outfile = 'tableW.html';
  title = 'Water Table';
end

% convert to display units
T = T - celsiusToKelvin(0);   % in °C
p = p*1e-5;       % in bar
h = h*1e-3;       % in kJ/kg
s = s*1e-3;       % in kJ/(kg K)

fid = startFile(outfile, title);

% sort p in ascending order
[p, idx] = sort(p);
T = T(idx);
v = v(idx);
h = h(idx);
s = s(idx);

% find indices where p changes
idxp = find(diff(p)~=0) + 1;
idxp = [1, idxp, size(p,2)+1];

% create table entries for equal p values
% with two columns of entries
for I=1:(size(idxp,2) - 1)
  idxMin = idxp(I);
  idxMax = idxp(I+1) - 1;
  nVal = idxMax - idxMin + 1;
  nRow = ceil(nVal/2);
  if rem(nVal, 2) == 1  
    lastRow = nRow - 1;
  else
    lastRow = nRow;
  end
  
  for J=1:lastRow
    fprintf(fid, '<tr>\n');
    if J == 1
      fprintf(fid, '  <td>%6.1f</td>', p(idxMin));
    else
       fprintf(fid, '  <td> </td>'); 
    end
    idxLeft = idxMin + J - 1;
    idxRight = idxLeft + nRow;
    fprintf(fid, '  <td>%6.0f</td>  <td>%10.7f</td> <td>%10.3f</td> <td>%10.4f</td>', ...
           T(idxLeft), v(idxLeft), h(idxLeft), s(idxLeft));
    fprintf(fid, '  <td>%6.0f</td>  <td>%10.7f</td> <td>%10.3f</td> <td>%10.4f</td>', ...
           T(idxRight), v(idxRight), h(idxRight), s(idxRight));
    fprintf(fid, '\n</tr>\n');
  end

  if rem(nVal, 2) == 1     % one value remains
    fprintf(fid, '<tr>\n');
    fprintf(fid, '      '); 
    idxLeft = idxMin + nRow - 1;
    fprintf(fid, '<td> </td>');
    fprintf(fid, '  <td>%6.0f</td>  <td>%10.7f</td> <td>%10.3f</td> <td>%10.4f</td>', ...
           T(idxLeft), v(idxLeft), h(idxLeft), s(idxLeft));
    fprintf(fid, '<td> </td><td> </td><td> </td><td> </td>');
    fprintf(fid, '</tr>\n');
  end
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
fprintf(fid,'    <th>p</th> <th>T</th> <th>v</th> <th>h</th> <th>s</th>');
fprintf(fid,'    <th>T</th> <th>v</th> <th>h</th> <th>s</th>\n');
fprintf(fid,'  </tr>\n');

fprintf(fid,'  <tr>\n');
fprintf(fid,'    <th>bar</th> <th>°C</th> <th>m<sup>3</sup>/kg</th> <th>kJ/kg</th> <th>kJ/(kg K)</th>\n');
fprintf(fid,'     <th>°C</th> <th>m<sup>3</sup>/kg</th> <th>kJ/kg</th> <th>kJ/(kg K)</th>\n');
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
