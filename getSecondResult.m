function y = getSecondResult(func, x1, x2)
% returns the second result of a function with one or two arguments
% parameters:
%   func     function of the form [a, b] = func(x1, x2)
%   x1       first argument of func
%   x2       second argument of func (optional)
% results:
%   y        second result of func

if nargin == 2
  [y1 y] = feval(func, x1);
else
  [y1 y] = feval(func, x1, x2);
end

