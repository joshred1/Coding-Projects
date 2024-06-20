syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = 9*D2y + 6*Dy + 82*y == 0;
cond1 = y(0) == -1;
cond2 = Dy(0) == 2;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-3,5); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')