subplot(3,1,1)
for i = 0.5:3.5
    cond = [10 - 2*i, 2*i, 0]; 
    ts = [0,10];
    [t,y] = ode45(@epidemic, ts, cond);
    plot(t,y(:,1))
    hold on
end 
ylabel('s(t)')
title('SIR Model for Spread of Disease')
legend('$i_0=3$','$i_0=5$','$i_0=7$','$i_0=9$','Interpreter','latex')
grid() 
hold off

subplot(3,1,2)
for i = 0.5:3.5
    cond = [10 - 2*i, 2*i, 0]; 
    ts = [0,10];
    [t,y] = ode45(@epidemic, ts, cond);
    plot(t,y(:,2))
    hold on
end 
ylabel('i(t)')
grid() 
hold off

subplot(3,1,3)
for i = 0.5:3.5
    cond = [10 - 2*i, 2*i, 0]; 
    ts = [0,10];
    [t,y] = ode45(@epidemic, ts, cond);
    plot(t,y(:,3))
    hold on
end 
ylabel('r(t)')
xlabel('t')
grid() 
hold off

function odes = epidemic(t,y)  
k1 = 0.2
k2 = 0.7
odes = [-k1*y(1)*y(2); 
        -k2*y(2) + k1*y(1)*y(2);
        k2*y(2)] 
end
