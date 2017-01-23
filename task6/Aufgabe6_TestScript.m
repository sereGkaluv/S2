randn('state', 7);
    
my = 3; % Size of parent population
lambda = 10; % Skript, s. 95 Size of offspring population, lambda >= my Skript, s. 96
N = 30; % Skript, s. 95
rho = 1; % Size of family (parents)
sigmaMutation = 1;
sigmaStop = 10^(-5);

[iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, 'QuadraticSphereModel', 1500);
iterations
fitnessHistory(size(fitnessHistory, 2))

semilogy(1:iterations+1, fitnessHistory, '-', 'Color', 'blue', 'linewidth', 2);
hold on;
semilogy(1:iterations+1, sigmaHistory, '-', 'Color', 'green', 'linewidth', 2);

ylabel('Fitness', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);

title('My/MyI LaSi SA-ES', 'FontSize', 12);
legend('FitnessHistory','\sigmaHistory');