%% Vector field in the plane
% Use quiver to display an arrow at each data point in x and y such that the arrow direction and length represent the corresponding values in u and v.

[x,y] = meshgrid(0:0.2:2,0:0.2:2);
u = cos(x).*y;
v = sin(x).*y;
figure
quiver(x,y,u,v)

%% Gradient vector field
% Plotting the gradient field of function f(x,y) with contour lines

syms x y
f = -(sin(x) + sin(y))^2;
g = gradient(f, [x, y])


[X, Y] = meshgrid(-1:.1:1,-1:.1:1);
Z= -(sin(X) + sin(Y))^2;
figure
contour(X,Y,Z)
hold on
G1 = subs(g(1), [x y], {X,Y});
G2 = subs(g(2), [x y], {X,Y});
quiver(X, Y, G1, G2)
hold off

%% Parameterised curve
% Plotting a paramaterised curve

syms t

tmax=3;
tmin=-1;

xt = sin(t);
yt = cos(t);
zt = t;

fplot3(xt,yt,zt,[tmin,tmax])

%% Line integer of a scalar field 
% We need to write function f in terms of the parameteristaion. We also need to multiply by the length of the tanget vector of the parametrised curve
syms x y z t

f = y^2-x
tcube = [t,t^2,t^3]

fpar = subs(f,[x,y,z],tcube)
integrand= fpar*norm(diff(tcube,t))
integral=double(int(integrand,t,0,1))

%% Line integral over a vector field

realdot=@(u,v) u*transpose(v)

syms x y z t
F = [y^2,sqrt(4-z^2),x]
tcube = [t,t^2,t^3]
Fpar = subs(F,[x,y,z],tcube)
integrand= realdot(Fpar,diff(tcube,t))
integral=double(int(integrand,t,0,1))

%% Demonstrating the Fundamental theorem of Calculus
% We first compute directly as a line integral of grad(f) (to get ans1). We then compute using the Fundamental theorem of line integrals (to get ans2)

realdot=@(u,v) u*transpose(v)

syms x y z t %setting up our variables
tcube = [t,t^2,t^3] % a parameterised curve

f = x*y + cos(y*z) + exp(x*z) %the scalar function
H = jacobian(f,[x,y,z]) %the first order partial derivatives

Hpar = subs(H,[x,y,z],tcube) %substituting the parameterisation
integrand = realdot(Hpar,diff(tcube,t)) %what goes inside the integral
ans1 = int(integrand,t,0,1) %The line integral of grad(f) computed directly


A = subs(tcube,t,0) %the initial point
B = subs(tcube,t,1) %the terminal point 
ans2 = subs(f,[x,y,z],B) - subs(f,[x,y,z],A) %f(B)-f(A)

double(ans1-ans2) % showing the methods give the same answer


%% Testing whether vector field is conservative in dimension 2
% We know that the vector field F=<P,Q> is conservative if and only if dQ/dx-dP/dy=0. 
syms x y

F = [y^2, 4+x^2]
diff(F(2),x)-diff(F(1),y)

%(not zero in this example so not conservative)


%% Computing curl and testing whether a vector field is conservative in dimension 3
% We know that the vector field F is conservative if and only if curl(F)=0. Thankfully there is a curl function already defined which does all the hard work.  

syms x y z
curl([x^3, y^3*x, z^3], [x, y, z])


%(not zero in this example so not conservative)

syms x y z
curl([x^2,y^2,4*z],[x,y,z])

%(zero in this example so it is conservative)

%% Constructing a potential vector field of a conservative vector field
% Given a conservative vector field F there are many potential fields f
% such that grad(f)=F. However they all differ a constant. Specifying this
% constant is the same as specifying an integration base point. At this
% point the potential field will be zero. If the vector field is not
% conservative (or even just matlab can't verify it is) then the output
% will be NaN

syms x y z
P = potential([x, y, z*exp(z)], [x y z], [0 0 0])
%Compute the potential of this vector field specifying the integration base point as [0 0]


P = potential([y, x], [x y], [1 2])
%Compute the potential of this vector field specifying the integration base point as [1 2]


%% Divergence of a vector field
% Computes the divergence of a vector field, ie.e div(F)
syms x y z

F = [y^2*x,sqrt(4-z^2),x]

g=diff(F(1),x)+diff(F(2),y)+diff(F(3),z)




%% Surface integral for area or a scalar function

syms x y z p t
ellipsoid=[2*sin(p)*cos(t),3*sin(p)*sin(t),cos(p)]

pmin=0
pmax=pi
tmin=0
tmax=2*pi

simplify(subs((x^2/4)+(y^2/9)+z^2,[x,y,z],ellipsoid))% to check really a parametrisation


ezsurf(ellipsoid(1),ellipsoid(2),ellipsoid(3),[0,pi,0,2*pi])% to draw the surface

realdot = @(u,v) u*transpose(v);
veclength = @(u) sqrt(realdot(u,u));

ndS=cross(diff(ellipsoid,p),diff(ellipsoid,t))
surffactor =simplify(veclength(ndS))
integrand =matlabFunction(surffactor)% because we need afunction handle for integration and currently we have a symbolic expression

integral2(integrand,0.0,pi,0.0,2*pi)

f=x*x+2*y %the scalar function
fpar=subs(f,[x,y,z],ellipsoid) %as we need in terms of the parameterisation
integrand =matlabFunction(surffactor*fpar)

integral2(integrand,0.0,pi,0.0,2*pi)



%% Divergence theorem
% Here we will compute the flux of F over the surface of this ellipsoid
% both directly and via the divergence theorem

F = [x,y^2,z]
ndS = cross(diff(ellipsoid,p),diff(ellipsoid,t))

%We can check that we have the outward normal by setting $p=\pi/2$ and $t=0$,
%giving us the point of the ellipsoid that is on the positive x-axis. 
%The outward normal should point in the positive x direction.

subs(ndS,[p,t],[pi/2,0])
Fpar = subs(F,[x,y,z],ellipsoid)
% evaluate F in terms of the parameters.
integrand =matlabFunction(realdot(Fpar,ndS))
flux = integral2(integrand,pmin,pmax,tmin,tmax)

%Now for the integral of the divergence...
syms r

solid = r*ellipsoid
rmin=0
rmax=1

g=diff(F(1),x)+diff(F(2),y)+diff(F(3),z)
gpar=subs(g,[x,y,z], solid)


volfactor=simplify(det(jacobian(solid,[r,p,t])))
%Recall that to integrate in the new coord, we are going to have to insert a scale factor, the absolute value of the determinant of the Jacobian matrix of the change of variables. 
%It may be easier to leave off the absolute value at first, and then change the sign if the scale factor comes out negative.


fun=matlabFunction(gpar*abs(volfactor)) %variables (p,r,t)
q = integral3(fun,pmin,pmax,rmin,rmax,tmin,tmax) 


%% Double integral  over a triangle
% Integrate over the triangular region

syms x y %declare variables x and y

fun = @(x,y) 1./( sqrt(x + y) .* (1 + x + y).^2 )
% creates a function in two variables


ymax = @(x) 1 - x;
q = integral2(fun,0,1,0,ymax) 