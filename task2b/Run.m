addpath ..\fitness
%N = 10, 20,... , 300
N = (1:30).*10;
allGenerationsUntilMax = [];
nReplications = 100;

for j = 1 : size(N,2)
    N(j)
    generationSum = 0;
    
    for k = 1 : nReplications
        yp = zeros(1,N(j)); 
        for i = 1 : N(j)
           if(rand() < 0.5)
                yp(i) = 1;
           end   
        end

        pm = 1/N(j);

        [numberOfIteration, yOffsprings, offspringFitness, offspringFitnessHistory] = ...
            OnePlusOne_ES_oneMax('OneMax', yp, pm, 1e6);
        generationSum = generationSum + size(offspringFitnessHistory,2);
    end
   
    allGenerationsUntilMax(j) = generationSum/nReplications;
end

subplot(2,1,1);
semilogy(allGenerationsUntilMax, '-', 'Color', 'blue');
xlabel('N/10', 'Fontsize', 12);
ylabel('Generations', 'Fontsize', 12);
title('(1+1)-ES B^{100} with pm=0.01')

subplot(2,1,2);
plot(allGenerationsUntilMax, '-', 'Color', 'blue');
xlabel('N/10', 'Fontsize', 12);
ylabel('Generations', 'Fontsize', 12);
title('(1+1)-ES B^{100} with pm=0.01')