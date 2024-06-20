%1. 
[x,y] = meshgrid(-10:1:10)
u = 0*x + 0.3; v = 0*y - 0.4;
quiver(x, y, u, v)
xlabel('x')
ylabel('y')


%3.
[x,y] = meshgrid(-10:1:10)
u = 0*x - 0.5; v = y - x;
quiver(x, y, u, v)
xlabel('x')
ylabel('y')

%5.
[x,y] = meshgrid(-10:1:10)
u = y./sqrt(x.^2+y.^2); v = x./sqrt(x.^2+y.^2);
quiver(x, y, u, v)
xlabel('x')
ylabel('y')

%7.
[x,y,z] = meshgrid(-5:1:5)
u = 0*x; v = 0*y; w = 0*z + 1;
quiver3(x,y,z,u,v,w)
xlabel('x')
ylabel('y')
zlabel('z')

%9.
[x,y,z] = meshgrid(-5:1:5)
u = 0*x; v = 0*y, w = x;
quiver3(x,y,z,u,v,w)
xlabel('x')
ylabel('y')
zlabel('z')

%11.
[x,y] = meshgrid(-10:1:10)
u = x; v = -y;
quiver(x,y,u,v)
xlabel('x')
ylabel('y')
%IV

%13.
[x,y] = meshgrid(-10:1:10)
u = cos(x + y); v = x;
quiver(x,y,u,v)
xlabel('x')
ylabel('y')
%II

%15.
[x,y,z] = meshgrid(-5:1:5)
u = 0*x + 1; v = 0*y + 2; w = 0*z + 3;
quiver3(x,y,z,u,v,w)
xlabel('x')
ylabel('y')
zlabel('z')
%IV

%17.
[x,y,z] = meshgrid(-5:1:5)
u = x, v = y, w = 0*z + 3;
quiver3(x,y,z,u,v,w)
xlabel('x')
ylabel('y')
zlabel('z')
%III

%19.
[x,y] = meshgrid(-30:1:30)
u = y.^2 - 2*x.*y; v = 3*x.*y - 6*x.^2;
quiver(x,y,u,v)
xlabel('x')
ylabel('y')

%25.
[x,y] = meshgrid(-10:1:10)
u = 2*x; v = 0*y - 1;
quiver(x,y,u,v)
xlabel('x')
ylabel('y')

%27.
[x,y] = meshgrid(-10:1:10)
u = 2*x./(1 + x.^2 + 2*y.^2); v = 4*y./(1 + x.^2 + 2*y.^2);
quiver(x,y,u,v)
xlabel('x')
ylabel('y')

[x,y] = meshgrid(-3:0.1:3)
z = log(1 + x.^2 + 2*y.^2)
contour(x,y,z,10)
[u,v] = gradient(z)
hold on 
quiver(x,y,u,v)
hold off

%31.
[x,y] = meshgrid(-10:1:10)
u = x; v = -y;
quiver(x,y,u,v)
xlabel('x')
ylabel('y')
