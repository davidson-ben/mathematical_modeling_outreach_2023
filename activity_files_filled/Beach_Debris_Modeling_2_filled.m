%% Solve the particle position
clear; close all; clc;
%initial conditions
x0 = 0; %the particle starts at the still water line
v0 = 0.9; 
t0 = 0.1; %the particle starts just after the shoreline (otherwise there is a "singularity" - divide by zero)
t1 = 0.2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% D) position at t1
x1 = v0*(t1 - t0) + x0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(strcat("x1 = ",string(x1)))
return
%% Solve the particle velocity
clear; close all; clc;
%initial conditions
x0 = 0; %the particle starts at the still water line
v0 = 0.9; 
t0 = 0.1; %the particle starts just after the shoreline (otherwise there is a "singularity")

%time
t0 = 0.1;
t1 = 0.2;

%position
x1 = v0*(t1 - t0) + x0;

St = 5; %Again, for now let this be 5.  We can change this later.

s = 1/10; %this is the slope

%water velocity equation
u0 = (1/3)*(1 - 2*s*t0 + 2*(x0/t0));
u1 = (1/3)*(1 - 2*s*t1 + 2*(x1/t1));

% D) Can you  above 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% E) rearrange the equation to be v_1 = f(v_0,t_0,t_1,u_0,St)?
v1 = ((u0-v0)/St)*(t1-t0) + v0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Iterate the solution to every step of run-up
%We still need our initial conditions:
clear; close all; clc;
x0 = 0;
v0 = 0.9;
t0 = 0.1;
t_end = 20;

s = 0.1;
St = 5;

%We now need to set up all of our time steps at the beginning.
dt =1; %our time step size
t = t0:dt:t_end;

%For the first step, the initial values x_0 and v_0 will become x_i and v_i
x_i = x0;
v_i = v0;
t_i = t(1);
u_i = (1/3)*(1 - 2*s*t_i + 2*(x_i/t_i));

%lets plot the particle position
figure
plot(t_i,x_i,'rx','MarkerSize',5,'LineWidth',1)
hold on
xlabel("time")
ylabel("position")
title("Particle Position")
set(gca,'FontSize',15)
xlim([0 20])
ylim([0 10])

for step=1:length(t)-1
    %the time for t_f is the time at the next step:
    t_f = t(step + 1);
    %solve for the new particle position
    x_f = v_i*(t_f - t_i) + x_i;
    %solve for the fluid velocity at the new particle position
    u_f = (1/3)*(1 - 2*s*t_f + 2*(x_f/t_f));
    %solve for the new particle velocity
    v_f = ((u_i-v_i)/St)*(t_f-t_i) + v_i;

    %Now the 'final' values will become the new 'initial' values for the
    %next time step:
    x_i = x_f;
    v_i = v_f;
    t_i = t_f;
    u_i = u_f;

    plot(t_f,x_f,'rx','MarkerSize',5,'LineWidth',1)
    pause(0.1)
end













%% Answers
% D)
x1 = v0*(t1 - t0) + x0;

% E)
v1 = (beta*((u1 - u0)/(t1-t0) + u0*((u1-u0)/(x1-x0))) + (u0-v0)/St)*(t1-t0) + v0;