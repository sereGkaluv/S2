%(1+1)ES
yp = [10,10,10,10,10,10,10,10,10,10]; 
sigmaStopCondition = 10^-5;
sigma = 1;
MaxLoops = 2000;

[yParent, sigmaHistory, offspringFitnessHistory] = OnePlusOne_ES_Task3('sphereFunction', yp, sigma, sigmaStopCondition, MaxLoops);
[numberOfIteration, yParent, offspringFitness, offspringFitnessHistoryOld] = OnePlusOne_ES('sphereFunction', yp, sigma, MaxLoops);

semilogy(offspringFitnessHistory,'Color', 'blue');
hold on;
semilogy(sigmaHistory,'Color', 'green');
hold on;
semilogy(offspringFitnessHistoryOld,'Color', 'red');

xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('1/5 Rule', 'FontSize', 12);
legend('Fitness-1/5 Rule','\sigmaHistory','\offspringFitnessHistoryOld');

