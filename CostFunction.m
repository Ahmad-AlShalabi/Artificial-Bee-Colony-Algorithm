%% Cost Function

%------------------------------written by : Ahmad Al Shalabi---------------


%input : array (or  single vector ) of positions for food sources.
%outout : vector (or single value) of Cost value , each value for food source.


function costValueArray = CostFunction(x)
    costValueArray = (x(:,1)).^2 + (x(:,2)).^2 +  25.* (((sin(x(:,1))).^2 + (sin(x(:,2))).^2 ));
end