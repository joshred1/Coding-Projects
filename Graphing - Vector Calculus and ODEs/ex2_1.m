%1.
[x,y] = meshgrid(-3:0.3:3)
m = x.^2-y.^2;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold on 
f=@(x,y)x^2-y^2
[x,y]=ode45(f,[0,5],2);
plot(x,y)
hold on
[x,y]=ode45(f,[0,5],0);
plot(x,y)
hold on
[x,y]=ode45(f,[3,5],0);
plot(x,y)
hold on
[x,y]=ode45(f,[-2,5],1);
plot(x,y)
xlabel('x')
ylabel('y')
hold off


%2.
[x,y] = meshgrid(-6:0.3:10)
m = exp(-0.01.*x.*(y.^2));
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold on 
f=@(x,y)exp(-0.01.*x.*(y.^2));
[x,y]=ode45(f,[-6,10],0);
plot(x,y)
hold on
[x,y]=ode45(f,[0,10],1);
plot(x,y)
hold on
[x,y]=ode45(f,[0,10],-4);
plot(x,y)
hold on
[x,y]=ode45(f,[8,10],-4);
plot(x,y)
xlabel('x')
ylabel('y')
hold off

%3.
[x,y] = meshgrid(-4:0.3:4)
m = 1-x.*y;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold on 
f=@(x,y)1-x*y;
[x,y]=ode45(f,[0,4],0);
plot(x,y)
hold on
[x,y]=ode45(f,[-1,4],0);
plot(x,y)
hold on
[x,y]=ode45(f,[2,4],2);
plot(x,y)
hold on
[x,y]=ode45(f,[0,4],-4);
plot(x,y)
xlabel('x')
ylabel('y')
hold off

%4.
[x,y] = meshgrid(-5:0.3:5)
m = sin(x).*cos(y);
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold on 
f=@(x,y)sin(x)*cos(y);
[x,y]=ode45(f,[3,5],3);
plot(x,y)
hold on
[x,y]=ode45(f,[0,5],1);
plot(x,y)
hold on
[x,y]=ode45(f,[1,5],0);
plot(x,y)
hold on
[x,y]=ode45(f,[0,5],-5/2);
plot(x,y)
xlabel('x')
ylabel('y')
hold off

%5.
syms y(x)
ode = diff(y,x) == x;
cond1 = y(0) == 0;
cond2 = y(0) == -3;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold off

%6.
syms y(x)
ode = diff(y,x) == x +y;
cond1 = y(-2) == 2;
cond2 = y(-1) == 3;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold off

%7.
syms y(x)
ode = diff(y,x) == -x/y;
cond1 = y(1) == 1;
cond2 = y(0) == 4;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold off

%8.
syms y(x)
ode = diff(y,x) == 1/y;
cond1 = y(0) == 1;
cond2 = y(-2) == -1;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold on
[x,y] = meshgrid(-3:0.3:3)
m = 1./y;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold off

%9.
syms y(x)
ode = diff(y,x) == 0.2*(x^2)+y;
cond1 = y(0) == 1/2;
cond2 = y(2) == -1;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold off

%10.
syms y(x)
ode = diff(y,x) == x*exp(y);
cond1 = y(0) == -2;
cond2 = y(1) == 2.5;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold on
[x,y] = meshgrid(-3:0.3:3)
m = x.*exp(y);
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold off

%11.
syms y(x)
ode = diff(y,x) == y-cos(x/2);
cond1 = y(2) == 2;
cond2 = y(-1) == 0;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold on
[x,y] = meshgrid(-20:0.3:10)
m = y-cos(x./2);
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold off

%12.
syms y(x)
ode = diff(y,x) == 1-y/x;
cond1 = y(-1/2) == 2;
cond2 = y(3/2) == 0;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot(xs,y2)
hold on
[x,y] = meshgrid(-4:0.3:4,-40:1:40)
m = 1-y./x;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold off

%13.
syms y(x)
ode = diff(y,x) == 1-y/x;
cond1 = y(-1/2) == 2;
cond2 = y(3/2) == 0;
ys1(x) = dsolve(ode, cond1);
ys2(x) = dsolve(ode, cond2);
xs = linspace(-3,3); 
y1 = ys1(xs);
y2 = ys2(xs);
plot3(xs,y1) 
xlabel('x') 
ylabel('y(x)') 
hold on
plot3(xs,y2)
hold off

%19.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = y-y.^3;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)

%20.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = y.^2-y.^4;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)

%21.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = y.^2-3.*y;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)

%23.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = (y-2).^4;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)

%25.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = y.^2.*(4-y.^2);
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)

%27.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = y.*log(y+2);
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)


%31.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = (2.*x+1)./(2.*y);
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold on 
syms y(x)
ode = diff(y,x) == (2*x+1)/(2*y);
cond = y(-2) == -1;
ys(x) = dsolve(ode, cond);
xs = linspace(-3,3); 
y = ys(xs);
plot(xs,y) 
xlabel('x') 
ylabel('y(x)') 
hold off

%39.
[x,y] = meshgrid(-4:0.3:4,-4:0.3:4)
m = (y-1).^2;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold on 
syms y(x)
ode = diff(y,x) == (y-1)^2;
cond = y(0) ==1;
ys(x) = dsolve(ode, cond);
xs = linspace(-3,3); 
y = ys(xs);
plot(xs,y) 
xlabel('x') 
ylabel('y(x)') 
hold off

%43.
[x,y] = meshgrid(-3:0.3:3)
m = y-y.^3;
u = 1./sqrt(1+m.^2);
v = m./sqrt(1+m.^2);
quiver(x,y,u,v)
hold on 
f=@(x,y)y-y^3;
[x,y]=ode45(f,[0,3],2);
plot(x,y)
hold on
[x,y]=ode45(f,[0,3],0.5);
plot(x,y)
hold on
[x,y]=ode45(f,[0,3],-0.5);
plot(x,y)
hold on
[x,y]=ode45(f,[0,3],-2);
plot(x,y)
xlabel('x')
ylabel('y')
hold off
