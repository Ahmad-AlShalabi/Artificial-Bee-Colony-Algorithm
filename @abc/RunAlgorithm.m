%% Artificial Bee Colony (ABC)

%------------------------------written by : Ahmad Al Shalabi---------------


function [abc,finalSolution,costOfFinalSolution]=RunAlgorithm(abc)
%% Description
% abc.numberOfSolutions is equal to  half of size colony 
% In the ABC algorithm, first half of the colony consists of employed artificial bees and the second half constitutes the onlookers. 
% solutions [ abc.numberOfSolutions][abc.dimensionOfSolution]    ->  Solutions is the population of food sources. Each row of  matrix is a vector holding D parameters to be optimized.
% costOfSolutions [abc.numberOfSolutions]       -> costOfSolutions is a vector holding cost function values associated with food sources.
% trial[abc.numberOfSolutions]    ->  trial is a vector holding trial numbers through which solutions can not be improved.
% probabilities [abc.numberOfSolutions]   ->  probabilities a vector holding probabilities of food sources (solutions) to be chosen.
% newSolution [1][abc.dimensionOfSolution]    ->     New solution produced by v{ij}=x{ij}+phi*(x{kj}-x{ij})    , j is a randomly chosen parameter and k is a randomly chosen solution different from i.
% costOfNewSolution
% k, j   ->   j corresponds to paramToChange, k corresponds to neighbour.
% bestSolution
% iteration.Cost
% iteration.Position

%%  Initialization

bestSolution.Cost= inf;

% array to hold best cost values
iteration.Cost = zeros(abc.numberOfIterations,1);
iteration.Position = zeros(abc.numberOfIterations,abc.dimensionOfSolution);
% reset trial counters
trial=zeros(1,abc.numberOfSolutions);

% create initial population

solutions =repmat(ones,abc.numberOfSolutions,abc.dimensionOfSolution);
for i=1:abc.numberOfSolutions
    solutions(i,:)=(abc.lowerBounds+(abc.upperBounds-abc.lowerBounds)).*rand(1,abc.dimensionOfSolution);
end
costOfSolutions = CostFunction(solutions);

% memorize the best solution(best food source)
bestInd=find(costOfSolutions==min(costOfSolutions));
bestInd=bestInd(end);
bestSolution.Position = solutions(bestInd);
bestSolution.Cost = costOfSolutions(bestInd);

%% main loop
for it=1:abc.numberOfIterations
    %% Employed bee phase
    
    for i=1:(abc.numberOfSolutions)
        
        % Choose j (The parameter to be changed )  randomly:
        j=fix(unifrnd(1,abc.dimensionOfSolution))+1;
        
        % randomly chosen solution is used in producing a new solution , not equal to i
        k=[1:i-1 i+1:abc.numberOfSolutions];
        k=k(randi([1 numel(k)]));
        
        phi=unifrnd(-1,+1);
        
        newSolution = solutions(i,:);
        
        %  v{ij}=x{ij}+phi*(x{kj}-x{ij})
        newSolution(j) = solutions(i,j)+phi*(solutions(i,j)- solutions(k,j));
        
        % if generated parameter value is out of boundaries, it is shifted onto the boundaries
        if (newSolution(j)<abc.lowerBounds(j))
            newSolution(j)=abc.lowerBounds(j);
        end
        if (newSolution(j)>abc.upperBounds(j))
            newSolution(j)=abc.upperBounds(j);
        end
        % evaluate new solution
        costOfNewSolution = CostFunction(newSolution);
        
        % a greedy selection is applied between the current solution i and new solution
        % If the new solution is better than the current solution i, replace the solution with the new and reset the trial counter of solution i
        if (costOfNewSolution < costOfSolutions(i) )
            solutions(i,:)=newSolution;
            costOfSolutions(i)=costOfNewSolution;
            trial(i)=0;
            % else increase its trial counter
        else
            trial(i)=trial(i)+1;
        end
        
    end
    %% Calculate Probabilities
    
    p = (costOfSolutions)./(sum(costOfSolutions));
    probabilities = 1-p;
    
    %% Onlooker bee phase
    onlooker= abc.numberOfSolutions ;
    for m=1:onlooker
        
        % Select food Source position
        i=RouletteWheelSelection(probabilities);
        
        % Choose j (The parameter to be changed )  randomly:
        j=fix(unifrnd(1,abc.dimensionOfSolution));
        
        % randomly chosen solution is used in producing a new solution , not equal to i
        k=[1:i-1 i+1:abc.numberOfSolutions];
        k=k(randi([1 numel(k)]));
        
        phi=unifrnd(-1,+1);
        
        newSolution = solutions(i,:);
        
        %  v{ij}=x{ij}+phi*(x{kj}-x{ij})
        newSolution(j) = solutions(i,j)+phi*(solutions(i,j)- solutions(k,j));
        
        % if generated parameter value is out of boundaries, it is shifted onto the boundaries
        if (newSolution(j)<abc.lowerBounds(j))
            newSolution(j)=abc.lowerBounds(j);
        end
        if (newSolution(j)>abc.upperBounds(j))
            newSolution(j)=abc.upperBounds(j);
        end
        % evaluate new solution
        costOfNewSolution = CostFunction(newSolution);
        
        % a greedy selection is applied between the current solution i and new solution
        % If the new solution is better than the current solution i, replace the solution with the new and reset the trial counter of solution i
        if (costOfNewSolution < costOfSolutions(i) )
            solutions(i,:)=newSolution;
            costOfSolutions(i)=costOfNewSolution;
            trial(i)=0;
        % else increase its trial counter
        else
            trial(i)=trial(i)+1;
        end
    end
    %% Memorize the best solution (food source)
    ind=find(costOfSolutions==min(costOfSolutions));
    ind=ind(end);
    if (costOfSolutions(ind)<bestSolution.Cost)
        bestSolution.Cost=costOfSolutions(ind);
        bestSolution.Position=solutions(ind,:);
    end;
    %% Scout bee phase
    ind=find(trial==max(trial));
    ind=ind(end);
    if (trial(ind)>abc.limit)
        trial(ind)=0;
        newSolution=(abc.lowerBounds+(abc.upperBounds-abc.lowerBounds)).*rand(1,abc.dimensionOfSolution);
        costOfNewSolution = CostFunction(newSolution);
        solutions(ind,:)=newSolution;
        costOfSolutions(ind)=costOfNewSolution;
    end;
    %% Memorize the cost of the best solution in each iteration
    iteration.Cost(it)=bestSolution.Cost;
    iteration.Position(it,:)=bestSolution.Position;
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str( iteration.Cost(it))]);
end
%% results
figure;
semilogy(iteration.Cost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
ind=find(iteration.Cost==min(iteration.Cost));
ind=ind(end);
finalSolution=iteration.Position(ind,:);
costOfFinalSolution=iteration.Cost(ind);
end
