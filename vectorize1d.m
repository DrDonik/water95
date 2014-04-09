function Y = vectorize1d(func, A)
% applies the scalar function func(a) to the array A
% parameters:
%   func     scalar function of the type y = func(a)
%   A        matrix with values for the argument of f
% results:
%   Y        matrix with result values Y = func(A)

NA = size(A,1);
MA = size(A,2);

Y = zeros(NA,MA);
for I = 1:NA
  for J = 1:MA
    Y(I,J) = feval(func, A(I,J));
  end
end
