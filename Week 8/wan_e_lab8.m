%% Eric Wan - ezw23@drexel.edu - Lab8
clear all, clc, close all
warning('off', 'all')
%{
x' = Ax
x(0) = [100; -50]
%}

%% Case I
A1 = [0 1; -10 -2]; % 2nd order diffeq
init = [100; -50]; % initial conditions

%% part 1
[v, d] = eig(A1); % eigenvalues and eigenvectors
e1 = d(1,1)
e2 = d(2,2)
%{
stable b/c both eigen values are negative
exp(-int) approaches 0
%}
v1 = v(:,1);
v1 = v1/min(v1) % whole numbers
v2 = v(:,2);
v2 = v2/min(v2) % whole numbers

%% part 2
C = inv([v1 v2]) * init; % solving for coefficients
c1 = C(1)
c2 = C(2)
%{
x(t) = c1*exp(e1*t)*v1 + c2*exp(e2*t)*v2
x(t) = (50-8.33i) * exp((-1+3i)t) * [1; -1+3i] + (50+8.33i) * exp((-1-3i)t) * [1; -1-3i]
%}

%% part 3
t = 0:0.15:5; % time span
x = c1 * exp(e1 * t) .* v1(1) + c2 * exp(e2 * t) .* v2(1); % function of y
dx = c1 * exp(e1 * t) .* v1(2) + c2 * exp(e2 * t) .* v2(2); % function of dy
%{
x and dx vs. t plots to compare
figure
plot(t,x,'r')
hold on
plot(t,dx,'g')
%}
figure
subplot(2,2,1);
plot(t,x,'r');
grid on;
xlabel('time');
ylabel('x(t)');
title('Case I: x(t) vs t'); % y vs t
subplot(2,2,3);
plot(t,dx,'g');
grid on;
xlabel('time');
ylabel('dx(t)');
title('Case I: dx(t) vs t'); % dy vs t
subplot(2,2,[2 4]);
plot(x,dx,'k');
grid on;
xlabel('x(t)');
ylabel('dx(t)');
title('dx(t) vs x(t)'); % dy vs y
hold on;
scatter(0, 0, 'r*');
scatter(x(1), dx(1), 'go');
legend('Phase Plot', 'Equil. Pts', 'Init. Conditions');

%% Case II
A2 = [0 1; -10 2]; % 2nd order diffeq
init = [100; -50]; % initial conditions

%% part 1
[v, d] = eig(A2); % eigenvalues and eigenvectors
e1 = d(1,1)
e2 = d(2,2)
%{
unstable b/c both eigen values are positive
exp(+int) approaches infinity
%}
v1 = v(:,1);
v1 = v1/min(v1) % whole numbers
v2 = v(:,2);
v2 = v2/min(v2) % whole numbers

%% part 2
C = inv([v1 v2]) * init; % solving for coefficients
c1 = C(1)
c2 = C(2)
%{
x(t) = c1*exp(e1*t)*v1 + c2*exp(e2*t)*v2
x(t) = 50 * exp(1t) * [1; 1] + 50 * exp(1t) * [1; 1]
%}

%% part 3
t = 0:0.15:5; % time span
x = c1 * exp(e1 * t) .* v1(1) + c2 * exp(e2 * t) .* v2(1); % function of y
dx = c1 * exp(e1 * t) .* v1(2) + c2 * exp(e2 * t) .* v2(2); % function of dy
%{
x and dx vs. t plots to compare
figure
plot(t,x,'r')
hold on
plot(t,dx,'g')
%}
figure
subplot(2,2,1);
plot(t,x,'r');
grid on;
xlabel('time');
ylabel('x(t)');
title('Case I: x(t) vs t'); %y vs t
subplot(2,2,3);
plot(t,dx,'g');
grid on;
xlabel('time');
ylabel('dx(t)');
title('Case I: dx(t) vs t'); % dy vs t
subplot(2,2,[2 4]);
plot(x,dx,'k');
grid on;
xlabel('x(t)');
ylabel('dx(t)');
title('dx(t) vs x(t)'); % dy vs y
hold on;
scatter(0, 0, 'r*');
scatter(x(1), dx(1), 'go');
legend('Phase Plot', 'Equil. Pts', 'Init. Conditions');

%% Part 4
%{
a)
Case I: Stable
Case II: Unstable

b)
Case I: Phase plot shows a spiral going towards equilibrium
Case II: Phase plot shows similar spiral, but goes away from equilibrium
Both cases follow their stability

c)
Case I: Component plot approaches 0 as time approaches infinity
Case II: Component plot remained in a sinusoidal/consinudoidal motion ...
w/ amplitude increasing to infinity as time approaches infinity
Again, both cases follow their stability
%}
