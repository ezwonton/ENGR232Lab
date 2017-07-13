%% Eric Wan - ezw23@drexel.edu - Lab3

%% Problem 1 - Eulers
% step of 10
dt = 10;
pI = 3/15000;
tI = 0;
tEnd = 500;
tSpan = tI:dt:tEnd;
p = zeros(size(tSpan));
p(1) = pI;
formatSpec = 'For a step of %.2f, half of population infected at %.2f hours with ratio of %.4f for Eulers \n';
type ebola.m
for i=2:length(tSpan)
pprime = ebola(tSpan(i-1), p(i-1));
p(i) = p(i-1) + dt*pprime;
end
figure
plot(tSpan,p,'b')
grid on
hold on
legend show
xlabel('Time')
ylabel('P(t)')
title('First Order DiffEq Analysis')
fprintf(formatSpec, dt, tSpan(26), p(26))

% step of 5
dt = 5;
tSpan = tI:dt:tEnd;
p = zeros(size(tSpan));
p(1) = pI;
for i=2:length(tSpan)
pprime = ebola(tSpan(i-1), p(i-1));
p(i) = p(i-1) + dt*pprime;
end
plot(tSpan,p,'r')
fprintf(formatSpec, dt, tSpan(47), p(47))

% step of 1
dt = 1;
tSpan = tI:dt:tEnd;
p = zeros(size(tSpan));
p(1) = pI;
for i=2:length(tSpan)
pprime = ebola(tSpan(i-1), p(i-1));
p(i) = p(i-1) + dt*pprime;
end
plot(tSpan,p,'g')
fprintf(formatSpec, dt, tSpan(218), p(218))

%% Problem 2 - Runge-Kutta
dt = 5;
tSpan = tI:dt:tEnd;
k = zeros(size(tSpan));
k(1) = pI;

for i=2:length(tSpan)
k1 = ebola(tSpan(i-1), k(i-1));
k2 = ebola((tSpan(i-1)+(dt/2)), (k(i-1) + (dt/2*k1)));
k(i) = k(i-1) + dt*k2;
end
plot(tSpan,k,'k')
formatSpec = 'For a step of %.2f, half of population infected at %.2f hours with ratio of %.4f for Runge-Kutta\n';
fprintf(formatSpec, dt, tSpan(44), k(44))

%% Problem 3 - ODE45
dt = 5;
tSpan = tI:dt:tEnd;
p(1) = pI;
[tode, pode] = ode45(@ebola, [tSpan], pI);
plot(tode,pode,'m')
legend('dt = 10','dt = 5','dt = 1', 'Runge-Kutta', 'ODE45')
formatSpec = 'For a step of %.2f, half of population infected at %.2f hours with ratio of %.4f for ODE45\n';
fprintf(formatSpec, dt, tode(44), pode(44))

%% Problem 4 - Analytical 
% rewriting eulers step of 5
dt = 5;
tSpan = tI:dt:tEnd;
p = zeros(size(tSpan));
p(1) = pI;
for i=2:length(tSpan)
pprime = ebola(tSpan(i-1), p(i-1));
p(i) = p(i-1) + dt*pprime;
end

n = numel(tSpan);
pts = zeros(1,n);
for i = 1:n
   pa = exp(0.04*tSpan(i))/(exp(0.04*tSpan(i)) + 4999);
   pts(i) = pa;
end
plot(tSpan, pts, 'y')
legend('dt = 10','dt = 5','dt = 1', 'Runge-Kutta', 'ODE45', 'Analytical')

err1 = mean((pts - p).^2); % mse between Analytical and Euler
fprintf('The MSE between Analyical and Euler is %f\n', err1)
err2 = mean((pts - pode.').^2); % mse between Analytical and ODE45
fprintf('The MSE between Analyical and ODE45 is %f\n', err2)
err3 = mean((pts - k).^2); % mse between Analytical and Runge-Kutta
fprintf('The MSE between Analyical and Runge-Kutta is %f\n', err3)

%% Question 5 - Commenting on Solutions
%{
ODE45 is the most accurate with very little MSE error to the analytical
solution
Runge-Kutta is very close to the analytical solution
Eulers is the farthest off from the analytical solution
%}
