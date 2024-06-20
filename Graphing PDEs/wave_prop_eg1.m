% Wave equation example 1
% Plot the wave equation with the given initial conditions
% 
% Written by Linda Stals, 2017 

% define the initial conditions

phi = @(x) 0*x;
psi = @(x) square(x);

% plot the wave on Figure 1
figure(1); clf()

% set the x and y axis limit
xr = [-5 5]; 
yr = [-3 3];

% set the speed to be 1
c = 1;

% evaluate the wave equation at the given points in time
tr = [0.5];
 
% plot the solution
plot_dAlemberts_2(phi, psi, c, tr, xr, yr, 'x', 'u', 'wave equation')
grid on
hold on
tr = [1 3]
plot_dAlemberts_2(phi, psi, c, tr, xr, yr, 'x', 'u', 'wave equation')
grid on
hold off



