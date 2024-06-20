%15
syms x y t
F = [y^2*exp(x),x^2*exp(y)];
r1 = [-1+2*t,1];
Fpar1 = subs(F,[x,y],r1);
integrand1 = dot(Fpar1, diff(r1,t));
integral1 = int(integrand1,t,0,1);
r2 = [t,2-t^2];
Fpar2 = subs(F,[x,y],r2);
integrand2 = dot(Fpar2, diff(r2,t));
integral2 = int(integrand2,t,1,-1);
integral = integral1 + integral2

greensthm = int(int(diff(F(2),x)-diff(F(1),y),y,1,2-x^2),x,-1,1)
