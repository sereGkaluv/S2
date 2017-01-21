%(1+1)ES
yp = ones(1, 100);
N = size(yp, 2);
sigmaStopCondition = 10^-5;
sigma = 1;

[numberOfIteration, yOffsprings, offspringFitness, offspringFitnessHistory] = OnePlusOne_ES_Task3('calcFitness', yp, sigma, sigmaStopCondition, N, 10);
semilogy(offspringFitnessHistory, '-', 'Color', 'blue', 'linewidth', 1);

xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('1/5 Rule', 'FontSize', 12);
legend('Fitness');
