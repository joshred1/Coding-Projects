subplot(3,1,1)
[x,y] = meshgrid(-30:2:30)
u = -4.*y; 
v = x + 5.*y;
quiver(x,y,u,v)
hold on
for i = -10:2:10
    for j = -10:2:10
        cond = [1*i, 1*j]; 
        xs = [0,2000];
        [x,y] = ode45(@alpha1, xs, cond);
        plot(y(:,1),y(:,2))
    end
end 
xlim([-10 10])
ylim([-10 10])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+1,ylimt(2)-1,'\alpha = -5')
hold off

subplot(3,1,2)
[x,y] = meshgrid(-30:2:30)
u = -4.*y; 
v = x + 4.*y;
quiver(x,y,u,v)
hold on
for i = -10:2:10
    for j = -10:2:10
        cond = [1*i, 1*j]; 
        xs = [0,2000];
        [x,y] = ode45(@alpha2, xs, cond);
        plot(y(:,1),y(:,2))
    end
end 
xlim([-10 10])
ylim([-10 10])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+1,ylimt(2)-1,'\alpha = -4')
ylabel('y2')
hold off

subplot(3,1,3)
[x,y] = meshgrid(-30:2:30)
u = -4.*y; 
v = x + 3.*y;
quiver(x,y,u,v)
hold on
for i = -10:2:10
    for j = -10:2:10
        cond = [1*i, 1*j]; 
        xs = [0,2000];
        [x,y] = ode45(@alpha3, xs, cond);
        plot(y(:,1),y(:,2))
    end
end 
xlim([-10 10])
ylim([-10 10])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+1,ylimt(2)-1,'\alpha = -3')
xlabel('y1')
hold off

function odes1 = alpha1(x,y)
alpha = -5
odes1 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end

function odes2 = alpha2(x,y)
alpha = -4
odes2 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end

function odes3 = alpha3(x,y)
alpha = -3
odes3 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end