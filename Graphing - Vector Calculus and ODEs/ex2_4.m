%39
syms y(x)
ode1 = diff(y,x) == -(4*x*y+3*(x^2))/(2*y+2*(x^2));
cond1 = y(0) == -2;
ys1(x) = dsolve(ode1, cond1);
xs1 = linspace(-2,2.4); 
y1 = ys1(xs1);
plot(xs1,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
ode2 = diff(y,x) == -(4*x*y+3*(x^2))/(2*y+2*(x^2));
cond2 = y(1) == 1;
ys2(x) = dsolve(ode2, cond2);
xs2 = linspace(-10,10); 
y2 = ys2(xs2);
plot(xs2,y2) 
[x,y] = meshgrid(-10:0.3:10)
m = -(4.*x.*y+3.*(x.^2))./(2.*y+2.*(x.^2));
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold off