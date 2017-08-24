%% Eric Wan - ezw23@drexel.edu - Lab9
clear all
close all
clc

x0 = [0;0];
A = [0 1; -10 -2];
B = [0; 1];
%% Part 1
[v, d] = eig(A);
d
% underdamped b/c real part is negative and has imaginary parts

%% Part 2
syms s
Us = 1/s - exp(-5*s)/s;
Xs = inv(s * eye(2) - A) * x0+ inv(s * eye(2) - A) * B * Us; 
X1s = simplify(Xs(1,1))
X2s = simplify(Xs(2,1))

%% Part 3
x1t = ilaplace(X1s)
x2t = ilaplace(X2s)
ut = ilaplace(Us)

%% Part 4
IC = x0;
ep = inv(A) * -B;
x1 = matlabFunction(x1t);
x2 = matlabFunction(x2t);
u = matlabFunction(ut)
t = 0:0.01:15;

figure
subplot(2,2,1);
plot(t,x1(t),'r', 'linewidth', 2);
grid on;
ylabel('x_1(t)');
xlabel('t')
title('x_1(t) vs t')

subplot(2,2,3)
plot(t,x2(t), 'linewidth', 2)
grid on;
ylabel('x_2(t)')
xlabel('t')
title('x_2(t) vs t')


subplot(1,2,2)
plot(t,u(t),'r', 'linewidth', 2);
grid on;
ylabel('u(t)');
xlabel('t')
title('u(t) vs t')

figure
plot(x1(t),x2(t),'g', 'linewidth', 2)
ylabel('x_2(t)')
xlabel('x_1(t)')
title('x_2(t) vs x_1(t)')
hold on

%% Part 5
plot(IC(1),IC(2),'b*',ep(1),ep(2),'k*')
plot(ep(1),ep(2),'ko')
xlabel('x_1(t)'), ylabel('x_2(t)')
title('Phase Plot')
legend('Analytical','Init Condition','Eqil. Pt.','Location','best')
grid on

%% Part 6
%{
a.) The phase plot approaches the equilibrium point which is where the
pulse turns off and then the plot returns to the initial condition
b.) At around 12 seconds, x1(t) goes to 0
c.) At around 12 seconds, x2(t) goes to 0
%}