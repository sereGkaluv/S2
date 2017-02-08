randn('state', 7);

% MyMyILaSi SA-ES
my = 3; % Max size of parent population
lambda = 10; % Skript, s. 95 Size of offspring population, lambda >= my Skript, s. 96
rho = 1; % Size of family (parents)

% Shared
N = 100; % Specified in task
sigmaMutation = 1;
sigmaStop = 10^(-5);
maxIterations = 1500;

[opo_functionsCalls, opo_yParent, opo_fitnessHistory, opo_sigmaHistory] = OnePlusOne_ES_1_5_Rule('QuadraticSphereModel', N, sigmaMutation, sigmaStop, maxIterations);
[sa_es_functionsCalls, sa_es_yOptimalVector, sa_es_fitnessHistory, sa_es_sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, 'QuadraticSphereModel', maxIterations);

% Plotting first part (task a)
subplot(2, 1, 1);
  
semilogy(opo_fitnessHistory, '-', 'Color', 'blue', 'linewidth', 2);
hold on;

semilogy(sa_es_fitnessHistory, '-', 'Color', 'green', 'linewidth', 2);
hold off;

xlabel('Generations', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title('Generations performance comparison.', 'FontSize', 12);
legend('(1+1)-ES 1/5 Rule','(3/3_I, 10)-\sigma SA-ES');

% Plotting second part (task b)
subplot(2, 1, 2);

plot(opo_functionsCalls, '-', 'Color', 'blue', 'linewidth', 2);
hold on;

plot(sa_es_functionsCalls, '-', 'Color', 'green', 'linewidth', 2);
hold off;

xlabel('Generations', 'FontSize', 12);
ylabel('Function Calls', 'FontSize', 12);
title('Function calls comparison.', 'FontSize', 12);
legend('(1+1)-ES 1/5 Rule','(3/3_I, 10)-\sigma SA-ES');