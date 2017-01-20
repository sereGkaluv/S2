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

function [numberOfIteration, yOffsprings, offspringFitness, offspringFitnessHistory] = OnePlusOne_ES_Task3(...
    mutationFunctionName,...
    yParents,...
    sigmaMutationStrength,...
    sigmaStopCondition, ...
    N,... %search space dimensionality 
    maxNrOfIter,...
    minChangeDistance)
    
    if nargin < 5
        %output error 
        error('Wrong nr of Inputs');
    elseif nargin == 5 %nubers of argument in
        maxNrOfIter = 100;
        minChangeDistance = 1e-10;
    elseif nargin == 6
        minChangeDistance = 1e-10;     
    end
    
    offspringFitnessHistory = [];
    
    % initial yp & sigmaMutationStrength
    parentFitness = feval(mutationFunctionName, yParents); %Parental Fitness
    numberOfIteration=1; %generation count
    pOptimum = 0.2; %because of 1/5 rule
    alpha = 1.2; %should be bigger than 1 in order to be able to mutate
    
    untilFlag = true;
    while (untilFlag)
        nS = 0;
        
        for k = 1:maxNrOfIter
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
                nS = nS + 1;
            end
            offspringFitnessHistory = [offspringFitnessHistory, parentFitness];
            numberOfIteration = numberOfIteration + 1;
        end
        
        pS = nS / maxNrOfIter; %number of successful mutations / number of all mutations
        
        if (pS > pOptimum)
            sigmaMutationStrength = sigmaMutationStrength * alpha;
        elseif (pS < pOptimum)
            sigmaMutationStrength = sigmaMutationStrength / alpha;
        end
        
        %break logic
        if (sigmaMutationStrength < sigmaStopCondition)
            untilFlag = false;
        end
    end
end

function [ret] = calcFitness(x)
    ret = x*x';
end
