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
    initialParentalVector = ones(1, N).*10;
    for k = 1:my
        yOptimalVector = [yOptimalVector; initialParentalVector sigmaMutation feval(fitnessCalculationFunction, initialParentalVector)];
    end
    
    % Initialize iterations
    iterations = 0;
    
    % Run until sigmaMutation smaller than sigmaStop. Also safeguard with a
    % maxIter parameters.
    while (sigmaMutation > sigmaStop) && (iterations < maxIter)
        
        % Local mutation registers.
        yMutatedSigmas = [];
        yMutatedParameters = [];
        yMutatedFitnesses = [];
        
        % Select rho individuals for a new family from population pool.
        family = Marriage(yOptimalVector, rho);
        
        % Calculating average sigma for new family.
        averageFamilySigma = avg(family(:, N+1));
        % Calculating average parameters for new family.
        averageFamilyParameters = avg(family(:,1:N));
		
        % Create a pool of lambda offsprings
        for offspringIter = 1:lambda
            
            % Calculate different xi for each offspring
            xi_l = exp(tau * normrnd(0, 1, 1, 1));
            
            % Remarks: sigma (mutation) is fixed. But for every offspring, a new sigma is
            % calculated (because the normrnd() delivers a different parameterVector each
            % time - thus xi_l is different for each offspring).
            yMutatedSigmas = [yMutatedSigmas; xi_l * averageFamilySigma];
            
            % Calculate new offspring (mutate parent(object) parameters).
            yMutatedParameters = [yMutatedParameters; MutateParameters(...
                yMutatedSigmas(offspringIter),...
                averageFamilyParameters...
            )];
            
            % Calculate fitness of mutated offspring
            yMutatedFitnesses = [yMutatedFitnesses; feval(...
              fitnessCalculationFunction,...
              yMutatedParameters(offspringIter, :)... %% MAYBE HERE AN ERROR
            )];
        end		
		
        % Perform selection.
        [fitnesses, indexes] = sort(yMutatedFitnesses);
        
        % Updating pool.
        yOptimalVector = [];
        
        for selectionIter = 1:my
            currentIndex = indexes(selectionIter);
            yOptimalVector = [yOptimalVector; yMutatedParameters(currentIndex,:) yMutatedSigmas(currentIndex) yMutatedFitnesses(currentIndex)];
        end
        
        % Increase iteration number
        iterations = iterations + 1;
        sigmaMutation = averageFamilySigma;
        
        % Gather and save statistics
		    % iterations + 1 to avoid matlab problems (indexing starts from 1 not 0)
        bestOffspringIndex = indexes(1);
        
        sigmaHistory(iterations + 1) = yMutatedSigmas(bestOffspringIndex);
        fitnessHistory(iterations + 1) = yMutatedFitnesses(bestOffspringIndex);
    end    
end

function [family] = Marriage(yParents, rho)
  %withReplacementState = true; % Skript, s. 99
  %family = datasample(yParents, rho, 'Replace', withReplacementState)

  % The above lines are applicable only to a my/rho examples.
  family = yParents; %In this case my/myI family size is equal to the size of population. Skript, s.102
end

function [mutatedParameters] = MutateParameters(familySigma, yFamilyParameters)
  mutationVector = normrnd(0, 1, 1, length(yFamilyParameters));
  mutatedParameters = yFamilyParameters + familySigma*mutationVector;
end

function [avgVector] = avg(array)
  [R, C] = size(array);   
  avgVector = zeros(1, C);
  
  % Calculation of mean.
  for k = 1:C   
      avgVector(k) = mean(array(:,k));
  end
end

%Rastrigin
function[fitness] = Rastrigin(xP)
    a = 2;   
    fitness = sum( a - a * cos( 2 * pi * xP ) + xP.^2 );
end


