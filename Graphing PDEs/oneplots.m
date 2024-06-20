%% Characteristic curves example 3
% A solution of the quasilinear PDE of the form
% u_x + c(x,y)u_y = f (x, y, u),   u(0, y) = u_0(y)
% where c = 2xy^2, f = 2xy and u0(y) = y^3
%
% Written by Linda Stals, 2017 

%% Define the quasilinear PDE
c = @(x, y, u) x^2/3
f = @(x, y, u) -exp(2*x)*u/3
u0 = @(y) 2*sin(y) + 4*cos(y)

%% Define the domain
yval = -30:0.05:30;
xval = -5:0.05:5;
xr = [-5 4]; % set the x axis limit
yr = [-15 15]; % set the y axix limit

%% Find an approximate solution to the quasilinear PDE
[X, Y, V] = quasi_solve1(c, f, u0, xval, yval);

%% Make a three dimensional plot of the approximate solution on Figure 3
figure(3);  clf()
zr = [-8 8];
plot_v(X, Y, V, xr, yr, zr, 't', 'x', 'u(x,t)')


