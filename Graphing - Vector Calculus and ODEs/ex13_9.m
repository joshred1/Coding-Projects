%9.
syms x y z 
fimplicit3(x^8+y^8+z^8-8);
hold on
[x,y,z] = meshgrid(-2:0.25:2)
syms u v w
u = x.^2.*sin(y);
v = x.*cos(y);
w = -x.*z.*sin(y);
quiver3(x,y,z,u,v,w)
xlabel('x')
ylabel('y')
zlabel('z')
hold off

%21.
[x,y] =meshgrid(-10:1:10)
u = x.*y;
v = x+y.^2;
quiver(x,y,u,v)

%13.
syms x y z
F = [x*sqrt(x^2+y^2+z^2),y*sqrt(x^2+y^2+z^2),z*sqrt(x^2+y^2+z^2)]
divergence(F)