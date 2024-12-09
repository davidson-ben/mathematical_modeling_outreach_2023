function [t,xp] = swashinertialparticle_int(s,St,H,xp0,t,mu,Cm,gamma,k,shift)
%swashinertialparticle_int.m Set up integration of swashinertialparticle_ode.m

% function to integrate
rhs = @(t,xp) swashinertialparticle_ode(s,St,H,xp,t,mu,Cm,gamma,k,shift);
% integrate
[t,xp] = ode45(rhs,t,xp0); 

end