%69.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
D4y = diff(y,x,4);
ode = 2*D4y + 3*D3y - 16*D2y + 15*Dy - 4*y == 0;
cond1 = y(0) == -2;
cond2 = Dy(0) == 6;
cond3 = D2y(0) == 3;
cond4 = D3y(0) == 1/2;
ys(x) = dsolve(ode,[cond1,cond2,cond3,cond4]);
xs1 = linspace(-4,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 

%70.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
D3y = diff(y,x,3);
D4y = diff(y,x,4);
ode = D4y - 3*D3y + 3*D2y - Dy == 0;
cond1 = y(0) == 0;
cond2 = Dy(0) == 0;
cond3 = D2y(0) == 1;
cond4 = D3y(0) == 1;
ys(x) = dsolve(ode,[cond1,cond2,cond3,cond4]);
xs1 = linspace(-5,3); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 

%*.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y + 4*y == 4*cos(2*x);
cond1 = y(0) == 1;
cond2 = Dy(0) == 2;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-5,5); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 
%check solution:
syms x
y = cos(2*x) + sin(2*x) + x*sin(2*x);
fplot(y,[-50,50])
