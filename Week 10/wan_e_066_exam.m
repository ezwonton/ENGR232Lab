%% Eric Wan - ezw23@drexel.edu - MATLAB Final
clear all, close all, clc, format compact
%{
y'' - 3y' + 19y = u(t) ; y(0) = 3, y'(0) = 0

solving for [x1'; x2']:
x1 = y, x2 = y'
x1' = 0 * x1 + 1 * x2
1 * x2' + -3 * x2 + 19 * x1 = u(t)
x2' = u(t) - 19 * x1 + 3 * x2
%}

%% Part A - Numeric Solution
type NumericSolutionFinal
IC = [3; 0]; % init conditions
tSpan = 0:0.1:5; % time span
a = 1; % a coefficient
b = -3; % b coefficient
c = 19; % c coefficient
A = [0 1; -c/a -b/a]; % A matrix
B = [0; 1/a]; % B matrix
EP = inv(A) * -B; % equil. pts

[tode, yode] = ode45(@NumericSolutionFinal, tSpan, IC); % ode45
x1ode = yode(:,1); % setting x1 (y(t))
x2ode = yode(:,2); % setting x2 (dy(t))

%% Part B - Laplace & iLaplace
%{
Solving for Y(s) for laplace transformation:
y'' - 3y' + 19y = u(t) ; y(0) = 3, y'(0) = 0
y'' - 3y' + 19y = exp(-t) * sin(t)
a[ s^2Y(s) - sy(0) - y'(0) ] + b[ sY(s) - y(0) ] + c[ Y(s) ] = U(s)
s^2Y(s) - sy(0) - y'(0) + -3*sY(s) - -3*y(0) + 19*Y(s) = 1/ ((s + 5)^2 + 1^2)
s^2Y(s) - s*3 + -3*sY(s) - -3*3 + 19*Y(s) = 1/ ((s + 5)^2 + 1^2)
s^2Y(s) - 3sY(s) + 19Y(s) - 3s + 9 = 1/ ((s + 5)^2 + 1^2)
Y(s)[s^2 - 3s + 19] = 1/ ((s + 5)^2 + 1^2) + 3s - 9 
Y(s) = (1/ ((s + 5)^2 + 1^2) + 3s - 9)/[s^2 - 3s + 19]
%}
syms t s
ut = exp(-5*t) * sin(t); % u(t)
Ys = (1/ ((s + 5)^2 + 1^2) + 3*s - 9)/[s^2 - 3*s + 19] % Y(S)
Us = laplace(ut, t, s); % U(s)
yt = ilaplace(Ys, s, t) % y(t)
yFunc = matlabFunction(yt) % convert y from symbolic to function
yprime = diff(yt,1); % deriving y'
dyFunc = matlabFunction(yprime) % convert y' from symbolic to function

%{
dsolve methodology if needed:
syms y
% y'' - 3y' + 19y = u(t) ; y(0) = 3, y'(0) = 0
y = dsolve('1*D2y + -3*Dy + 19*y = exp(-5*t) * sin(t), y(0) == 3, Dy(0) == 0'); % solve 2nd ODE
yprime = diff(y,1);
yFunc = matlabFunction(y); % convert y from symbolic to function
dyFunc = matlabFunction(yprime); % convert y' from symbolic to function
%}
%% Part C - Plots
figure(1);
subplot(2,2,1);% plotting x1 = y(t) vs t
plot(tode, x1ode,'r.-',tSpan, yFunc(tSpan),'bo');
title('y(t) vs t');
xlabel('t');
ylabel('y(t)');
legend('Numerical Solution','Laplace & iLaplace','Location','best');
grid on;

subplot(2,2,3); % plotting x2 = dy(t) vs t
plot(tode, x2ode,'b.-', tSpan, dyFunc(tSpan),'ro');
title('y(t) vs t');
xlabel('t');
ylabel('dy(t)');
legend('Numerical Solution','Laplace & iLaplace','Location','best');
grid on;

subplot(2,2,[2 4]); % ploting x1 & x2 = dy(t) vs y(t)
plot(x1ode, x2ode,'g.-',yFunc(tSpan), dyFunc(tSpan),'mo');
title('y(t) vs t');
xlabel('y(t)');
ylabel('dy(t)');
grid on;
hold on;

plot(IC(1),IC(2),'k*',EP(1),EP(2),'r*');
xlabel('x_1(t)'), ylabel('x_2(t)');
legend('Numerical Solution','Laplace & iLaplace','Init Condition','Equil. Pt.','Location','best');
grid on;


%% Part D - Laplace & iLaplace (Matrix)
tSpan = 0:0.01:20;
syms s
Us = 1/s - exp(-10*s)/s; % U(s)
ut = ilaplace(Us); % u(t)
Xs = inv(s * eye(2) - A) * IC + inv(s * eye(2) - A) * B * Us; % X(s) matrix
xt = ilaplace(Xs); % iLaplace of X(s) matrix
X1s = Xs(1,1) % X1(s) equation from Xs matrix calcuations (y(t))
X2s = Xs(2,1) % X2(s) equation from Xs matrix calcuations (dy(t))
x1t = ilaplace(X1s); % x1(t) equation using ilaplace (y(t))
x2t = ilaplace(X2s); % x2(t) equation using ilaplace (dy(t))
x1 = matlabFunction(x1t); % using matlabFunction for equation (y(t)) 
x2 = matlabFunction(x2t); % using matlabFunction for equation (dy(t))
u = matlabFunction(ut); % using matlabFunction for equation (u(t))

figure(2);
subplot(3,2,1); % plotting x1 = y vs t
plot(tSpan,x1(tSpan),'r.-');
grid on;
xlabel('t');
ylabel('x_1(t)');
title('x_1(t) vs t');

subplot(3,2,3); % plotting x2 = dy vs t
plot(tSpan,x2(tSpan),'b.-')
grid on;
xlabel('t');
ylabel('x_2(t)');
title('x_2(t) vs t');

subplot(3,2,5); % plotting u = step vs t
plot(tSpan,u(tSpan),'g.-')
grid on;
xlabel('t');
ylabel('u(t)');
title('u(t) vs t');

subplot(3,2,[2 6]); % ploting x1 & x2 = dy(t) vs y(t)
plot(x1(tSpan),x2(tSpan),'k.-')
grid on;
hold on;
plot(IC(1),IC(2),'r*');
xlabel('x_1(t)'), ylabel('x_2(t)');
title('Phase Plot x_2(t) vs x_1(t)');
legend('Laplace & iLaplace','Init Condition','Location','best');

