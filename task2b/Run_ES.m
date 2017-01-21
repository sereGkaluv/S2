addpath ..\fitness
N = 100;
yp = zeros(1,N); 
  
for i = 1 : N
   if(rand() < 0.5)
        yp(i) = 1;
   end   
end

pm = 1/N

[numberOfIteration, yOffsprings, offspringFitness, offspringFitnessHistory] = OnePlusOne_ES_oneMax('OneMax', yp, pm, 1e6);

semilogy(offspringFitnessHistory, '-', 'Color', 'blue');
xlabel('Generations', 'Fontsize', 12);
ylabel('Fitness', 'Fontsize', 12);
title('(1+1)-ES B^{100} with pm=0.01')

