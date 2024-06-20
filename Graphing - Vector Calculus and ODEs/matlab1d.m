cond = [9,1,0]; 
ts = [0,10];
[t,y1] = ode45(@epidemic1, ts, cond);
plot(t,y1(:,2))
ylabel('i(t)')
xlabel('t')
title('SIR Model for Spread of Disease')
grid()
hold on
[t,y2] = ode45(@epidemic2, ts, cond);
plot(t,y2(:,2))
[t,y3] = ode45(@epidemic3, ts, cond);
plot(t,y3(:,2))
[t,y4] = ode45(@epidemic4, ts, cond);
plot(t,y4(:,2))
[t,y5] = ode45(@epidemic5, ts, cond);
plot(t,y5(:,2))
[t,y6] = ode45(@epidemic6, ts, cond);
plot(t,y6(:,2))
legend('$k_1=0.8$','$k_1=0.9$','$k_1=1$','$k_1=2$','$k_1=5$','$k_1=10$','Interpreter','latex')
hold off

