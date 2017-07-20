function [ yode ] = dyode( tSpan, ySpan )
b = 8;
k = 200;
m = 1;
f = 0;
yode = [0 1; -(k/m) -(b/m)]*ySpan + [0; f];

end

