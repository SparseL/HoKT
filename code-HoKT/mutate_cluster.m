function mutationChildren = mutate_cluster(parents ,options,NVARS, ...
    FitnessFcn, state, thisScore,thisPopulation,mutationRate,Neighbor);
%
%   The arguments to the function are 
%     PARENTS: Parents chosen by the selection function
%     OPTIONS: Options structure created from GAOPTIMSET
%     NVARS: Number of variables 
%     FITNESSFCN: Fitness function 
%     STATE: State structure used by the GA solver 
%     THISSCORE: Vector of scores of the current population 
%     THISPOPULATION: Matrix of individuals in the current population
%     MUTATIONRATE: Rate of mutation
%     Neighbor a cell array containing the neighbors of each node




mutationChildren = zeros(length(parents),NVARS);


for i=1:length(parents)
    if (mutationRate>rand)
   
        
        child = thisPopulation(parents(i),:);
        
        rand('twister',sum(100*clock));
        pos = ceil(NVARS*rand);
        while (child(pos) == 0) 
            pos = ceil(NVARS*rand);
        end
        valuepos=ceil(size(Neighbor{pos},2)*rand);

        child(pos) = Neighbor{pos}(valuepos);
        mutationChildren(i,:) = child; 
    else
        mutationChildren(i,:) = thisPopulation(parents(i),:);
    end
end