%31. 
syms u v
x = u
y = v
z = sqrt(1-v^2)
fsurf(x,y,z,[0,2,-1,1])
xlabel('x')
ylabel('y')
zlabel('z')

hold on 

fsurf(x,y,0,[0,2,-1,1])

syms r t
y = r*cos(t)
z = r*sin(t)
x = 0
fsurf(x,y,z,[0,1,0,pi])

syms r t
y = r*cos(t)
z = r*sin(t)
x = 2
fsurf(x,y,z,[0,1,0,pi])

[x,y,z] = meshgrid(-2:0.5:2)
r = x.^2
s = y.^2
t = z.^2
quiver3(x,y,z,r,s,t)

hold off

%33.
syms x y 
z = 3 - 2*x^2 - y^2
fsurf(x,y,z)
xlabel('x')
ylabel('y')
zlabel('z')
hold on
fsurf(x,y,0)
hold off

syms r t
x = r*cos(t);
y = sqrt(2)*r*sin(t); 
z = 3 - 2*r^2;
R = [x,y,z];
dRdr = diff(R,r);
dRdt = diff(R,t);
integrand = x^2*y^2*z^2*norm(cross(dRdr,dRdt));
surfint = double(int(int(integrand,r,0,sqrt(3/2)),t,0,2*pi))
