%% Second order characteristic curves example 3
% Plot the wave solution given by d'Alemberts equation
% 
% Written by Linda Stals, 2017 

%% Define the quasilinear PDE

phi = @(x) 2./(1+x.^2);
psi = @(x) 2.*x.*exp(-x.^2); 

%% plot the characteristic curves on Figure 1
figure(1); clf()

% set the x and y axis limit
xr = [-10 10]; 
yr = [0 2];

%set the speed to be 1
c = 2.5;

%evaluate the solution at this point in time
t = 3; % set the y axix limit
 
% plot the solution
clf()
hold on
for t=0:0.25:1
    plot_dAlemberts(phi, psi, c, t, xr, yr, 'x', 'u(x,t)')
end
hold off

legend('$t=0$','$t=0.25$','$t=0.5$','$t=0.75$','$t=1$','Interpreter','latex')

