%% Debris Beaching
clear; close all; clc;
s = 1/10;
St = 5.18;
gamma = 0.91;
H = 0.1; %particle height

%Initial Conditions
x0 = 0;
v0 = 0.9;
t0 = 0.1;
t_end = 20;

%We now need to set up all of our time steps at the beginning.
dt =0.1; %our time step size
t = t0:dt:t_end;

%For the first step, the initial values x_0 and v_0 will become x_i and v_i
x_i = x0;
x_f(1) = x_i;
v_i = v0;
v_f(1) = v_i;
t_i = t(1);
t_f = t_i;
u_i = (1/3)*(1 - 2*s*t_i + 2*(x_i/t_i));
u_f(1) = u_i;
xs(1) = t_i - 0.5*s*t_i^2;
u_s(1) = 1 - s*t_f;

%lets plot the first particle position
figure
plot(t_i,x_i,'rx','MarkerSize',5,'LineWidth',1)
hold on
xlim([0 20])
ylim([0 5])
xlabel("time")
ylabel("position")
title("Particle Position")
set(gca,'FontSize',15)

for step=2:length(t)-1


    %the time for t_f is the time at the next step:
    t_f = t(step + 1);
    %solve for the new particle position
    x_f(step) = v_i*(t_f - t_i) + x_i;
    %solve for the fluid velocity at the new particle position
    u_f(step) = (1/3)*(1 - 2*s*t_f + 2*(x_f(step)/t_f));
    %find the water depth
    h(step) = (1/9)*(1 - 0.5*s*t_f - x_f(step)/t_f).^2;
    
    %on the run-up, the particle can't move infront of the shoreline
    %shoreline position
    xs(step) = t_f - 0.5*s*t_f^2;
    %shoreline velocity
    u_s(step) = 1 - s*t_f;
    if u_f(step) > 0 %if the fluid at the particle is moveing forward (run-up)
        if x_f(step) - xs(step) > 0 %if the particle is infront of the shoreline
            x_f(step) = xs(step); %then the particle takes the shoreline's position
            u_f(step) = u_s(step);
            v_f(step) = u_s(step);
        else
            v_f(step) = ((u_f(step)-v_f(step-1))/St)*(t_f-t_i) + v_i;
        end
    elseif u_f(step) <= 0 %shoreline stops/turns around
        v_f(step) = ((u_i-v_i)/St)*(t_f-t_i) + v_i;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % F) Beaching condition
        % If the particle is ahead of the shoreline,
        % then the velocity is zero
        if x_f(step) > xs(step) 
            v_f(step) = 0;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end

    % If the particle goes beyond the shoreline, then the position doesn't matter
    if x_f(step) < 0 
        x_f(step) = nan;
        continue
    end

    %Now the 'final' values will become the new 'initial' values for the
    %next time step:
    x_i = x_f(step);
    v_i = v_f(step);
    t_i = t_f;
    u_i = u_f(step);

    plot(t_f,x_f(step),'rx','MarkerSize',5,'LineWidth',1)
    %pause(0.01)
    drawnow()
end

save('model_data.mat','t','x_f')
return

%% Animate particle on beach
close all;

t = t0:dt:20;
s = 0.1;
x = 0:0.1:20;
ylimit = 1; %this just changes the y-axis and how the next plot is shown

%compute the shoreline location the same as before
xs = t - 0.5*s*t.^2;

for timestep = 1:length(t) %compute at each time step
    % We start by solving for the water depth at each time step
    h = (1/9)*(1 - 0.5*s*t(timestep) - x/t(timestep)).^2; %this line empty?
    area(x(x<xs(timestep)),h(x<xs(timestep))+x(x<xs(timestep))*s) %plot the water
    hold on

    % Plot the beach
    area(x,x*s,'FaceColor','#EDB120')
    xlim([0 10])
    ylim([0 ylimit])

    %then we plot the position of the shoreline as it changes through time
    plot([xs(timestep) xs(timestep)],[0 10],'b--','LineWidth',2) % model shoreline marker
    %hold off
   
    hp = (1/9)*(1 - 0.5*s*t(timestep) - x_f(timestep)/t(timestep)).^2;
    plot(x_f(timestep),hp + x_f(timestep)*s,'ro','LineWidth',2) % particle marker
    %pause(0.1)
    drawnow()

    hold off

    if timestep == length(x_f)
        return
    end


end

%% Compare to Experiments
clear; close all; clc;
load experimental_data.mat
exp_particle = 1; %change this from 1 to 5 to set the particle from the experiment
t_experiment = time;
x_experiment = x_exp(exp_particle,:);

figure
%%%%%%%%%%%%%%%%%%%%%%%%%
% G)
% plot the experimental data
plot(t_experiment,x_experiment)
%%%%%%%%%%%%%%%%%%%%%%%%%
hold on

load model_data.mat
t_model = (t(1:end-1)+t(2:end))/2;
x_model = x_f;
%%%%%%%%%%%%%%%%%%%%%%%%%
% H)
% plot the model
plot(t_model,x_model)
%%%%%%%%%%%%%%%%%%%%%%%%%

legend({'experiment','model'})
set(gca,'FontSize',15)





























%% Answers
% F)
    if x_f(step) > xs(step) 
          v_f(step) = 0;
    end

% G)
plot(t_experiment,x_experiment)

% H)
plot(t_model,x_model)