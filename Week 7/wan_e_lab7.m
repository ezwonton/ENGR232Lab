%% Eric Wan - ezw23@drexel.edu - Lab7
%{
Solving IVP
y'' + y' - 6y = exp(-t) * cos(t)
y(0) = 1, y'(0) = 1
%}

%% Part A
%{
LaPlace Transform
y'' + y' - 6y = exp(-t) * cos(t)
a[ s^2Y(s) - sy(0) - y'(0) ] + b[ sY(s) - y(0) ] + c[ Y(s) ] = U(s)
s^2Y(s) - sy(0) - y'(0) + sY(s) - y(0) - 6[ Y(s) ] = U(s)
s^2Y(s) + sY(s) - 6Y(s) - sy(0) - y'(0) - y(0) = U(s)
(s^2 + s - 6)Y(s) - sy(0) - y'(0) - y(0) = U(s)
(s-2)(s+3)Y(s) - s - 1 - 1 = U(s)
F(s) = 1/(s+1) * s/(s^2 + 1)
(s-2)(s+3)Y(s) - s - 2 = 1/(s+1) * s/(s^2 + 1)
Y(s) = [1/(s+1) * s/(s^2 + 1) + s + 2] / (s-2)(s+3)
Y(s) = s/[(s+1)(s^2 + 1)] + s/[(s-2)(s+3)] + 2/[(s-2)(s+3)]
%}

%% Part B
syms t s
u = exp(-t) * cos(t); % u(t)
U = s/((s+1)*(s^2 + 1)) + s/((s-2)*(s+3)) + 2/((s-2)*(s+3)); % Y(S)
Us = laplace(u, t, s) % U(s)
yt = ilaplace(U, s, t) % y(t)

%% Part C
xI = [1; 1]; % init conditions
tSpan = 0:0.01:4; % span of T
type NumericSolution % print IVP function
[tode, yode] = ode45(@NumericSolution, tSpan, xI); % ode45
x1 = yode(:,1); % setting x1
x2 = yode(:,2); % setting x2
figure

% plotting x = y(t) vs t
subplot(2, 2, 1)
plot(tode, x1)
title('y(t) vs t')
xlabel('t')
ylabel('y(t)')
grid on
hold on

% plotting x2 vs t
subplot(2, 2, 3)
plot(tode, x2)
title('dy(t) vs t')
xlabel('t')
ylabel('dy(t)')
grid on
hold on

% plotting x2 vs x1
subplot(2, 2, [2 4])
plot(x1, x2)
title('dy(t) vs y(t)')
xlabel('y(t)')
ylabel('dy(t)')
grid on
hold on
plot(x1(1,1),x2(1,1),'*')
plot(x1(401,1),x2(401,1),'o')
legend('x2 vs x1', 'init condition', 'equil point')

%% Part D
y = matlabFunction(yt) % matlabFunction of y(t) ilaplace of Y(s)
dy = matlabFunction(diff(yt)) % matlabFunction of dy(t)

%% Part E
figure
% plotting ODE45 vs Analytical y vs t
subplot(2, 2, 1)
grid on
hold on
plot(tode, x1, 'o') % ode45
plot(tSpan, y(tSpan), 'r') % analytical
title('ODE45 vs. Analytical')
xlabel('t')
ylabel('y(t)')
legend('y ODE45', 'Analytical')

% plotting ODE45 vs Analytical dy vs t
subplot(2, 2, 3)
grid on
hold on
plot(tode, x2, 'o') % ode45
plot(tSpan, dy(tSpan), 'r') % analytical
title('ODE45 vs. Analytical')
xlabel('t')
ylabel('dy(t)')
legend('dy ODE45', 'dy Analytical')

% plotting ODE45 vs Analytical
subplot(2, 2, [2 4])
grid on
hold on
plot(x1, x2, 'o') % ode45
plot(y(tSpan), dy(tSpan), 'r') % analytical
title('dy(t) vs y(t)')
xlabel('y(t)')
ylabel('dy(t)')
legend('Phase ODE45', 'Phase Analytical')


