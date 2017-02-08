randn('state', 7);
    
my = 3; % Size of parent population
lambda = 3; % Skript, s. 95 Size of offspring population, lambda >= my Skript, s. 96
N = 30; % Skript, s. 95
rho = 1; % Size of family (parents)
sigmaMutation = 1;
sigmaStop = 10^(-5);
myValues = (1:5).*40;
legends = [];
colorMap = hsv(length(muValues));


for i = 1:length(myValues)
    my = myValues(i);
    rho = my;
    lambda = 3 * myValues(i);
    [iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, 'Rastrigin', 1500);
    %iterations
    %fitnessHistory(size(fitnessHistory, 2))

    semilogy(1:iterations+1, fitnessHistory, '-', 'Color', colorMap(i,:));
    hold on;
    legends = [legends; sprintf('Fitness \\mu = %3.0f', my)];
    
end

legend(legends);

title('(\mu / \mu, \lambda) - \sigmaSA-ES Rastrigin N = 30 with \mu = [1,200], 40 steps, \lambda = 3\mu', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
xlabel('Generations', 'FontSize', 12);