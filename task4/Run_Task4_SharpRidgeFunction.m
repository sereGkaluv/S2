%(1+1)ES
N = 30;
d = 10;
yp(1:N) = 1; 
sigmaStopCondition = 10^-5;
sigma = 1;
MaxLoops = 5000;

[yParent, sigmaHistory, offspringFitnessHistory] = OnePlusOne_ES_Task4('sharpRidgeFunction', yp, sigma, sigmaStopCondition, d, MaxLoops);

subplot(2,1,1)
semilogy(offspringFitnessHistory,'Color', 'blue');
hold on;
semilogy(sigmaHistory,'Color', 'green');
xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('Semilogarithmic plot of (1+1)-ES with 1/5 Rule on Sharp Ridge Function with d = 10', 'FontSize', 12);
legend('Fitness Value','\sigmaHistory');


subplot(2,1,2)
plot(offspringFitnessHistory, 'Color', 'blue');
hold on;
plot(sigmaHistory,'Color', 'green');
xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('Linear plot of (1+1)-ES with 1/5 Rule on Sharp Ridge Function with d = 10', 'FontSize', 12);
legend('Fitness-1/5 Rule','\sigmaHistory');