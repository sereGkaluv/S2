randn('state', 7);
    
my = 3; % Size of parent population
lambda = 10; % Skript, s. 95 Size of offspring population, lambda >= my Skript, s. 96
N = 100; 
rho = 3; % Size of family (parents)
sigmaMutation = 0.01;
sigmaStop = 10^(-5);
tauArray = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.75, 1, 1.5, 2]
legends = [];
colorMap = hsv(length(tauArray));

for i = 1:length(tauArray)
    tau = tauArray(i);
    [iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, tau, 'QuadraticSphereModel', 1500);
    %iterations
    %fitnessHistory(size(fitnessHistory, 2))

    semilogy(1:iterations+1, sigmaHistory, '-', 'Color', colorMap(i,:));
    hold on;
    sprintf('Sigma \\tau = %i', tau)
    legends = [legends; sprintf('Sigma \\tau = %.2f', tau)];

end
hold off;
legend(legends);
ylabel('Sigma', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);

title('(3/3, 10) - \sigmaSA-ES Spheremodel N = 100 with \tau = [0,2] over 1500 Generations', 'FontSize', 12);