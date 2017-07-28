%% Eric Wan - ezw23@drexel.edu - Lab 5

%% Part a
%{
eq: y'' + 6y' + 9y = 0
y(0) = -2
y'(0) = 3
aux eq: x^2 + 6x + 9 = 0
solution: parabola, stable
%}
aux = [1 6 9]; % set up auxiliary coefficient
r = roots(aux) % solving for roots

%% Part b
%{
x'(t) = Ax(t) + Bf(t)
x1 = y, x2 = y'
x1' = 0 * x1 + 1 * x2
x2' + 6 * x2 + 9 * x1 = 0
x2' = -9 * x1 - 6 * x2
[x1'; x2'] = [0 1; -9 -6] * [x1; x2] + [0; 0]
%}

%% Part c
%{
eq. points when x' = 0
x1' = 0
x2' = 0
[x1'; x2'] = [0 1; -9 -6] * [x1; x2] + [0; 0]
%}
A = [0 1; -9 -6]; % setting matrix coefficients
B = [0; 0]; % setting x' = 0
eq = A^-1 * B % solving for equilibrium points

%% Part d - Numeric Solution
type NumericSolution.m % printing function
tSpan = 0:0.01:4; % span of t
xI = [-2; 3]; % init conditions of x_dot (x')
[tode, yode] = ode45(@NumericSolution, tSpan, xI); % ode45
x1 = yode(:,1); % setting x1
x2 = yode(:,2); % setting x2

% plotting x1 vs t
subplot(2, 2, 1)
plot(tode, x1)
title('x1 vs t')
xlabel('t')
ylabel('x1')
grid on
hold on

% plotting x2 vs t
subplot(2, 2, 3)
plot(tode, x2)
title('x2 vs t')
xlabel('t')
ylabel('x2')
grid on
hold on

% plotting x2 vs x1
subplot(2, 2, [2 4])
plot(x1, x2)
title('x2 vs x1')
xlabel('x1')
ylabel('x2')
grid on
hold on
plot(x1(1,1),x2(1,1),'*')
plot(x1(401,1),x2(401,1),'o')
legend('x2 vs x1', 'init condition', 'equil point')

%% Part e - Analytic Solution
syms y
y = dsolve('D2y + 6*Dy + 9*y = 0, y(0) == -2, Dy(0) == 3'); % solve 2nd ODE
yprime = diff(y,1); % y'
yFunc = matlabFunction(y); % convert y from symbolic to function
dyFunc = matlabFunction(yprime); % convert y' from symbolic to function
%{
t=0:0.1:4 %new time span
yfunc=-2*exp(-3*t) - 3*exp(-3*t).*t %the y function
yprimefunc=3*exp(-3*t) + 9*exp(-3*t).*t; %the y prime function
^^ for older versions of matlab! ^^
%}

t = 0:0.01:4; % t interval
subplot(2, 2, 1)
plot(t, yFunc(t),'o') % y vs t
legend('Num', 'Anal')
subplot(2, 2, 3)
plot(t, dyFunc(t),'o')
legend('Num', 'Anal')

%% Part f
%{
Both the numeric and analytical solutions are the same
%}