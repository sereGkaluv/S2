% input parameters:
% yParents:   initial parent vector [1 x n] 
% sigmaMutationParents: mutation strength [real value]
% sigmaStop: termination condition [real value]
% searchSpaceDimensionalityN: search space [integer value]
% lambda: number of offspring to be generated [integer value]
% fitnessCalculationFunction: fitness calculation function [string]
% maxIter: safeguard - add a maximum of possible iterations [integer value]


% output parameters:
% iterations: number of iterations
% fitnessHistory: fitness history
% sigmaHistory: history of mutations


function [iterations, fitnessHistory, sigmaHistory ] = SelfAdaptationES(yParents, sigmaMutationParents, sigmaStop, searchSpaceDimensionalityN, lambda, fitnessCalculationFunction, maxIter )

    % Initialize iterations
    iterations = 0;
    
    % Log-normal mutation, according to the Assignment, page 2
    tau = 1 / sqrt(searchSpaceDimensionalityN);
    
    % Vectors for gathering statistics
    fitnessHistory = [];
    sigmaNewMutation = [];
    iterationVector = [];
    
    % Run until sigmaParents smaller than sigmaStop. Also safeguard with a
    % maxIter parameters.
    while (sigmaMutationParents > sigmaStop) && (iterations<maxIter)
        
        % Create a pool of lambda offsprings
        for offspringIter = 1:lambda
            
            % Calculate different xi for each offspring
            xi_l = exp(tau*normrnd(0,1,1,1));
            
            % Remarks: sigma (mutation) is fixed. But for every offspring, a new sigma is
            % calculated (because the normrnd() delivers a different vector each
            % time - thus xi_l is different for each offspring).
            sigmaNewMutation(offspringIter) = xi_l * sigmaMutationParents;
            
            % Calculate new offspring (mutate parents). The resulting
            % offspring is a row, insert in the pool of lambda individuals.
            % REMARK: A(i,:) selects the 'i'th row of matrix A.
            yOffspringPool(offspringIter,:) = yParents + sigmaNewMutation(offspringIter)*normrnd(0,1,1,size(yParents,2));
            
            % Calculate fitness of mutated offspring
            offspringFitness(offspringIter) = feval(fitnessCalculationFunction, yOffspringPool(offspringIter,:));
        end       
                
        % Select best (minimal) fitness
        smallestFitness = min(offspringFitness);
        
        % Find index of best fitness element
        indexOfSmallestFitnessElement = find(offspringFitness == smallestFitness);
        
        % Calculate new parent sigma, by taking the 1st best vector from a
        % pool of lambda individuals (Handout "Computational Intelligence and Optimization Introduction" by Beyer, page 85)
        sigmaMutationParents = sigmaNewMutation(indexOfSmallestFitnessElement);
        
        % Calculate new parents (see selection method above)
        yParents = yOffspringPool(indexOfSmallestFitnessElement,:);
        
        % Increase iteration number
        iterations = iterations + 1;
        
        % Gather and save statistics
        fitnessHistory(iterations+1) = smallestFitness;
        sigmaHistory(iterations+1) = sigmaNewMutation(indexOfSmallestFitnessElement);
    end    
end

% "Kugelmodell"
function[ret] = QuadraticSphereModel(x)
    ret = x*x';
end


