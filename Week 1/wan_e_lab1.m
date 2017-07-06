%% Eric Wan - ezw23@drexel.edu - Lab 1
%% Question 1
B = 0.5;
k = 150;
V = 0:1:170;
n = numel(V);
pts = zeros(1,n);
for i = 1:n
   dV = B*V(i)*log(k/V(i));
   pts(i) = dV;
end
figure
plot(V, pts)
hold on
grid on
legend show
xlabel('V')

%% Question 2
eq = [0 V(151); 0 pts(151)];
scatter(eq(1,:), eq(:,1),'r','filled')

%% Question 3
d2V = gradient(pts);
plot(V, d2V)
legend('dV', 'equilibrium pt','d^2V')

%% Question 4
%{
Regions of Attraction
@ V = 0, [0], unstable
@ V = 150, (0,infinity) stable
%}

%% Question 5
%{
No as there is no indication of time past
%}

%% Question 6

%% Question 7
%{
x' = 0.5*x*log(150/x)
independant var = t
min/max of t = -30/30
min/max of x = 0/170
%}

%% Question 8
%{
The results show that the direction fields go to 150 and away from 0
%}

%% Question 9
%{
The results show that it would take 15 seconds to have V = 140
%}

%% Question 10
%{
The results show that it would take 20 seconds to have V = 140. 
This takes longer than in question 9.
%}