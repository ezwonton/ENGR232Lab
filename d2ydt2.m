function [ y ] = d2ydt2( f )
d2y = 0;
dy = 0;
b = 8;
k = 200;
m = 1;
y = (f - d2y - (b/m)*dy) / (k/m);
end

