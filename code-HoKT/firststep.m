

function [ris maxmod]= firststep(M,gen,popSize,CrossoverFraction,mutationRate);


numberOfVariables = size(M,2);       %number of variables is the row-column number 

          
  for k=1:numberOfVariables  
    if ((sum(M(k,:))==0)) 
        Neighbor{k}=0;
        
    else   
  Neighbor{k} = find(M(k,:));
    end
  end

for k=1:numberOfVariables            
    if (Neighbor{k}==0) 
        bestNN(k)=0;
    else
      bestNN(k) = bestNeighbor(k,Neighbor);
    end
end
   
type create_populationLS.m;


type crossover_cluster.m;


type mutate_cluster.m;

%type cluster_fitness.m
type cluster_fitnessMod.m;  

%FitnessFcn = @(x)cluster_fitness(x,M,alfa);
FitnessFcn = @(x)cluster_fitnessMod(x,M);

 
 
options = gaoptimset('PopulationType', 'custom','PopInitRange', ...
    [1;numberOfVariables]);

Elitecount=(options.PopulationSize*10)/100;
%mutationRate=0.6;
%CrossoverFraction=0.8;
options = gaoptimset(options,'CreationFcn',{@create_populationLS,bestNN,Neighbor}, ...
    'CrossoverFcn',{@crossover_cluster},...
    'MutationFcn',{@mutate_cluster, mutationRate,Neighbor}, ...
    'PlotFcn', {@plotfun,@gaplotscores,@gaplotscores,@gaplotrange}, ...
    'SelectionFcn',@selectionroulette, ...
    'Generations',gen,'PopulationSize',popSize, ...
    'StallTimeLimit',Inf, ...
    'StallGenLimit',20,'Vectorized','on');


[x,fval,reason,output,population,scores] = ga(FitnessFcn,numberOfVariables,options);



%fval
[maxmod i] = min(fval(:,1));
maxmod=-maxmod;
ris=decodenew(x(i,:));


 
function pos=bestNeighbor(node,Neighbor) 
maxshared=-1;
pos=0;
%Neighbor{node}
for j=1:size(Neighbor{node},2)
    if (j ~= node)
       vicino=Neighbor{node}(j);
       shared=size(intersect(Neighbor{node},Neighbor{vicino}),2);
       if(shared > maxshared)
        maxshared=shared;
        pos=j;
       end
    end
end
end
end
