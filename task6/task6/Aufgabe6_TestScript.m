sigmaMutation = 10;
sigmaStop = 10e-12;
my = 10; % Size of parent population
lambda = 10; % Skript, s. 95 Size of offspring population, lambda >= my Skript, s. 96
rho = 3; % Size of family (parents)
N = 10; % Skript, s. 95

[iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, 'QuadraticSphereModel', 1000);
iterations

semilogy(1:iterations+1, fitnessHistory, 'Color', 'blue');
hold on;
semilogy(1:iterations+1, sigmaHistory, 'Color', 'green');

ylabel('Fitness', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);

title('1/5 Rule', 'FontSize', 12);
legend('My/MyI LaSi SA-ES','\sigmaHistory','\fitnessHistory');