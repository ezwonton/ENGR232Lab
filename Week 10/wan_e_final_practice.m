%% Eric Wan - ezw23@drexel.edu - Final Practice
clear all
close all
clc
format compact

%{
10y'' + by' + 250y = u(t) ; y(0) = 0, y'(0) = 0
Laplace Transformations:
a[ s^2Y(s) - sy(0) - y'(0) ] + b[ sY(s) - y(0) ] + c[ Y(s) ] = U(s)
10[ s^2Y(s) - sy(0) - y'(0) ] + b[ sY(s) - y(0) ] + 250[ Y(s) ] = U(s)
10[ s^2Y(s) - s*0 - 0 ] + b[ sY(s) - 0 ] + 250[ Y(s) ] = U(s)
[10s^2Y(s)] + [bsY(s)] + [250Y(s)] = U(s)
Y(s)[10s^2 + bs + 250] = U(s)
Y(s)= U(s)/[10s^2 + bs + 250] 

x'(t) = Ax(t) + Bf(t)
x1 = y, x2 = y'
x1' = 0 * x1 + 1 * x2
10 * x2' + b * x2 + 250 * x1 = u(t)
10 * x2' = u(t) - b * x2 - 250 * x1
x2' = u(t) - 250/10 * x1 - b/10 * x2
[x1'; x2'] = [0 1; -250 -b/10] * [x1; x2] + [0;1] * u(t)
%}
%% ODE45
a = 10; % a coefficient
c = 250; % c coefficient
b = sqrt(4*a*c) % b coefficient
A = [0 1; -c/a -b/a]; % A matrix
B = [0; 1/a]; % B matrix
aux = [10 b 250]; % coefficient matrix
r = roots(aux) % finding roots
IC = [0; 0]; % init conditions
EP = inv(A) * -B; % equil. pts
tSpan = 0:0.1:10; % span of T

[tode, yode] = ode45(@NumericSolution, tSpan, IC); % ode45
x1 = yode(:,1); % setting x1
x2 = yode(:,2); % setting x2

figure(1);
% plotting x = y(t) vs t
plot(tode, x1,'r.-');
title('y(t) vs t');
xlabel('t');
ylabel('y(t)');
grid on;
hold on;
%% DSOLVE
syms y
bhalf = b/2 % new b
aux = [10 bhalf 250]; % coefficient matrix
r = roots(aux) % finding roots

% 10y'' + by' + 250y = u(t) ; y(0) = 0, y'(0) = 0
y = dsolve('10*D2y + 50*Dy + 250*y = 1, y(0) == 0, Dy(0) == 0'); % solve 2nd ODE
yprime = diff(y,1); % y'
yFunc = matlabFunction(y); % convert y from symbolic to function
dyFunc = matlabFunction(yprime); % convert y' from symbolic to function

% plotting x = y(t) vs t
plot(tSpan, yFunc(tSpan),'b.-'); % y vs t


%% LAPLACE & ILAPLACE (matlabFunction)
btwo = 2*b % new b
A = [0 1; -c/a -btwo/a]; % A matrix
aux = [10 btwo 250]; % coefficient matrix
r = roots(aux) % finding roots

syms t s
Us = 1/s; % U(s)
Xs = inv(s * eye(2) - A) * IC + inv(s * eye(2) - A) * B * Us; % X(s) matrix
xt = ilaplace(Xs);
ut = ilaplace(Us); % u(t)
X1s = Xs(1,1); % X1(s) equation from Xs matrix calcuations
x1t = ilaplace(X1s); % x1(t) equation using ilaplace
y = matlabFunction(x1t); % using matlabFunction for equation

plot(tSpan,y(tSpan),'m.-');
hold on
plot(IC(1), IC(2), '*', EP(1), EP(2), 'o');
legend('ODE45','DSOLVE(matlabFunction)','LAPLACE & iLAPLACE','Init Conditions','Equil Pt.');


%% Discussion 
%{
Damping

Critically Damped - both roots negative & equal, @ b = 100
Overdamped - both roots negative but unequal, @ b = 200
Underdamped - complex conjugate w/ negative reals, @ b = 50

Underdamped case overshoots
Critically damped rises fastest w/out overshooting
Under and Critically damped do not overshoot
%}

%{
Steady State

Equil. Pts. - Where y'' & y = 0
10y'' + by' + 250y = u(t)
0 + 0 + 250y = 1
y = 1/250 = 4 * 10^-3
%}

%% Function
function [xPrimes] = NumericSolution(tSpan, IC)
a = 10;
c = 250;
b = sqrt(4*a*c);
ut = 1;
A = [0 1; -c/a -b/a];
B = [0; 1/a];
xPrimes = A * IC + B * ut;
end


