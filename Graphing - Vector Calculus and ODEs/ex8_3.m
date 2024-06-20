%35.
syms w(t) x(t) y(t) z(t);
Y = [w; x; y; z];
A = [2,-2,2,1; -1,3,0,3; 0,0,4,-2; 0,0,2,-1];
F = [t*exp(t); exp(-t); exp(2*t); 1];
ode = diff(Y,t) == A*Y + F;
[ws(t), xs(t), ys(t), zs(t)] = dsolve(ode); 
ws(t) = simplify(ws(t))
xs(t) = simplify(xs(t)) 
ys(t) = simplify(ys(t)) 
zs(t) = simplify(zs(t))
