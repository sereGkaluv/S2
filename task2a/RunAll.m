addpath ..\fitness
%(1+1)ES
yp = [10,10,10,10,10,10,10,10,10,10];
sigma = 1;
[numberOfIteration, yOffsprings, offspringFitness, offspringFitnessHistory] = OnePlusOne_ES('sphereFunction', yp, sigma, 1000);
numberOfIteration
yOffsprings
offspringFitness
semilogy(offspringFitnessHistory, '-', 'Color', 'blue', 'linewidth', 3);

xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('(1+1) - ES Cubic', 'FontSize', 12);
legend('Fitness');
