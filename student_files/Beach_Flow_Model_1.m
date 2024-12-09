%% Beach Set-up
% In order to visualize our flow model, we will need to set up our simulated beach.
% We start by making a figure and adding in the beach surface with the specified slope:
clear; close all; clc;

s = 0.4; %beach slope
x_max = 8;
x = 0:0.1:x_max; %spacial domain

beach = x*s;

figure
area(x,beach,'FaceColor','#EDB120')
xlim([0 10])
ylim([0 10])

return

%% Shoreline Motion
clear; close all; clc;

t = 0:0.1:20; %time
s = 0.1; %slope
x_max = 20
x = 0:0.1:x_max; %space domain

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A) We need to add in the equation for the shoreline here:

% xs = 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for timestep = 1:length(t) %plot the shoreline at each time step
    % We start by plotting the beach
    area(x,x*s,'FaceColor','#EDB120')
    xlim([0 10])
    ylim([0 10])
    hold on

    %then we plot the position of the shoreline as it changes through time
    plot([xs(timestep) xs(timestep)],[0 10],'b','LineWidth',2) % model shoreline marker
    hold off
    drawnow()
end


%% Water surface
clear; close all; clc;

t_end = 20;
t = 0:0.1:t_end;
s = 0.1;
x_end = 20;
x = 0:0.1:x_end;
ylimit = 1; %this just changes the y-axis and how the next plot is shown

%compute the shoreline location the same as before
xs = t - 0.5*s*t.^2;

f = figure;
f.Position = [200 400 1200 600];

for timestep = 1:length(t) %compute at each time step
    time = t(timestep);
    % We start by solving for the water depth at each time step
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % B) fill in the water depth equation here:

    %h = 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    area(x(x<xs(timestep)),h(x<xs(timestep))+x(x<xs(timestep))*s) %plot the water
    hold on

    % Plot the beach
    area(x,x*s,'FaceColor','#EDB120')
    xlim([0 10])
    ylim([0 ylimit])

    %then we plot the position of the shoreline as it changes through time
    plot([xs(timestep) xs(timestep)],[0 10],'b','LineWidth',2) % model shoreline marker
    hold off
    drawnow()
end


%% Water Velocity
clear; close all; clc;

t = 0:0.1:20;
s = 0.1;
dx = 0.1;
x = 0:dx:20;
ylimit = 1; %this just changes the y-axis and how the next plot is shown

%compute the shoreline location the same as before
xs = t - 0.5*s*t.^2;

f = figure;
f.Position = [200 400 1500 400];

for timestep = 1:length(t) %compute at each time step
    time = t(timestep);
    % We start by solving for the water depth at each time step
    h = (1/9)*(1 - 0.5*s*time - x/time).^2;
    area(x(x<xs(timestep)),h(x<xs(timestep))+x(x<xs(timestep))*s) %plot the water
    hold on

    % Plot the beach
    area(x,x*s,'FaceColor','#EDB120')
    xlim([0 10])
    ylim([0 ylimit])

    %then we plot the position of the shoreline as it changes through time
    plot([xs(timestep) xs(timestep)],[0 10],'b','LineWidth',2) % model shoreline marker
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % C) Here we need to put in the equation for the water velocity:

    % u = 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % the velocity infront of the shoreline is always going to be zero
    u(x>=xs(timestep)) = [];

    % we also need the x and y locations where the velocity exists 
    x_plot = x(x<xs(timestep));
    y_plot = 0.5*h(x<xs(timestep))+x(x<xs(timestep))*s;

    theta = atan(s); %this is the angle of the beach

    % here we can plot the water velocity as an arrow
    quiver(x_plot,y_plot,u*cos(theta),u*sin(theta),'k','LineWidth',1.5,'AutoScale','on');

    pause(0.05)
    hold off
    drawnow()
end













%% Answers
% A)
xs = t - 0.5*s*t.^2;
% B)
h = (1/9)*(1 - 0.5*s*time - x/time).^2;
% C)
u = (1/3)*(1 - 2*s*time + 2*(x/time));