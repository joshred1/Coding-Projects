%37.
syms y(x)
ode1 = diff(y,x) == 1-2*y;
cond1 = y(0) ==0;
ys1(x) = dsolve(ode1, cond1);
xs1 = linspace(0,3); 
y1 = ys1(xs1);
plot(xs1,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
ode2 = diff(y,x) == -2*y;
cond2 = y(3) == ys1(3);
ys2(x) = dsolve(ode2, cond2);
xs2 = linspace(3,6); 
y2 = ys2(xs2);
plot(xs2,y2) 
[x,y] = meshgrid(0:0.3:2.9, 0:0.1:1)
m = 1-2.*y;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
[x,y] = meshgrid(3:0.3:6, 0:0.1:1)
n = -2.*y;
s = 1./sqrt(1+n.^2);
t = n./sqrt(1+n.^2);
quiver(x,y,s,t)
hold off

%39.
syms y(x)
ode1 = diff(y,x) == x-2*x*y;
cond1 = y(0) ==2;
ys1(x) = dsolve(ode1, cond1);
xs1 = linspace(0,1); 
y1 = ys1(xs1);
plot(xs1,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
ode2 = diff(y,x) == -2*x*y;
cond2 = y(1) == ys1(1);
ys2(x) = dsolve(ode2, cond2);
xs2 = linspace(1,2); 
y2 = ys2(xs2);
plot(xs2,y2) 
[x,y] = meshgrid(0:0.05:0.95, 0:0.05:2)
m = x-2.*x.*y;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
[x,y] = meshgrid(1:0.05:2, 0:0.05:2)
n = -2.*x.*y;
s = 1./sqrt(1+n.^2);
t = n./sqrt(1+n.^2);
quiver(x,y,s,t)
hold off

%41.
syms y(x)
ode1 = diff(y,x) == 4*x-2*y;
cond1 = y(0) == 3;
ys1(x) = dsolve(ode1, cond1);
xs1 = linspace(0,1); 
y1 = ys1(xs1);
plot(xs1,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
ode2 = diff(y,x) == 4*x+(2*y)/x;
cond2 = y(1) == ys1(1);
ys2(x) = dsolve(ode2, cond2);
xs2 = linspace(1,2); 
y2 = ys2(xs2);
plot(xs2,y2) 
[x,y] = meshgrid(0:0.1:0.9, 0:0.2:20)
m = 4.*x-2.*y;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
[x,y] = meshgrid(1:0.1:2, 0:0.2:20)
n = 4.*x+(2.*y)./x;
s = 1./sqrt(1+n.^2);
t = n./sqrt(1+n.^2);
quiver(x,y,s,t)
hold off

