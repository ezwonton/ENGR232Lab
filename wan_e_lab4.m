%% Eric Wan - ezw23@drexel.edu - Lab4

%% part a
%{
y'' + (b/m)y' + (k/m)y = f(t) => y'' = f(t) - (b/m)y' - (k/m)y
y'' = (y')'
x1 = y, x2 = y', y'' = x2'
Ax2' + Bx2 + Cx1 = g(t)
x1' = x2
x2'(t) = (b/m)x2(t) - (k/m)x1 + f(t)
[x1; x2]' = [0 1; -(k/m) (b/m)][x1; x2] + [0; f(t)]
%}

%% part b
type d2ydt2.m 
y = d2ydt2(0)
y = d2ydt2(50)
y = d2ydt2(-20)
%{
changing f(t) shifts equilibirum poin in that direction
increaseing f(t) shifts right, decreasing f(t) shifts left
%}

%% part c
%{
f(t) = y'' + 8y' + 200y
Aux = r^2 + 8r + 200
%}
Aux = [1 8 200];
rootsAux = roots(Aux)
%{
roots are complex b/c determinant (b^2 - 4ac) is less than 0
%}
checkRootsAux = (Aux(2))^2 - 4*(Aux(1))*(Aux(3))

%% part d
tI = 0;
tEnd = 2;
tSpan = [tI tEnd];
yI = 63;
dyI = 0;
ySpan = [yI; dyI];
type dyode.m
[tode, yode] = ode45(@dyode, tSpan, ySpan);
subplot(2,2,1)
plot(tode,yode(:,1))
grid on
hold on
xlabel('Interval Range (t)')
ylabel('Y(t)')
title('Y(t) vs. t')

subplot(2,2,2)
plot(tode,yode(:,2))
grid on
hold on
xlabel('Interval Range (t)')
ylabel('dY(t)')
title('dY(t) vs. t')

subplot(2,2,3)
plot(yode(:,1),yode(:,2))
grid on
hold on
xlabel('Y(t)')
ylabel('dY(t)')
title('dY(t) vs. Y(t)')

points = [yode(1,1) yode(1,2); yode(164,1) yode(164,2)];
plot(points(1,:), 'g*' )
plot(points(2,:), 'r*' )
legend('dY(t) vs. Y(t)','initial','equilibirum point')

%% part e

