subplot(2,2,1)
means = zeros(1,1000);
for n = 1:1000
    X = randn(1,n);
    means(n) = mean(X);
end
plot(means,'.','Color',[0 0.4470 0.7410])
title('$X_i \sim \perp \!\!\! \perp N(0,1) \quad i=\{1,\cdots ,n\}$','Interpreter','latex')

subplot(2,2,2)
means = zeros(1,1000);
for n = 1:1000
    X = random('poiss',5,1,n);
    means(n) = mean(X);
end
plot(means,'.','Color',[0.8500 0.3250 0.0980])
title('$X_i \sim \perp \!\!\! \perp Pois(5) \quad i=\{1,\cdots ,n\}$','Interpreter','latex')

subplot(2,2,3)
means = zeros(1,1000);
for n = 1:1000
    X = random('gamma',1,2,1,n);
    means(n) = mean(X);
end
plot(means,'.','Color',[0.9290 0.6940 0.1250])
title('$X_i \sim \perp \!\!\! \perp Gamma(1,2) \quad i=\{1,\cdots ,n\}$','Interpreter','latex')

subplot(2,2,4)
means = zeros(1,1000);
for n = 1:1000
    X = random('unif',0,1,1,n);
    means(n) = mean(X);
end
plot(means,'.','Color',[0.4940 0.1840 0.5560])
title('$X_i \sim \perp \!\!\! \perp U(0,1) \quad i=\{1,\cdots ,n\}$','Interpreter','latex')
sgtitle('Demonstration of the Law of Large Numbers','Interpreter','latex')