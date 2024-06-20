%Quiz 1
%2.
[x,y] = meshgrid(-10:1:10);
u = 18*(x+y).^3;
v = 18*(x+y).^3;
quiver(x,y,u,v)
xlabel('x')
ylabel('y')

%6
syms x y z t 
F = [x,-z,y];
r = [8*t,9*t,-(t^2)];
Fpar = subs(F,[x,y,z],r);
integrand = dot(Fpar,diff(r,t));
integral = int(integrand,t,-1,1)
fplot3(r(1),r(2),r(3),[-1,1])
xlabel('x')
ylabel('y')
zlabel('z')
hold on 
[x,y,z] = meshgrid(-5:2:5);
u = x;
v = -z;
w = y;
quiver3(x,y,z,u,v,w)
hold off 

%Quiz 2
%4.
syms u v
x = u*cos(v);
y = u*sin(v);
z = v;
fsurf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')

%Quiz 4

%6.
syms N t
N = (0.0004+0.9996*exp(-t))^(-1);
fplot(N,[0,20]);
xlabel('t')
ylabel('N')

%7.
P0=6000;
ts=[0:0.001:100];
[t,P] = ode45(@(t,P) P*(10^(-1)-10^(-7)*P),ts,P0);
plot(t,P,'-o')

%8.
p0=5/2-1;
ts=[0:0.01:1];
[t,p]=ode45(@(t,p) p*(5-p)-25/4,ts,p0);
plot(t,p,'-o')


%quiz 7
%8.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y + 9*y == 0;
cond1 = y(0) == 3;
cond2 = Dy(0) == -7;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-50,50); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 

%9.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y - 8*Dy + 16*y == 0;
cond1 = y(0) == 1;
cond2 = y(1) == 0;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-2,1.2); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)') 
%check:
fplot(exp(4*x)-x*exp(4*x),[-30,30])

%Quiz 8
%5.
syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y + 16*y == 40*exp(-4*x)*cos(4*x);
cond1 = y(0) == 0;
cond2 = Dy(0) == 0;
simplify(dsolve(ode, [cond1,cond2]))

%4.
syms x
fplot(4*sin(2*x))
hold on
fplot(exp(-x)*cos(2*x))
hold off

syms y(x)
Dy = diff(y,x);
D2y = diff(y,x,2);
ode = D2y + 2*Dy + 5*y == 16*cos(2*x) + 4*sin(2*x);
cond1 = y(0) == 1;
cond2 = Dy(0) == 7;
ys(x) = dsolve(ode,[cond1,cond2]);
xs1 = linspace(-10,10); 
y1 = ys(xs1);
plot(xs1,y1)
xlabel('x') 
ylabel('y(x)')
