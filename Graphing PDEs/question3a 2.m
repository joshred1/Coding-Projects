u = @(y) exp(2).*cos(y);
v = @(y) exp(2).*sin(y);

figure
fplot(u);
set(gca,'XTick',-2*pi:pi/2:2*pi); 
set(gca,'XTickLabel',{'-2\pi','-3\pi/2','-\pi','-\pi/2','0','\pi/2','\pi','3\pi/2','2\pi'});
hold on 
fplot(v)
hold off
xlabel('y');
ylabel('w(y)');
legend('$\Re(w)$','$\Im(w)$','Interpreter','Latex')

figure
fimplicit(@(x,y) x.^2+y.^2-exp(4),[-10 10])
xlabel('$\Re(w)$','Interpreter','Latex');
ylabel('$\Im(w)$','Interpreter','Latex');
