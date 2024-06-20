%25.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = x^2*D2y + 3*x*Dy == 0;
cond1 = y(1) == 0;
cond2 = Dy(1) == 4;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%26.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = x^2*D2y - 5*x*Dy + 8*y == 0;
cond1 = y(2) == 32;
cond2 = Dy(2) == 0;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%27.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = x^2*D2y + x*Dy + y == 0;
cond1 = y(1) == 1;
cond2 = Dy(1) == 2;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%28.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = x^2*D2y - 3*x*Dy + 4*y == 0;
cond1 = y(1) == 5;
cond2 = Dy(1) == 3;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%29.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = x*D2y + Dy == x;
cond1 = y(1) == 1;
cond2 = Dy(1) == -1/2;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%30.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = x^2*D2y - 5*x*Dy + 8*y == 8*x^2;
cond1 = y(1/2) == 0;
cond2 = Dy(1/2) == 0;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%37.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = 4*x^2*D2y + y == 0;
cond1 = y(-1) == 2;
cond2 = Dy(-1) == 4;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%38.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = x^2*D2y - 4*x*Dy + 6*y == 0;
cond1 = y(-2) == 8;
cond2 = Dy(-2) == 0;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')

%47.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
ode = 2*x^3*D3y - 10.98*x^2*D2y + 8.5*x*Dy + 1.3*y == 0;
simplify(dsolve(ode))

%48.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
ode = x^3*D3y + 4*x^2*D2y + 5*x*Dy - 9*y == 0;
simplify(dsolve(ode))

%49.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
D4y = diff(y,x,4);
ode = x^4*D4y + 6*x^3*D3y + 3*x^2*D2y - 3*x*Dy + 4*y == 0;
simplify(dsolve(ode))

%50.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
D4y = diff(y,x,4);
ode = x^4*D4y - 6*x^3*D3y + 33*x^2*D2y - 105*x*Dy + 169*y == 0;
simplify(dsolve(ode))

%51.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
ode = x^3*D3y - x^2*D2y - 2*x*Dy + 6*y == x^2;
simplify(dsolve(ode))

