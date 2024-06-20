subplot(3,1,1)
[x,y] = meshgrid(-30:5:30)
u = -4.*y; 
v = x + 1.*y;
quiver(x,y,u,v)
hold on
for i = -20:5:20
    for j = -20:5:20
        cond = [1*i, 1*j]; 
        xs = [0,2];
        [x,y] = ode45(@alpha1, xs, cond);
        plot(y(:,1),y(:,2)) 
    end
end
xlim([-30 30])
ylim([-30 30])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+2,ylimt(2)-5,'\alpha = -1')
hold off

subplot(3,1,2)
[x,y] = meshgrid(-30:5:30)
u = -4.*y; 
v = x + 0.*y;
quiver(x,y,u,v)
hold on
for i = -20:5:20
    for j = -20:5:20
        cond = [1*i, 1*j]; 
        xs = [0,2];
        [x,y] = ode45(@alpha2, xs, cond);
        plot(y(:,1),y(:,2)) 
    end
end
xlim([-30 30])
ylim([-30 30])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+2,ylimt(2)-5,'\alpha = 0')
ylabel('y2')
hold off

subplot(3,1,3)
[x,y] = meshgrid(-30:5:30)
u = -4.*y; 
v = x - 1.*y;
quiver(x,y,u,v)
hold on
for i = -20:5:20
    for j = -20:5:20
        cond = [1*i, 1*j]; 
        xs = [0,2];
        [x,y] = ode45(@alpha3, xs, cond);
        plot(y(:,1),y(:,2)) 
    end
end
xlim([-30 30])
ylim([-30 30])
ylimt = get(gca,'ylim');
xlimt = get(gca,'xlim')
text(xlimt(1)+2,ylimt(2)-3,'\alpha = 1')
xlabel('y1')
hold off

function odes1 = alpha1(x,y)
alpha = -1
odes1 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end

function odes2 = alpha2(x,y)
alpha = 0
odes2 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end

function odes3 = alpha3(x,y)
alpha = 1
odes3 = [-4*y(2); 
        y(1) +  alpha*y(2)] 
end