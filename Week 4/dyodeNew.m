function [ yode ] = dyodeNew( tSpan, ySpan )
b = sqrt(4*200);
k = 200;
m = 1;
f = 0;
yode = [0 1; -(k/m) -(b/m)]*ySpan + [0; f];

end

