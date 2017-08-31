%% ENGR232 - MATLAB exam Review
% MATLAB Basic

% Use "Run Section" to run currently highlighted section (ctrl+Enter on 
% Window OS).

%% Part 1a: row vector vs. column vector.
clc, clear
a = 0:2:5       % create a = [0,2,4]  a row vector
b = (0:2:5)'    % create b = [0;2;4]  a column vector
c = [1,2,3]     % create a = [1,2,3]  a row vector

%% Part 1b:  (*)  vs. (.*)
a_matrix_mult_b = a*b   % matrix multiplication, [1x3][3x1] = [1x1]

a_array_mult_c =  a.*c  % array multiplication, a(1)*b(1), a(2)*b(2), and so on.
% dimension of both should match, e.g. a and c both are row vector [3x1].

% Warning: If dimension does not match, weird things could happen.
%   - Old version of MATLAB, gives an error.
%   - New version of MATLAB, do all combinations of each element.
a_array_mult_b = a.*b    % We don't use this in this class.

%% Part 1c: check your orientation and size of your vectors
clc
whos  % or look at the workspace window

%% Part 1d: usual vectors vs. ode45 returned vectors
%   Usually, vectors you created are row vectors
%   However, ode45 returns column vectors
clc
yinit = [1;1];
tspan = 0:1:8;  % tspan will be a row vector
[t_ode45, y_ode45] = ode45(@diff_eq_2_var, tspan, yinit);
% For this example, y_ode45 will have 2 columns (2 variable system)
%   with the same number of rows as the length of tspan.

y_example = 1./exp(tspan); % same dimension as tspan, thus row vector
whos tspan y_ode45 y_example

%% Part 1e: Conclusion
%   - Be careful when do ./  .^   and .*
%   - Be careful when compute MSE errors.
%   - Generally speaking, just spam the dots, unless doing matrix
%     multiplication

%% Part 2: MSE - mean of (square of ( error ) )
%% Part 2a: Compute MSE by hand
clear, clc

% Suppose,
y_true   = [10, 20, 30]
y_approx = [11, 22, 29]
% Compute in a scrap paper, the MSE value


% Ans: MSE = 2
%% Part 2b: Which of the following MSE calculation(s) are correct?
%% MSE_1
MSE_1 = mean( (y_true-y_approx)^2 )  % Gives error

%% MSE_2 
MSE_2 = mean( (y_true-y_approx).^2 )

%% MSE_3
err = y_true - y_approx
sq  = err.^2
MSE_3 = sum(sq)/numel(y_true) % or mean(sq)

%% MSE_4
err = y_true - y_approx
MSE_4 = sum(err)/numel(y_true).^2

%% Your Answer: 

%% Ans: MSE_2 and MSE_3 are correct

%% Part 3: ode45 tspan options (two modes)
clc, clear

tspan_1 = [0,5];
tspan_2 = [0,3,4,5];
yinit = [0;0];
[t1, y1] = ode45(@diff_eq_2_var, tspan_1, yinit); % [0,5] auto-adjusted time step
[t2, y2] = ode45(@diff_eq_2_var, tspan_2, yinit); % [0,3,4,5] sampling at specified time
whos y1 y2 t1 t2 tspan_1 tspan_2

figure(1)   % figure(1) opens a new figure named "1", or make it current.
clf         % "clf" clears content of the current figure (just in case it
            % already has something from previous run.)

subplot(2,1,1)
plot(t1,y1(:,1), 'b.-', t2,y2(:,1), 'ro')
title('y_1(t) solution, using ode45 with different modes of tspan')
legend('tspan = [0,5]','tspan = [0,3,4,5]','location','southwest')
xlabel('Time'), ylabel('y_1')


subplot(2,1,2)
plot(t1,y1(:,2), 'b.-', t2,y2(:,2), 'ro')
title('y_2(t) solution, using ode45 with different modes of tspan')
legend('tspan = [0,5]','tspan = [0,3,4,5]','location','southwest')
xlabel('Time'), ylabel('y_2')

%% Part 4: subplot, plot, put text on figure
%% Part 4a: Putting text on the figure (you can do it any other ways)
% This is just one of the way.

% *** Run Part 3 first
figure(2), clf
plot(t1,y1(:,1), 'b.-', t2,y2(:,1), 'ro')

% Suppose,
MSE_Euler = 123.456789101112;
str = sprintf('MSE Euler = %.4e', MSE_Euler) % Create the string, 
% auto substituting value of MSE_Euler variable "%.4e" controls 4 decimal 
% places, using e-notation, e.g. 1.2346e+02, auto-round

% Put the string on the figure using "text" function
text(2, -0.1, str)

%% Part 4b: subplot
figure(3), clf
subplot(3,1,1)  % Split a figure into grids of 3 rows, 1 col, plot at No.1
plot(0:2, 0:2)

subplot(3,2,[3,5]) % Split to grids of [3x2], plot at location No. 3&5
plot(0:2, 0:2, 'm--')

subplot(3,2,4) % Split to [3x2], plot at location No. 4
plot(0:2, 0:2, 'ro')

%% Part 5: Characteristic Equation, and its roots
% 1y''-5y'+6y = g(t), Find the roots of the char. eq.
clc, clear
r = roots( [1,-5, 6] )

%% 2y'' + 6y = g(t), Find the roots of the char. eq.
% r = ???


% Answer: r = roots( [2,0,6] )
%% 2y'' + 6y' = g(t), Find the roots of the char. eq.
% r = ???


% Answer: r = roots( [2,6,0] )
%% Part 6: symbolic function, function handle and its value
%% Part 6a: symbolic function, function handle and its value
clc, clear
syms t
f_symbolic = (exp(2*t))*cos(t)
f_handle   = matlabFunction(f_symbolic)
tvec = 0:1:5;
f_value    = f_handle(tvec)    % We plot this one. After plug-in t-values.

whos f_symbolic f_handle f_value
whos t tvec

%% Part 6b: find y' from given symbolic y(t)
clc, clear
syms t
yt_sym = (exp(2*t))*cos(t)
ytprime_sym = diff(yt_sym, 1)  % do derivative 1 time, on **symbolic** y(t)

ytprime_handle = matlabFunction(yt_sym)

%% Part 6c: analytical solutions from symbolic or from given equation.
clc, clear

% Suppose, we use MATLAB to finally derive Ys as below, plot y(t) vs. t
% Use matlabFunction to convert symbolic form to function handle form.
syms s
Ys = 1/s + 1/(s+5)
yt_sym = ilaplace(Ys)
yt_handle = matlabFunction(yt_sym)

tvec = 0:0.1:5;
figure(101), clf
plot(tvec, yt_handle(tvec), 'r.-')

%% If instead, analytical solution is given you can calculate this directly.
% Given: y(t) = exp(-5*t) + 1
tvec = 0:0.1:5;
yt_value = exp(-5.*tvec) + 1;

figure(102), clf
plot(tvec, yt_value, 'bo-')
