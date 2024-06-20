%9a.
syms x y z
F = [(x^2)*z,x*(y^2),z^2];
curlF = curl(F);
curlF1 = [curlF(1),curlF(2),curlF(3)];
syms r t
R = [r*cos(t),r*sin(t),1-r*cos(t)-r*sin(t)];
dRdr = diff(R,r);
dRdt = diff(R,t);
n = cross(dRdr,dRdt);
curlF2 = subs(curlF1,[x,y,z],R);
integrand = dot(curlF2,n);
surfint = double(int(int(integrand,r,0,3),t,0,2*pi))

%9b.
syms x y z
z = 1-x-y;
fsurf(x,y,z);
hold on 
fimplicit3(x^2+y^2-9);
[x,y,z] = meshgrid(-5:1:5,-5:1:5,-8:1:10);
u = (x.^2).*z;
v = x.*(y.^2);
w = z.^2;
quiver3(x,y,z,u,v,w);
xlabel('x')
ylabel('y')
zlabel('z')
hold off

%9c.
%S
syms r t
x = r*cos(t)
y = r*sin(t)
z = 1-x-y
fsurf(x,y,z)
%C
syms q
x = 3*cos(q)
y = 3*sin(q)
z = 1-x-y
fplot3(x,y,z)
xlabel('x')
ylabel('y')
zlabel('z')
hold on 
[x,y,z] = meshgrid(-5:1:5);
u = (x.^2).*z;
v = x.*(y.^2);
w = z.^2;
quiver3(x,y,z,u,v,w);
hold off 
