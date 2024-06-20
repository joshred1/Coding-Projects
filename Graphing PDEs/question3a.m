u = @(x,y) x-2.*x.^2 + 2.*y.^2;
v = @(x,y) y-4.*x.*y;

figure
fcontour(u,[-10 10 -10 10],'linewidth',1.2,'MeshDensity',500,'LevelStep',20)
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
title('Real and Imaginary Contours of $f = u+iv$','Interpreter','latex')
hold on 
fcontour(v,'-.',[-10 10 -10 10],'linewidth',1.2,'MeshDensity',500,'LevelStep',20)
grid on
box on
colorbar
hold off
colormap jet