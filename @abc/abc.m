%% Artificial Bee Colony (ABC)


%------------------------------written by : Ahmad Al Shalabi---------------
classdef abc
    properties
        dimensionOfSolution;        % The number of parameters of the problem to be optimized.
        numberOfSolutions;      % Population Size (Colony Size).
        lowerBounds;        % Lower bounds of the parameters.
        upperBounds;        % Upper bounds of the parameters.
        numberOfIterations;     % Maximum cycle number in order to terminate the algorithm.
        limit;      % Abandonment Limit Parameter (Trial Limit).
    end
    methods
        function abc= abc(colonySize,dimensionOfSolution,lowerBounds,upperBounds,numberOfIterations,limit)
            abc.numberOfSolutions=fix(colonySize/2);
            abc.dimensionOfSolution=dimensionOfSolution;
            abc.lowerBounds=lowerBounds;
            abc.upperBounds=upperBounds;
            abc.numberOfIterations=numberOfIterations;
            abc.limit=limit;
        end
        
        [abc,solution,costOfSolution]=RunAlgorithm(abc);
    end
    
    
end