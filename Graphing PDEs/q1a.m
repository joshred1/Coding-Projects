syms t
fplot(abs(t-3),[-10,10])
set(gca,'XTick',[], 'YTick', [])
hold on
fplot(abs(t+3))
xlabel('t','Interpreter','latex' )
ylabel('x','Interpreter','latex')
line([0,0], [-20,20], 'Color', 'k'); % Draw line for Y axis.
line([-20,20], [0,0], 'Color', 'k'); % Draw line for X axis.
hold off