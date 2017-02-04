% input:
    % fitnessFunctionName: Function for fitness
    % yParent: Vector of parent
    % sigmaMutationStrength: Mutation strength
    % sigmaStopCondition: Mutation stop condition
    % maxNrOfIter: Maximum generations
    % minChangeDistance: Never decrease this distance after mutation

% output:
    % functionsCalls: number of functionsCalls
    % yParent: last calculated best individuum
    % offspringFitnessHistory: Array of all best fitness values per G
    % sigmaHistory: Array of all sigmas per generation (G)

function [functionsCallHistory, yParent, offspringFitnessHistory, sigmaHistory] = OnePlusOne_ES_1_5_Rule(...
    fitnessFunctionName,...
    N,...
    sigmaMutationStrength,...
    sigmaStopCondition, ...
    maxNrOfIter,...
    minChangeDistance)
    
    if nargin < 4 % number of arguments input
        % output error 
        error('Wrong nr of inputs');
    elseif nargin == 4 
        maxNrOfIter = 100;
        minChangeDistance = 1e-10;
    elseif nargin == 5
        minChangeDistance = 1e-10;     
    end
    
    functionsCallHistory = [];
    sigmaHistory = [];
    offspringFitnessHistory = [];

    % Preparing parent population.
    yParent = ones(1, N);
    
    % initial yp & sigmaMutationStrength
    parentFitness = feval(fitnessFunctionName, yParent); % Parental Fitness
    numberOfIterations=1; % generation count
    pOptimum = 0.2; % because of 1/5 rule
    alpha = 1.2; % should be bigger than 1 in order to be able to mutate
    [R,G] = size(yParent);
    
    % Initialize iterations, etc.
    functionCalls = 1;
                
    untilFlag = true;
    while (untilFlag)
        nS = 0;
        
        for k = 1: G
            % generate offspring
            yOffspring = yParent + sigmaMutationStrength * normrnd(0,1,R,G); % random normal distribution = RN
            offspringFitness = feval(fitnessFunctionName, yOffspring);

            % Counting function calls
            functionCalls = functionCalls + 1;
            
            % other two break conditions
            if ((abs(offspringFitness-parentFitness) < minChangeDistance))
               break;
            elseif (offspringFitness < parentFitness) % replace if fitness is not worse
                yParent = yOffspring;
                parentFitness = offspringFitness;
                nS = nS + 1;
            end
            
            functionsCallHistory = [functionsCallHistory; functionCalls];
            sigmaHistory = [sigmaHistory; sigmaMutationStrength];
            offspringFitnessHistory = [offspringFitnessHistory; parentFitness];
            numberOfIterations = numberOfIterations + 1;
        end
        
        pS = nS / G; % number of successful mutations / number of all mutations
        
        if (pS > pOptimum)
            sigmaMutationStrength = sigmaMutationStrength * alpha;
        end
        
        if (pS < pOptimum)
            sigmaMutationStrength = sigmaMutationStrength / alpha;
        end
        
        
        % break logic
        if (sigmaMutationStrength < sigmaStopCondition) % || numberOfIterations >= maxNrOfIter
            untilFlag = false;
        end
    end
end

% "Kugelmodell"
function [ret] = QuadraticSphereModel(x)
  ret = x*x';
end