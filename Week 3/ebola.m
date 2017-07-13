function [ dPdt ] = ebola( t, P )
dPdt = 0.04*P*(1-P);
end

