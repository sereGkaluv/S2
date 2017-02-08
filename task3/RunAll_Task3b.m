%(1+1)ES
yp = ones(1, 100); %100 dimensions = N
sigmaStopCondition = 10^-5;
sigma = 1;
randn('state', 7); 

[yParent, sigmaHistory, offspringFitnessHistory] = OnePlusOne_ES_Task3('sphereFunction', yp, sigma, sigmaStopCondition);

semilogy(offspringFitnessHistory,'Color', 'blue');
hold on;
semilogy(sigmaHistory,'Color', 'green');

xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('1/5 Rule', 'FontSize', 12);
legend('Fitness-1/5 Rule','\sigmaHistory');
offspringFitnessHistory(end) %last entry --> best offspring

