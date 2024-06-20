cond = [-8, 8, 27]; 
ts = [0,100];
[t,x] = ode45(@lorenz, ts, cond);

figure(1)
subplot(3,1,1) 
plot(t,x(:,1)) 
ylabel('x(t)') 
subplot(3,1,2) 
plot(t,x(:,2)) 
ylabel('y(t)') 
subplot(3,1,3) 
plot(t,x(:,3)) 
ylabel('z(t)') 
xlabel('t') 

figure(2)
plot3(x(:,1),x(:,2),x(:,3)) 
xlabel('x(t)') 
ylabel('y(t)') 
zlabel('z(t)') 
grid() 

function odes = lorenz(t,x)  
s = 10; 
b = 8/3; 
p = 28;  
odes = [-s*x(1) + s*x(2); 
        p*x(1) - x(2) - x(1)*x(3); 
        -b*x(3) + x(1)*x(2)]; 
end
