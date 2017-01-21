% input parameters:
% sigmaMutationParents: mutation strength [real value]
% sigmaStop: termination condition [real value]
% N: (searchSpaceDimensionalityN0) search space [integer value]
% my: size of parent population
% lambda: number of offspring to be generated [integer value]
% rho: size of family (parents)
% fitnessCalculationFunction: fitness calculation function [string]
% maxIter: safeguard - add a maximum of possible iterations [integer value]

% output parameters:
% iterations: number of iterations
% yOptimalVector: optimal parameterVector (best offsprings)
% fitnessHistory: fitness history
% sigmaHistory: history of mutations

function [iterations, yOptimalVector, fitnessHistory, sigmaHistory] = MyMyILaSiSelfAdaptationES(sigmaMutation, sigmaStop, N, my, lambda, rho, fitnessCalculationFunction, maxIter)
    
    % Vectors for gathering statistics
    yOptimalVector = [];
    fitnessHistory = [];
    sigmaHistory = [];
    
    % Log-normal mutation, according to the Assignment, page 2
    tau = 1 / sqrt(2*N); % sqrt(2*N) instead of sqrt(N) Skript, s. 106 
    
    % Preparing parent population. sSkript, s.97
    for k = 1:my
      yOptimalVector(k).parameterVector = ones(N, 1);
      yOptimalVector(k).sigma = sigmaMutation;
      yOptimalVector(k).fitness = feval(fitnessCalculationFunction, yOptimalVector(k).parameterVector);
    end
    
    % Initialize iterations
    iterations = 0;
    
    % Run until sigmaMutation smaller than sigmaStop. Also safeguard with a
    % maxIter parameters.
    while (sigmaMutation > sigmaStop) && (iterations < maxIter)
        
		    % Pre-initalizing offspring pool
		    yOffspringPool = [];
		
        % Create a pool of lambda offsprings
        for offspringIter = 1:lambda
            
            % Select rho individuals for a new family from population pool.
            family = Marriage(yOptimalVector, rho);
            
            % Calculate different xi for each offspring
            xi_l = exp(tau * normrnd(0,1,1,1));
            
            % Remarks: sigma (mutation) is fixed. But for every offspring, a new sigma is
            % calculated (because the normrnd() delivers a different parameterVector each
            % time - thus xi_l is different for each offspring).
            averageFamilySigma = mean([family(:).sigma]);
            yOffspringPool(offspringIter).sigma = xi_l * averageFamilySigma;
            
            % Calculate new offspring (mutate parent parameters).
            avarageFamilyVector = mean([family(:).parameterVector]);
            yOffspringPool(offspringIter).parameterVector = avarageFamilyVector + yOffspringPool(offspringIter).sigma * normrnd(0,1,1,N);
            
            % Calculate fitness of mutated offspring
            yOffspringPool(offspringIter).fitness = feval(
              fitnessCalculationFunction,...
              yOffspringPool(offspringIter).parameterVector...
            );
        end		
		
        % Update parent pool (optimalVector)
        
        %% todo temp pool otherwise will be owerritten
        [fitnesses, indexes] = sort([yOffspringPool(:).fitness]) %sorting offsprings (selection step #1)
        yOffspringPool = SortIndividumVector(indexes, yOffspringPool);
		    yOptimalVector = yOffspringPool(1:my); %choosing first(best) 'my' offsprings (selection step #2)
        
        % Increase iteration number
        iterations = iterations + 1;
        
        % Gather and save statistics
		    % iterations + 1 to avoid matlab problems (indexing starts from 1 not 0)
        fitnessHistory(iterations + 1) = yOptimalVector(1).fitness;
        sigmaHistory(iterations + 1) = yOptimalVector(1).sigma;
    end    
end

function [family] = Marriage(yParents, rho)
  %withReplacementState = true; % Skript, s. 99
  %family = datasample(yParents, rho, 'Replace', withReplacementState)
	
	% The above lines are applicable only to a my/rho examples.
	family = yParents; %In this case my/myI family size is equal to the size of population. Skript, s.102
end

% "Kugelmodell"
function [ret] = QuadraticSphereModel(x)
  ret = x*x';
end

function [ySelectedVector] = SortIndividumVector(yIndexVector, yDonorVector)
  ySelectedVector = [];
  
  for k = 1:length(yIndexVector)
    currentElement = yDonorVector(yIndexVector(k));
    
    ySelectedVector(k).parameterVector = currentElement.parameterVector;
    ySelectedVector(k).sigma = currentElement.sigma;
    ySelectedVector(k).fitness = currentElement.fitness;
  end
end


