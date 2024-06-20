for t = [ 0.01 0.05 0.1 1 2 5]
       hold on
       ylim([0 0.65])
       xlim([-7 7])
       fplot(exp(25*t)*(cosh(5*x)-exp(5*x)*erf((10*t+x)/sqrt(4*t))/2-exp(-5*x)*erf((10*t-x)/sqrt(4*t))/2),[-4,4])
end
xlabel('x'); ylabel('u(x,t)'); title('Analytical Solution');
legend('time = 0.01','time = 0.05','time = 0.1')
hold off