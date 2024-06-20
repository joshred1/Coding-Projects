%31.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y + 4*Dy + 5*y == 35*exp(-4*x);
cond1 = y(0) == -3;
cond2 = Dy(0) == 1;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 

%35.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
ode = D3y - 2*D2y + Dy == 2 - 24*exp(x) + 40*exp(5*x);
cond1 = y(0) == 1/2;
cond2 = Dy(0) == 5/2;
cond3 = D2y(0) == -9/2
ys(x) = dsolve(ode,[cond1,cond2,cond3]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 

%37.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y + y == x^2 + 1;
cond1 = y(0) == 5;
cond2 = y(1) == 0;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 

%39.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y + 3*y == 6*x;
cond1 = y(0) == 0;
cond2 = y(1) + Dy(1) == 0;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 

%46.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y-4*Dy+8*y==(2*x^2-3*x)*exp(2*x)*cos(2*x)+(10*x^2-x-1)*exp(2*x)*sin(2*x);
ys(x) = dsolve(ode);

%47.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
D4y = diff(y,x,4);
ode = D4y + 2*D2y + y == 2*cos(x) - 3*x*sin(x);
ys(x) = dsolve(ode);
