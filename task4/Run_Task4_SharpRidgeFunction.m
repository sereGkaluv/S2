%(1+1)ES
N = 30;
d = 1;
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
title('1/5 Rule', 'FontSize', 12);
legend('Fitness-1/5 Rule','\sigmaHistory');

subplot(2,1,2)
plot(offspringFitnessHistory, 'Color', 'blue');
hold on;
plot(sigmaHistory,'Color', 'green');

xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('1/5 Rule', 'FontSize', 12);
legend('Fitness-1/5 Rule','\sigmaHistory');