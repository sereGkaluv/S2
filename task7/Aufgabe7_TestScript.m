randn('state', 7);
    
myFrom = 1; % Min size of parent population
myTo = 10; % Max size of parent population
lambda = 10; % Skript, s. 95 Size of offspring population, lambda >= my Skript, s. 96
N = 100; % Skript, s. 95
rho = 1; % Size of family (parents)
sigmaMutation = 1;
sigmaStop = 10^(-5);

colorMap = hsv(myTo);
legends = [];

for my=myFrom:myTo
  [iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, 'QuadraticSphereModel', 1500);
  my
  iterations
  fitnessHistory(size(fitnessHistory, 2))

  semilogy(1:iterations+1, fitnessHistory, '-', 'Color', colorMap(my,:), 'linewidth', 2);
  hold on;

  legends = [legends; sprintf('Fitness \\mu = %i', my)];
end
hold off;

legend(legends);
ylabel('Fitness', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);

title('My/MyI LaSi SA-ES', 'FontSize', 12);
