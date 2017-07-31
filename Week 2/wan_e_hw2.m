%% Eric Wan - ezw23@drexel.edu - Homework 2
% part a
type hw_ode.m

% part b
dt = 0.0001;
yI = 4;
tI = 0;
tEnd = 0.25;

[tode, yode] = ode45(@hw_ode,[tI:dt:tEnd],yI);
plot(tode,yode,'k')
grid on
hold on
legend show
legend('ODE45')
xlabel('Time')
ylabel('y(t)')
title('First Order DiffEq Analysis')
