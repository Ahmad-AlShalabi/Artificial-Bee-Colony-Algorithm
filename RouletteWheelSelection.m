%% RouletteWheelSelection Function

%------------------------------written by : Ahmad Al Shalabi---------------

function choice = RouletteWheelSelection(probabilities)

  accumulation = cumsum(probabilities);  % the cumulative sums of the sequence {a,b,c,...}, are  a, a+b, a+b+c, ....
 
  p = rand() * accumulation(end); 
  
  choice=find(p<=accumulation,1,'first');
  end