function plot_dAlemberts(phi, psi, c, t, xr, yr, ...
    xlabel_str, ylabel_str)
  
% plot_wave
%   Plot the wave function defined in terms of d'Alemberts formula
%
%   plot_dAlemberts(phi, psi, c, t, xr, yr, xlabel_str, ylabel_str, title_str)
%  
%   phi and psi are the the initial conditions
%   c is the wave speed
%   t is the current point in time
%   xr, yr defines the x, y axis range
%   xlabel_str, ylabel_str labels the x and y axis respectively
%   title_str is the plot title
%
% Written by Linda Stals, 2017
  
 
  % find the solution at these spatial coordinates
  x = linspace(min(xr), max(xr),500);
  x1 = x+c*t;
  x2 = x-c*t;
 
  % evaluate the integral of psi (one term at a time)
  qx = x;
  m = length(x);
  for i = 1:m
      qx(i) = quad(psi, x(i)-c*t, x(i)+c*t);
  end
  
  % plot the solution
  plot(x, (phi(x1)+ phi(x2))/2.0+0.5/c*qx, 'LineWidth', 1)

  % set the axis range
  xlim(xr)
  ylim(yr)

  % label the axis
  xlabel(xlabel_str)
  ylabel(ylabel_str)



