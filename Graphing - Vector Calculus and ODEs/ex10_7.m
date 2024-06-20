%17
syms t 
xt = t*cos(t)
yt = t
zt = t*sin(t)
fplot3(xt,yt,zt,[0,100])
%II

%%dr = diff(r,t)
%%fplot3(dr(1),dr(2),dr(3))

%19
syms t
xt = t
yt = 1/(1+t^2)
zt = t^2
fplot3(xt,yt,zt,[-100000000000,100000000000])
%V

%21
syms t
xt = cos(8*t)
yt = sin(8*t)
zt = exp(0.8*t)
fplot3(xt,yt,zt,[0,10])
%III

%55
syms t s
xt = t*cos(t)
yt = t
zt = t*sin(t)
fplot3(xt,yt,zt,[-10,10])
hold on 
dxt = gradient(xt)
dyt = gradient(yt)
dzt = gradient(zt)
t = 0
dxt = s*subs(dxt) - pi
dyt = s*subs(dyt) + pi
dzt = s*subs(dzt) + 0
fplot3(dxt,dyt,dzt,[-10,10])
xlabel('x')
ylabel('y')
zlabel('z')
hold off 

