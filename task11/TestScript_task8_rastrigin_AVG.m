randn('state', 7);
    
my = 3; % Size of parent population
lambda = 3; % Skript, s. 95 Size of offspring population, lambda >= my Skript, s. 96
N = 30; % Skript, s. 95
rho = 1; % Size of family (parents)
sigmaMutation = 1;
sigmaStop = 10^(-5);
myValues = (1:5).*40;
optimalVector = [];
averageVector = [];


for i = 1:length(myValues)
    my = myValues(i);
    rho = my;
    lambda = 3 * myValues(i);
    optimalVector = [];
    for j = 1: 10
        [iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, 'Rastrigin', 1500);
        %get last element of fitnessHistory
        optimalVector(j) = fitnessHistory(end);
        j
    end
    mean(optimalVector)
    averageVector(i) = mean(optimalVector);    
end

semilogy(myValues, averageVector, '-', 'Color', 'blue');
legend(legends);

title('(\mu / \mu, \lambda) - \sigmaSA-ES Rastrigin N = 30 with \mu = [1,200], 40 steps, \lambda = 3\mu', 'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
xlabel('\mu', 'FontSize', 12);
legend('FitnessHistory-Average');