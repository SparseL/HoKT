function xoverKids  = crossover_cluster(parents,options,NVARS, ...
    FitnessFcn,thisScore,thisPopulation);

%   The arguments to the function are 
%     PARENTS: Parents chosen by the selection function
%     OPTIONS: Options structure created from GAOPTIMSET
%     NVARS: Number of variables 
%     FITNESSFCN: Fitness function 
%     STATE: State structure used by the GA solver 
%     THISSCORE: Vector of scores of the current population 
%     THISPOPULATION: Matrix of individuals in the current population



nKids = length(parents)/2;
xoverKids = zeros(nKids,NVARS); 
index = 1;

for i=1:nKids
    % get parents
   
    r1 = thisPopulation(parents(index),:);
    index = index + 1;
    r2 =thisPopulation(parents(index),:);
    index = index + 1;
    % Randomly select one gene from each parent
    
    for j = 1:size(r1,2)
        prob=rand;
        if(prob > 0.5)
            child(1,j) = r1(1,j);
        else
          child(1,j) = r2(1, j);
        end
    end
    xoverKids(i,:) = child; 
   

end