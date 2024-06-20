%23.
syms x y t
F = [x*y,sin(y)]
r = [exp(t),exp(-t^2)]
Fpar = subs(F,[x,y],r)
integrand = dot(Fpar,diff(r,t))
integral = double(int(integrand,t,1,2))

%25
[x y] = meshgrid(-10:1:10)
u = x - y
v = x.*y
quiver(x,y,u,v)

syms x y t
F = [x-y,x*y]
r = [2*cos(t),2*sin(t)]
Fpar = subs(F, [x,y],r)
integrand = dot(Fpar,diff(r,t))
integral = double(int(integrand,t,0,3*pi/2))

%27a.
syms x y t
F = [exp(x-1),x*y]
r = [t^2,t^3]
Fpar = subs(F,[x,y],r)
integrand = dot(Fpar,diff(r,t))
integral = double(int(integrand,t,0,1))
%b.
[x,y] = meshgrid(-10:1:10)
u = exp(x-1)
v = x.*y
quiver(x,y,u,v)

%29
syms t
xt = cos(t)^3
yt = sin(t)^3
fplot(xt,yt,[-10,10])

syms x y t
f = (x^3)*(y^5)
r = [xt,yt]
fpar = subs(f,[x,y],r)
integrand = fpar*norm(diff(r,t))
integral = double(int(integrand,t,0,pi/2))


