function [xPrimes] = NumericSolutionFinal(tSpan, IC)
a = 1;
b = -3;
c = 19;
ut = exp(-5*tSpan) * sin(tSpan);

A = [0 1; -c/a -b/a];
B = [0; 1/a];
xPrimes = A * IC + B * ut;
end