function [u0] = square(x)

% square
%   Define the square function which is equal to 1 when -1 < x < 1 and 
%   0 otherwise
%
%   square(r)
%  
%   x is the input parameter
%   u0 is the function evaluated at x
%
% Written by Linda Stals, 2017

u0 = 0*x;
I = x >-1 & x<1;
u0(I) = 2;

end
