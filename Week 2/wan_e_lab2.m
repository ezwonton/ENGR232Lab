%% Eric Wan - ezw23@drexel.edu

% Initialize Variables
dt = 0.2;
yI = 1;
tI = 0;
tEnd = 10;

% Define time points and solution vector
tSpan = tI:dt:tEnd;
y = zeros(size(tSpan));

% Initialize the solution at the initial conditions
y(1) = yI;

% ode_eulerf function
type ode_eulerf.m

% Implement Euler's method
for i=2:length(tSpan)
yprime = ode_eulerf(tSpan(i-1),y(i-1));
y(i) = y(i-1) + dt*yprime;
end

%% Question 1
% Plot Solutions
figure
axis square
plot(tSpan,y,'b')
grid on
hold on
legend show
xlabel('Time')
ylabel('y(t)')
title('First Order DiffEq Analysis')

% ODE45
[tode, yode] = ode45(@ode_eulerf,[tI:0.2:tEnd],yI);
plot(tode,yode,'k')

% Analytical Solution
n = numel(tSpan);
pts = zeros(1,n);
for i = 1:n
   ya = - 6/(exp(tSpan(i)) + 2) + 3;
   pts(i) = ya;
end
plot(tSpan, pts, 'm')
legend('Eulers','ODE45','Analytical')

err1 = mean((pts - y).^2) % mse between analytical and euler
err2 = mean((pts - yode.').^2) % mse between analytical and ode45
err3 = mean((y - yode.').^2) % mse between euler and ode45

%% Question 2
%{
y*(1-y/3) = 0
equilibrium points at y = 3 and not 0
y(0) = 1 as defined
time about 7 seconds to reach y = 3
y(t) = 3 - 0 but cannot have [- 6/(exp(tSpan(i)) + 2) = 0], only can get
infinitely smaller
%}

%% Question 3
%{
time for y to go from 1.2 to 2.4
t = 1.6 seconds
%}

