randn('state', 7);
    

lambda = 20; 
N = 30; 
rho = 1; % Size of family (parents)
sigmaMutation = 1;
sigmaStop = 10^(-5);
my = ones(N,1)*10; % Size of parent population

[iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationESwithNoise(sigmaMutation, sigmaStop, N, my, lambda, rho, 'QuadraticSphereModelWithNoise', 3000);
iterations
%fitnessHistory(size(fitnessHistory, 2))

semilogy(1:iterations+1, fitnessHistory, '-', 'Color', 'blue', 'linewidth', 2);
hold on;
semilogy(1:iterations+1, sigmaHistory, '-', 'Color', 'green', 'linewidth', 2);

ylabel('Fitness', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);

title('My/MyI LaSi SA-ES with noise', 'FontSize', 12);
legend('FitnessHistory','\sigmaHistory');