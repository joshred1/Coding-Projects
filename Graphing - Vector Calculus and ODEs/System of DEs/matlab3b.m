for i = 0:1:20
    for j = 0:1:20
        cond = [0.05*i-0.089, 0.1*j-0.089]; 
        ts = [0,200];
        [t,y] = ode45(@species, ts, cond);
        plot3(y(:,1),y(:,2),t(:)) 
        hold on
    end
end 
for i = 0:1:30
    for j = 0:1:30
        cond = [1*i, 1*j]; 
        ts = [0,200];
        [t,y] = ode45(@species, ts, cond);
        plot3(y(:,1),y(:,2),t(:)) 
    end
end 
xlim([-0.01,2.5])
ylim([-0.01,4.5])
zlim([0,80])
xlabel('y_1') 
ylabel('y_2')
zlabel('t')
grid() 
text(1,1,80,'(1,1,t)')
text(1.5,0,80,'(1.5,0,t)')
text(0,4,80,'(0,4,t)')
text(0,0,80,'(0,0,t)')
hold off

function odes = species(t,y)  
a1 = 1.5; 
a2 = 2; 
b1 = 1;
b2 = 0.5;
c1 = 0.5;
c2 = 1.5;
odes = [y(1)*(a1-b1*y(1)-c1*y(2)); 
        y(2)*(a2-b2*y(2)-c2*y(1))] 
end
