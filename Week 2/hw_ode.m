function [ dydt ] = hw_ode( t, y )
dydt = y^2 - 3*sin(y) + t;
end

