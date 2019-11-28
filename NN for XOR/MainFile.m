%% Main File

%------------------------------written by : Ahmad Al Shalabi---------------

clc;
clear all;
close all;
dimensionOfSolution= 9;        % The number of parameters of the problem to be optimized.
colonySize= 50;               % number of solutions = colonySize/2.
lowerBounds = [-10 -10 -10 -10 -10 -10 -10 -10 -10];        % Lower bounds of the parameters.
upperBounds = [10 10 10 10 10 10 10 10 10];        % Upper bounds of the parameters.
numberOfIterations= 100;     % Maximum cycle number in order to terminate the algorithm.
limit= 40;      % Abandonment Limit Parameter (Trial Limit).

abc= abc(colonySize,dimensionOfSolution,lowerBounds,upperBounds,numberOfIterations,limit); % calling the constructor function of abc class

[abc,solution,costOfSolution]=RunAlgorithm(abc);  
% results
disp(solution);         % position of the  best solution (best food source).
disp(costOfSolution);   % cost value of the best solution (best food source).