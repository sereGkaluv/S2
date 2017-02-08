
yParents = [10,10,10,10,10];
sigmaMutationParents = 10;
sigmaStop = 10e-12;
lambda = 10; % Skript, s. 95
N = 10; % Skript, s. 95
[iterations, fitnessHistory, sigmaHistory ] = SelfAdaptationES(yParents, sigmaMutationParents, sigmaStop, N, lambda, 'QuadraticSphereModel', 1000 );
iterations
semilogy(1:iterations+1,fitnessHistory)
ylabel('Fitness');
xlabel('Generations');
