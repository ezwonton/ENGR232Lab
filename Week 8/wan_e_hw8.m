%% Eric Wan - ezw23@drexel.edu - HW8
clear all, clc, close all
% warning('off', 'all')

a2 = [-1 1; -2 1];
[a2v, a2d] = eig(a2)

b2 = [-1/2 5/2; 5/2 -1/2];
[b2v, b2d] = eig(b2);
e1 = b2d(1,1)
e2 = b2d(2,2)
v1 = b2v(:,1);
v1 = v1/min(v1)
v2 = b2v(:,2);
v2 = v2/min(v2)

