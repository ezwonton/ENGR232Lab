function [ dydt ] = ode_eulerf( t, y )
dydt = y*(1-y/3);
end
