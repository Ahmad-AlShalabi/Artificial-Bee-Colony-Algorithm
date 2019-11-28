%   /* 
%   Training Artificial Neural Network.
%   XOR Problem.
%   Summation Units, Log-Sigmoid Neurons with Biases.
%   Input Layer: 2, Hidden Layer: 2, Output Layer: 1 neurons. 
%	Returns mean square error between desired and actual outputs.
%   Reference Papers:
%   D. Karaboga, B. Basturk Akay, C. Ozturk, Artificial Bee Colony (ABC) Optimization Algorithm for Training Feed-Forward Neural Networks, LNCS: Modeling Decisions for Artificial Intelligence, 4617/2007, 318-329, 2007.
%   D. Karaboga, C. Ozturk, Neural Networks Training by Artificial Bee Colony Algorithm on Pattern Classification, Neural Network World, 19(3), 279-292, 2009. 
%   */

function ObjVal = CostFunction(foodSources)
[numberOfSources numberOfVariable]=size(foodSources); 
trainingInput=[0 0;0 1; 1 0; 1 1];
target = [0 1 1 0]';
inp=size(trainingInput,2); %number of input samples
out=size(target,2);  % number of targets for sampels
hidden=2; % number of neurons in  hidden layer

for i=1:numberOfSources
    
x=foodSources(i,:);

    iw = reshape(x(1:hidden*inp),hidden,inp);  %wieght matrix for hidden layer iw[hidden][inp]
    b1 = reshape(x(hidden*inp+1:hidden*inp+hidden),hidden,1); % bias vector for hidden layer b1[hidden][1]
    lw = reshape(x(hidden*inp+hidden+1:hidden*inp+hidden+hidden*out),out,hidden); %wieght matrix for output layer  lw[out][hidden]
    b2 = reshape(x(hidden*inp+hidden+hidden*out+1:hidden*inp+hidden+hidden*out+out),out,1); % bias vector for output layer b2[out][1]
    
    y = logsig(logsig(trainingInput*iw'+repmat(b1',size(trainingInput,1),1))*lw'+repmat(b2',size(trainingInput,1),1));


    ObjVal(i)=mse(target-y);
end;


