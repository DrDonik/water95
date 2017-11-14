function Y = vectorize2d(func, A, B)
% applies the scalar function func(a,b) to the arrays A, B
% The following cases are possible:
%   1. A and B are matrices of the same size
%   2. B is a matrix, A a scalar
%   3. A is a matrix, B a scalar
% In all other cases the function prints a warning and returns
%   an empty matrix.
% parameters:
%   func     scalar function of the type y = func(a,b)
%   A        matrix with values for the first argument of f
%   B        matrix with values for the second argument of f
% results:
%   Y        matrix with result values Y = func(A, B)

NA = size(A,1);
MA = size(A,2);
NB = size(B,1);
MB = size(B,2);

if (NA == NB) && (MA == MB)   % case 1
  Y = zeros(NA,MA);
  for I = 1:NA
    for J = 1:MA
      Y(I,J) = feval(func, A(I,J), B(I,J));
    end
  end
elseif (NA == 1) && (MA == 1)   % case 2
  Y = zeros(NB,MB);
  for I = 1:NB
    for J = 1:MB
      Y(I,J) = feval(func, A, B(I,J));
    end
  end
elseif (NB == 1) && (MB == 1)   % case 3
  Y = zeros(NA,MA);
  for I = 1:NA
    for J = 1:MA
      Y(I,J) = feval(func, A(I,J), B);
    end
  end
else
  warning('A and B have different dimensions');
  Y = [];
end
