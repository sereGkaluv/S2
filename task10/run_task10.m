randn('state', 7);
    

lambda = 500; 
N = 30; 
rho = 1; % Size of family (parents)
sigmaMutation = 1;
sigmaStop = 10^(-5);
my = 1; % Size of parent population
differenceToOptimumGenerations = [];
[iterations, yOptimalVector, fitnessHistory, sigmaHistory, differenceToOptimumGenerations] = MyMyILaSiSelfAdaptationESwithNoise(sigmaMutation, sigmaStop, N, my, lambda, rho, 'QuadraticSphereModelWithNoise', 3000);
iterations
differenceToOptimumGenerations
%fitnessHistory(size(fitnessHistory, 2))

semilogy(1:iterations+1, fitnessHistory, '-', 'Color', 'blue', 'linewidth', 1);
hold on;
semilogy(1:iterations+1, sigmaHistory, '-', 'Color', 'green', 'linewidth', 1);
hold on;
semilogy(1:iterations, differenceToOptimumGenerations, '-', 'Color', 'red', 'linewidth', 1);


ylabel('Fitness', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);

title('My/MyI LaSi SA-ES with noise', 'FontSize', 12);
legend('FitnessHistory','\sigmaHistory','One generation distance change');