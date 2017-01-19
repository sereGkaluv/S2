%input:
    %mutationlocalMisclassifiedCntunctionName: Function for fitnes
    %yParents: Vector of parents (even if there is only one parent)
    %sigmaMutationStrength: Mutation strength
    %maxNrOfIter: Maximal repitations of Generations
    %minChangeDistance: Never decrease this distance after mutation

%output:
    %SelectedIndividuals: Vector of individuals having a better fittnes than
                            %their parents, or parents whose offspring were
                            %not as fit as them.
    %numberOfIteration: Numpers of Repitations
    %Fitness:  Fitness Value of Used Child

function [numberOfIteration, yOffsprings, offspringFitness, offspringFitnessHistory] = OnePlusOne_ES(...
    mutationFunctionName,...
    yParents,...
    sigmaMutationStrength,...
    maxNrOfIter,...
    minChangeDistance)
    
    if nargin < 3
        %output error 
    elseif nargin == 3 %nubers of argument in
        maxNrOfIter = 100;
        minChangeDistance = 1e-10;
    elseif nargin == 4
        minChangeDistance = 1e-10;     
    end
    
    offspringFitnessHistory = [];
    
    % initial yp & sigmaMutationStrength
    parentFitness = feval(mutationFunctionName, yParents); %Parental Fitness
    numberOfIteration=1; %generation count
    
    while numberOfIteration <= maxNrOfIter
        %generate offspring
        [R,C] = size(yParents);
        yOffsprings = yParents + sigmaMutationStrength * normrnd(0,1,R,C); %random Normal distribution = RN
        offspringFitness = feval(mutationFunctionName, yOffsprings);
        
        % other two break conditions
        if ((abs(offspringFitness-parentFitness) < minChangeDistance))
           break;
        elseif (offspringFitness <= parentFitness) %replace if fitness is not worse
            yParents = yOffsprings;
            parentFitness = offspringFitness;  
        end
        offspringFitnessHistory = [offspringFitnessHistory, parentFitness];
        numberOfIteration = numberOfIteration + 1;
    end
end

function [ret] = calcFitness(x)
    ret = x*x';
end
