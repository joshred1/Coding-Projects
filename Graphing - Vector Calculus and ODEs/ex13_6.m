%1.
syms u v 
x = u+v;
y = 3-v;
z = 1+4*u+5*v;
fsurf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')

%2.
syms u v
x = 2*sin(u);
y = 3*cos(u);
z = v;
fsurf(x,y,z,[-10,10,0,2]);
xlabel('x')
ylabel('y')
zlabel('z')

%3. 
syms s t
x = s;
y = t ;
z = t^2-s^2;
fsurf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')

%4.
syms s t
x = s*sin(2*t);
y = s^2;
z = s*cos(2*t);
fsurf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')

%5.
syms u v 
x = u^2;
y = v^2;
z = u+v;
fsurf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')

%6.
syms u v
x = u;
y = v^3;
z = -v;
fsurf(x,y,z,[-2,2,-2,2]);
xlabel('x')
ylabel('y')
zlabel('z')

%7.
syms u v
x = u*cos(v);
y = u*sin(v);
z = u^5;
fsurf(x,y,z,[-1,1,0,2*pi]);
xlabel('x')
ylabel('y')
zlabel('z')

%8.
syms u v
x = u;
y = sin(u+v);
z = sin(v);
fsurf(x,y,z,[-pi,pi,-pi,pi]);
xlabel('x')
ylabel('y')
zlabel('z')

%9.
syms u v
x = sin(v);
y = cos(u)*sin(4*v);
z = sin(2*u)*sin(4*v);
fsurf(x,y,z,[0,2*pi,-pi/2,pi/2]);
xlabel('x')
ylabel('y')
zlabel('z')

%10.
syms u v
x = sin(u);
y = cos(u)*sin(v);
z = sin(v);
fsurf(x,y,z,[0,2*pi,0,2*pi]);
xlabel('x')
ylabel('y')
zlabel('z')

%11.
syms u v
x = u*cos(v);
y = u*sin(v);
z = v;
fsurf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')
%IV

%12.
syms u v 
x = u*cos(v);
y = u*sin(v);
z = sin(u);
fsurf(x,y,z,[-pi,pi]);
xlabel('x')
ylabel('y')
zlabel('z')
%I

%13.
syms u v 
x = sin(v);
y = cos(u)*sin(2*v);
z = sin(u)*sin(2*v);
fsurf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')
%II

%14
syms u v
x = (1-u)*(3+cos(v))*cos(4*pi*u);
y = (1-u)*(3+cos(v))*sin(4*pi*u);
z = 3*u+(1-u)*sin(v);
fsurf(x,y,z,[-1,3,-1,3]);
xlabel('x')
ylabel('y')
zlabel('z')
%III

%25.
syms u v 
x = u;
y = exp(-u)*cos(v);
z = exp(-u)*sin(v);
fsurf(x,y,z,[0,3,0,2*pi]);
xlabel('x')
ylabel('y')
zlabel('z')

%26.
syms u v
x = (4*u^2-u^4)*cos(v);
y = u;
z = (4*u^2-u^4)*sin(v);
fsurf(x,y,z,[-2,2,0,2*pi]);
xlabel('x')
ylabel('y')
zlabel('z')

%28.
syms r t
x = 2*cos(t) + r*cos(t/2);
y = 2*sin(t) + r*cos(t/2);
z = r*sin(t/2);
fsurf(x,y,z,[-0.5,0.5,0,2*pi]);
xlabel('x')
ylabel('y')
zlabel('z')

%29.
syms u v x y z
X = u+v;
Y = 3*u^2;
Z = u-v;
r = [X,Y,Z];
fsurf(X,Y,Z);
xlabel('x')
ylabel('y')
zlabel('z')
ru = diff(r,u);
rv = diff(r,v);
n = cross(ru,rv);
n1 = subs(n,u,1);
hold on
fimplicit3(dot(n1,[x,y,z]-[2,3,0])); 
hold off

%31.
syms u v x y z
X = u*cos(v);
Y = u*sin(v);
Z = v;
r = [X,Y,Z];
fsurf(X,Y,Z,[-10,10]);
xlabel('x')
ylabel('y')
zlabel('z')
hold on
ru = diff(r,u);
rv = diff(r,v);
n = cross(ru,rv);
n1 = subs(n,[u,v],[1,pi/3]);
X1 = subs(X,[u,v],[1,pi/3]);
Y1 = subs(Y,[u,v],[1,pi/3]);
Z1 = subs(Z,[u,v],[1,pi/3]);
fimplicit3(dot(n1,[x,y,z]-[X1,Y1,Z1]),[-10,10]);
scatter3(X1,Y1,Z1,50,[1,0,0],'filled')
hold off

%33
syms x y z
fimplicit3(3*x+2*y+z-6,[0,10])
xlabel('x')
ylabel('y')
zlabel('z')

%35.
r = sqrt(3);
t = linspace(0, 2*pi, 100);
[t,r] = meshgrid(t,r);
[x,y,z] = pol2cart(t,r,z);
mesh(x,y,z)
fimplicit3(x+2*y+3*z-1);
xlabel('x')
ylabel('y')
zlabel('z')

%47. 
syms r t 
x = r*cos(t);
y = r*sin(t);
z = exp(-x^2-y^2);
R = [x,y,z];
dRdr = diff(R,r);
dRdt = diff(R,t);
integrand = norm(cross(dRdr,dRdt));
area = double(int(int(integrand,r,0,2),t,0,2*pi))

%53.
syms u v 
x = 1*sin(u)*cos(v);
y = 2*sin(u)*sin(v);
z = 3*cos(u);
fsurf(x,y,z,[0,pi,0,2*pi]);
xlabel('x')
ylabel('y')
zlabel('z')

%55. 
syms x y z 
fimplicit3(x^2+y^2+z^2-4*z);
hold on 
fimplicit3(x^2+y^2-z);
hold off
xlabel('x')
ylabel('y')
zlabel('z')
