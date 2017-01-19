%(1+1)ES
%yp = ones(1, 100);
yp = [10,10,10,10,10,10,10,10,10,10]; 
sigmaStopCondition = 10^-5;
sigma = 1;
MaxLoops = 2000;

[yOffsprings, sigmaHistory, offspringFitnessHistory] = OnePlusOne_ES_Task3('calcFitness', yp, sigma, sigmaStopCondition, MaxLoops);
[numberOfIteration, yOffsprings, offspringFitness, offspringFitnessHistoryOld] = OnePlusOne_ES('calcFitness', yp, sigma, MaxLoops);

semilogy(offspringFitnessHistory,'Color', 'blue');
hold on;
semilogy(sigmaHistory,'Color', 'green');
hold on;
semilogy(offspringFitnessHistoryOld,'Color', 'red');

xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('1/5 Rule', 'FontSize', 12);
legend('Fitness-1/5 Rule','\sigmaHistory','\offspringFitnessHistoryOld');

