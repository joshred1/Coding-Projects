%15.
syms y(t) x(t) z(t);
Y = [x; y; z];
A = [0.9, 2.1, 3.2; 0.7, 6.5, 4.2; 1.1, 1.7, 3.4];
ode = diff(Y,t) == A*Y;
[xs(t), ys(t), zs(t)] = dsolve(ode); 
xs(t) = simplify(xs(t)) 
ys(t) = simplify(ys(t)) 
zs(t) = simplify(zs(t))

%16.
syms x1(t) x2(t) x3(t) x4(t) x5(t)
X = [x1; x2; x3; x4; x5];
A = [1, 0, 2, -1.8, 0; 0, 5.1, 0, -1, 3; 1, 2, -3, 0, 0; 0, 1, -3.1, 4, 0; -2.8, 0, 0, 1.5, 1];
ode = diff(X,t) == A*X;
[xs1(t), xs2(t), xs3(t), xs4(t), xs5(t)] = dsolve(ode);
xs1(t) = simplify(xs1(t))
xs2(t) = simplify(xs2(t))
xs3(t) = simplify(xs3(t))
xs4(t) = simplify(xs4(t))
xs5(t) = simplify(xs5(t))

%17.
[x, y] = meshgrid(-10:1:10);
xdot = 10.*x - 5.*y;
ydot = 8.*x - 12.*y;
quiver(x, y, xdot, ydot)

%18.
[x, y] = meshgrid(-10:1:10);
xdot = 2.*x + 2.*y;
ydot = x + 3.*y
quiver(x,y,xdot,ydot)

[x, y] = meshgrid(-10:1:10);
xdot = -5.*x./2 + 2.*y;
ydot = 3.*x./4 - 2.*y
quiver(x,y,xdot,ydot)


%32.
[x, y] = meshgrid(-10:1:10);
xdot = -6.*x + 5.*y;
ydot = -5.*x + 4.*y
quiver(x,y,xdot,ydot)


[x, y] = meshgrid(-10:1:10);
xdot = -1.*x + 3.*y;
ydot = -3.*x + 5.*y
quiver(x,y,xdot,ydot)

%47.

[x, y] = meshgrid(-10:1:10);
xdot = 4.*x - 5.*y;
ydot = 5.*x - 4.*y
quiver(x,y,xdot,ydot)


[x, y] = meshgrid(-10:1:10);
xdot = 1.*x - 8.*y;
ydot = 1.*x - 3.*y
quiver(x,y,xdot,ydot)




