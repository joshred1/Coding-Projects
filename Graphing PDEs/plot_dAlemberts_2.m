function plot_dAlemberts_2(phi, psi, c, tr, xr, yr, ...
    xlabel_str, ylabel_str, title_str)
  
% plot_dAlemberts_2
%   Plot the wave function defined in terms of d'Alemberts formula at selected
%   points in time
%
%   plot_dAlemberts_2(phi, psi, c, tr, xr, yr, xlabel_str, ylabel_str, title_str)
%  
%   phi and psi are the the initial conditions
%   c is the wave speed
%   tr is the time range
%   xr, yr defines the x, y axis range
%   xlabel_str, ylabel_str labels the x and y axis respectively
%   title_str is the plot title
%
% Written by Linda Stals, 2017

  
  % specify the line colours
  cc=lines();

  % put all of the plots on the same graph
  hold on

  % find the solution at these spatial coordinates
  x = linspace(min(xr), max(xr));

  % loop over the points in time
  for t = min(tr):max(tr)

    % define the wave shift

    x1 = x+c*t;
    x2 = x-c*t;
 
    % evaluate the integral of psi (one term at a time)
    qx = x;
    m = length(x);
    for i = 1:m
        qx(i) = quad(psi, x(i)-c*t, x(i)+c*t);
    end
  
    % plot the solution
    plot(x, (phi(x1)+ phi(x2))/2.0+0.5/c*qx,'color',cc(t-min(tr)+1,:), ...
        'DisplayName', ['time = ', num2str(t)])
  end 
  hold off
  
  % set the axis range
  xlim(xr)
  ylim(yr)

  % label the axis
  xlabel(xlabel_str)
  ylabel(ylabel_str)

  % give the plot a title
  title(title_str)

  % show the legend
  legend('show',"location",'southeast')

