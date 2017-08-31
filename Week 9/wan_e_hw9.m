clc, clear all, close all
%{
a2 = [2 -1; 0 1];
[v, d] = eig(a2);
eq = inv(a2) * [1; 0];

b2 = [2 -1; 1 2];
[v, d] = eig(b2);
eq = inv(b2) * [0; 1];

c2 = [-1 1; 0 -1];
[v, d] = eig(c2);
eq = inv(c2) * [1; 1];

d2 = [0 -3; 3 0];
[v, d] = eig(d2);
eq = inv(d2) * [1; 0];

e2 = [0 6; 0 3];
[v, d] = eig(e2);
v(:,2)./(min(v(:,2)));
eq = inv(e2) * [-1; 2];

f2 = [1 -3; -3 1];
[v, d] = eig(f2);
v./(min(v));
eq = inv(f2) * [0; -2];

g2 = [-2 1; 0 -2];
[v, d] = eig(g2);
v(:,2)./(min(v(:,2)));
eq = inv(g2) * [0; 1];
%}
%{
syms s
xs = inv([s -1; 2 s-3])*[s/(s-1); s/(s-1)];
pretty(xs)
%}

%%
A = [0 1; -2 -3]
B = [1;1]
x0 = [1;1]
syms t s

ut = exp(t)
Us = laplace(ut)
Xs = inv(s*eye(2) - A)*( x0 + B*Us )
pretty(simplify(Xs)')

pretty(s*eye(2)-A)
pretty(inv(s*eye(2) - A))

%%
A = [3 -4; 1 1]
B = [1;1]
x0 = [1;1]
syms t s

ut = exp(t)
Us = laplace(ut)
Xs = inv(s*eye(2) - A )*( x0 + B*Us )
xt = ilaplace(Xs)
pretty(simplify(xt))

% pretty(simplify(Xs)')
% pretty(s*eye(2)-A)
% pretty(inv(s*eye(2) - A))
