subplot(3,1,1)
[x,y] = meshgrid(-200:50:200)
u = -4.*y; 
v = x - 3.*y;
quiver(x,y,u,v)
hold on
for i = -80:20:-10
    for j = -60:10:60
        cond = [1*i, 1*j]; 
        xs = [0,100];
        [x,y] = ode45(@alpha1, xs, cond);
        plot(y(:,1),y(:,2))
    end
end
for i = 10:20:80
    for j = -60:10:60
        cond = [1*i, 1*j]; 
        xs = [0,100];
        [x,y] = ode45(@alpha1, xs, cond);
        plot(y(:,1),y(:,2))
    end
end
xlim([-150 150])
ylim([-150 150])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+12,ylimt(2)-15,'\alpha = 3')
hold off

subplot(3,1,2)
[x,y] = meshgrid(-200:50:200)
u = -4.*y; 
v = x - 4.*y;
quiver(x,y,u,v)
hold on
for i = -80:20:-10
    for j = -60:10:60
        cond = [1*i, 1*j]; 
        xs = [0,100];
        [x,y] = ode45(@alpha2, xs, cond);
        plot(y(:,1),y(:,2))
    end
end
for i = 10:20:80
    for j = -60:10:60
        cond = [1*i, 1*j]; 
        xs = [0,100];
        [x,y] = ode45(@alpha2, xs, cond);
        plot(y(:,1),y(:,2))
    end
end
xlim([-150 150])
ylim([-150 150])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+12,ylimt(2)-15,'\alpha = 4')
ylabel('y_2')
hold off

subplot(3,1,3)
[x,y] = meshgrid(-200:50:200)
u = -4.*y; 
v = x - 5.*y;
quiver(x,y,u,v)
hold on
for i = -80:20:-10
    for j = -60:10:60
        cond = [1*i, 1*j]; 
        xs = [0,100];
        [x,y] = ode45(@alpha3, xs, cond);
        plot(y(:,1),y(:,2))
    end
end
for i = 10:20:80
    for j = -60:10:60
        cond = [1*i, 1*j]; 
        xs = [0,100];
        [x,y] = ode45(@alpha3, xs, cond);
        plot(y(:,1),y(:,2))
    end
end
xlim([-150 150])
ylim([-150 150])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+12,ylimt(2)-15,'\alpha = 5')
xlabel('y_1')
hold off

function odes1 = alpha1(x,y)
alpha = 3
odes1 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end

function odes2 = alpha2(x,y)
alpha = 4
odes2 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end

function odes3 = alpha3(x,y)
alpha = 5
odes3 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end