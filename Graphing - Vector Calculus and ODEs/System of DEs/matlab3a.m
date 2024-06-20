for i = 0:1:10
    for j = 0:1:10
        cond = [0.1*i, 0.1*j]; 
        ts = [0,1000];
        [t,y] = ode45(@species, ts, cond);
        plot(y(:,1),y(:,2)) 
        hold on
    end
end 
for i = 0:1:10
    for j = 0:1:10
        cond = [1*i, 1*j]; 
        ts = [0,500];
        [t,y] = ode45(@species, ts, cond);
        plot(y(:,1),y(:,2)) 
    end
end 
xlabel('y_1') 
ylabel('y_2')
title('Phase Portrait of Competing Species Model')
grid() 
plot(1,1,'-o')
plot(1.5,0,'-o')
plot(0,4,'-o')
plot(0,0,'-o')
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
