%input:
    %fitnessFunctionName: Function for fitness
    %yParent: Vector of parent
    %sigmaMutationStrength: Mutation strength
    %maxNrOfIter: Maximum generations
    %minChangeDistance: Never decrease this distance after mutation

%output:
    %numberOfIteration: Numpers of iterations
    %yOffspring: generated offspring
    %offspringFitness: fitness of yoffspring
    %offspringFitnessHistory: Record of Fitness

function [numberOfIteration, yOffspring, offspringFitness, offspringFitnessHistory] = OnePlusOne_ES(...
    fitnessFunctionName,...
    yParent,...
    sigmaMutationStrength,...
    maxNrOfIter,...
    minChangeDistance)
    
    if nargin < 3
        %output error 
        error('Wrong nr of Inputs');
    elseif nargin == 3 %nubers of argument in
        maxNrOfIter = 100;
        minChangeDistance = 1e-10;
    elseif nargin == 4
        minChangeDistance = 1e-10;     
    end
    
    offspringFitnessHistory = [];
    
    % initial yp & sigmaMutationStrength
    parentFitness = feval(fitnessFunctionName, yParent); %Parental Fitness
    numberOfIteration=1; %generation count
    
    while numberOfIteration <= maxNrOfIter
        %generate offspring
        [R,C] = size(yParent);
        yOffspring = yParent + sigmaMutationStrength * normrnd(0,1,R,C); %random Normal distribution = RN
        offspringFitness = feval(fitnessFunctionName, yOffspring);
        
        % other two break conditions
        if ((abs(offspringFitness-parentFitness) < minChangeDistance))
           break;
        elseif (offspringFitness <= parentFitness) %replace if fitness is not worse
            yParent = yOffspring;
            parentFitness = offspringFitness;  
        end
        offspringFitnessHistory(numberOfIteration) = parentFitness;
        numberOfIteration = numberOfIteration + 1;
    end
end
