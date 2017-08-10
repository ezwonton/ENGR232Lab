function [xPrimes] = NumericSolution(t, xI)
%{
y'' + y' - 6y = exp(-t) * cos(t)
y(0) = 1, y'(0) = 1

x'(t) = Ax(t) + Bf(t)
x1 = y, x2 = y'
x1' = 0 * x1 + 1 * x2
x2' + 1 * x2 + 6 * x1 = exp(-t) * cos(t)
x2' = exp(-t) * cos(t) + 6 * x1 - 1 * x2
[x1'; x2'] = [0 1; 6 -1] * [x1; x2] + [0; exp(-t)*cos(t)]

%}

xPrimes = [0 1; 6 -1] * xI + [0; exp(-t)*cos(t)];

end

