function dydt = diff_eq_2_var(t,y)
% ay''+by'+cy = g(t)
a = 1;
b = 2;
c = 3;
gt = sin(t);

% A,B matrices
A = [0, 1; -c/a, -b/a];
B = [0; 1/a];
dydt = A*y + B*gt;