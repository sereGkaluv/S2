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

function [yOffsprings, sigmaHistory, offspringFitnessHistory] = OnePlusOne_ES_Task3(...
    mutationFunctionName,...
    yParents,...
    sigmaMutationStrength,...
    sigmaStopCondition, ...
    maxNrOfIter,...
    minChangeDistance)
    
    if nargin < 4
        %output error 
        error('Wrong nr of Inputs');
    elseif nargin == 4 %nubers of argument in
        maxNrOfIter = 100;
        minChangeDistance = 1e-10;
    elseif nargin == 5
        minChangeDistance = 1e-10;     
    end
    
    sigmaHistory = [];
    offspringFitnessHistory = [];    

    % initial yp & sigmaMutationStrength
    parentFitness = feval(mutationFunctionName, yParents); %Parental Fitness
    numberOfIteration=1; %generation count
    pOptimum = 0.2; %because of 1/5 rule
    alpha = 1.2; %should be bigger than 1 in order to be able to mutate
    NrOfParents = size(yParents,2);
    [R,C] = size(yParents);
                
    untilFlag = true;
    while (untilFlag)
        nS = 0;
        
        for k = 1: NrOfParents
            %generate offspring
            yOffsprings = yParents + sigmaMutationStrength * normrnd(0,1,R,C); %random Normal distribution = RN
            offspringFitness = feval(mutationFunctionName, yOffsprings);

            % other two break conditions
            if ((abs(offspringFitness-parentFitness) < minChangeDistance))
               break;
            elseif (offspringFitness < parentFitness) %replace if fitness is not worse
                yParents = yOffsprings;
                parentFitness = offspringFitness;
                nS = nS + 1;
            end
            sigmaHistory = [sigmaHistory, sigmaMutationStrength];
            offspringFitnessHistory = [offspringFitnessHistory, parentFitness];
            numberOfIteration = numberOfIteration + 1;
        end
        
        pS = nS / NrOfParents; %number of successful mutations / number of all mutations
        
        if (pS > pOptimum)
            sigmaMutationStrength = sigmaMutationStrength * alpha;
        end
        
        if (pS < pOptimum)
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
