%input:
    %fitnessFunctionName: Function for fitness
    %yParent: Vector of parent
    %sigmaMutationStrength: Mutation strength
    %maxNrOfIter: Maximum generations
    %minChangeDistance: Never decrease this distance after mutation

%output:
    %yParent: last calculated best individuum
    %sigmaHistory: Array of all sigmas per generation (G)
    %offspringFitnessHistory: Array of all best fitness values per G

    %G - Number of Generations G = N
    
function [yParent, sigmaHistory, offspringFitnessHistory] = OnePlusOne_ES_Task3(...
    fitnessFunctionName,...
    yParent,...
    sigmaMutationStrength,...
    sigmaStopCondition, ...
    d, ...
    maxNrOfIter,...
    minChangeDistance)

    if nargin < 5 %number of arguments input
        %output error 
        error('Wrong nr of inputs');
    elseif nargin == 5 
        maxNrOfIter = 100;
        minChangeDistance = 1e-10;
    elseif nargin == 6
        minChangeDistance = 1e-10;     
    end
    
    sigmaHistory = [];
    offspringFitnessHistory = [];    

    % initial yp & sigmaMutationStrength
    parentFitness = feval(fitnessFunctionName, yParent, d); %Parental Fitness
    numberOfIterations=1; %generation count
    pOptimum = 0.2; %because of 1/5 rule
    alpha = 1.2; %should be bigger than 1 in order to be able to mutate
    [R,G] = size(yParent);
                
    untilFlag = true;
    while (untilFlag)
        nS = 0;
        
        for k = 1: G
            %generate offspring
            yOffspring = yParent + sigmaMutationStrength * normrnd(0,1,R,G); %random normal distribution = RN
            offspringFitness = feval(fitnessFunctionName, yOffspring, d);

            % other two break conditions
            if ((abs(offspringFitness-parentFitness) < minChangeDistance))
               break;
            elseif (offspringFitness < parentFitness) %replace if fitness is not worse
                yParent = yOffspring;
                parentFitness = offspringFitness;
                nS = nS + 1;
            end
            sigmaHistory = [sigmaHistory, sigmaMutationStrength];
            offspringFitnessHistory = [offspringFitnessHistory, parentFitness];
            numberOfIterations = numberOfIterations + 1;
        end
        
        pS = nS / G; %number of successful mutations / number of all mutations
        
        if (pS > pOptimum)
            sigmaMutationStrength = sigmaMutationStrength * alpha;
        end
        
        if (pS < pOptimum)
            sigmaMutationStrength = sigmaMutationStrength / alpha;
        end
        
        
        %break logic
        if ((sigmaMutationStrength < sigmaStopCondition) || (numberOfIterations >= maxNrOfIter))
            untilFlag = false;
        end
    end
end


