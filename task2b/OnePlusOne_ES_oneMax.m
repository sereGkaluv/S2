%input:
    %fitnessFunctionName: Function for fitnes
    %yParent: Vector of parents (even if there is only one parent)
    %probabilityOfOnes: propability of Ones
    %maxNrOfIter: Maximal repitations of Generations
    %minChangeDistance: Never decrease this distance after mutation

%output:
    %numberOfIteration: Numpers of iterations
    %yOffspring: generated offspring
    %offspringFitness: fitness of yoffspring
    %offspringFitnessHistory: Record of Fitness

function [numberOfIteration, yOffspring, offspringFitness, offspringFitnessHistory] = OnePlusOne_ES_oneMax(...
    fitnessFunctionName,...
    yParent,...
    probabilityOfOnes,...
    maxNrOfIter,...
    minChangeDistance)
    
    if nargin < 2
        %output error 
        error('Wrong nr of Inputs');
    elseif nargin == 2 %nubers of argument in
        maxNrOfIter = 100;
        minChangeDistance = 1e-10;
    elseif nargin == 3
        minChangeDistance = 1e-10;  
    end
    
    offspringFitnessHistory = [];
    [R,N] = size(yParent);
            
    % initial yp & sigmaMutationStrength
    parentFitness = feval(fitnessFunctionName, yParent); %Parental Fitness
    numberOfIteration=1; %generation count
    
    while numberOfIteration <= maxNrOfIter
        %generate offspring
        yOffspring = SwitchBitsWithProbability(yParent, probabilityOfOnes);
        offspringFitness = feval(fitnessFunctionName, yOffspring);
        
        % other two break conditions
        if(offspringFitness == N)
            % best possible fitness achieved, break
            break
        end
        if (offspringFitness >= parentFitness) %replace if fitness is not worse
            yParent = yOffspring;
            parentFitness = offspringFitness;  
        end
        offspringFitnessHistory(numberOfIteration) = parentFitness;
        numberOfIteration = numberOfIteration + 1;
    end
end

function[ret] = SwitchBitsWithProbability(yParent, p)
    N = size(yParent,2);
    for i = 1 : N
        if(rand() < p)
            if(yParent(i) == 1)
                yParent(i) = 0;
            else
                yParent(i) = 1;
            end        
        end
    end
    ret = yParent;
end

