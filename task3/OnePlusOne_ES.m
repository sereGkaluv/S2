%input:
    %fitnessFunctionName: Function for fitness
    %yParent: Vector of parent
    %sigmaMutationStrength: Mutation strength
    %maxNrOfIter: Maximum generations
    %minChangeDistance: Never decrease this distance after mutation

%output:
    %numberOfIterations: Numpers of Repitations    
    %yParent: last calculated best individuum
    %parentFitness: last calculated best fitness value
    %offspringFitnessHistory: Array of all best fitness values per G


    %G - Number of Generations G = N


function [numberOfIterations, yParent, parentFitness, offspringFitnessHistory] = OnePlusOne_ES(...
    mutationFunctionName,...
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
    
    [R,C] = size(yParent);
    offspringFitnessHistory = [];
    
    % initial yp & sigmaMutationStrength
    parentFitness = feval(mutationFunctionName, yParent); %Parental Fitness
    numberOfIterations=1; %generation count
    
    while numberOfIterations <= maxNrOfIter
        %generate offspring
        yOffspring = yParent + sigmaMutationStrength * normrnd(0,1,R,C); %random Normal distribution = RN
        offspringFitness = feval(mutationFunctionName, yOffspring);
        
        % other two break conditions
        if ((abs(offspringFitness-parentFitness) < minChangeDistance))
           break;
        elseif (offspringFitness <= parentFitness) %replace if fitness is not worse
            yParent = yOffspring;
            parentFitness = offspringFitness;  
        end
        offspringFitnessHistory = [offspringFitnessHistory, parentFitness];
        numberOfIterations = numberOfIterations + 1;
    end
end

function [ret] = calcFitness(x)
    ret = x*x';
end
