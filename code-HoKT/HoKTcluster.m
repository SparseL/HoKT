



function [ris maxmod] = HoKTcluster(M,class,numClass,gen,popSize,CrossoverFraction,mutationRate,simi,ave,SetClass,SetNumClass,numiter);


numberOfVariables = size(M,1);       


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




type HoKT_fitness.m;


FitnessFcn = @(x)HoKT_fitness(x,M,class,numClass,numberOfVariables,simi,ave,SetClass,SetNumClass,numiter);
 
 
options = gaoptimset('PopulationType', 'custom','PopInitRange', ...
    [1;numberOfVariables]);

Elitecount=(options.PopulationSize*10)/100;

options = gaoptimset(options,'CreationFcn',{@create_populationLS,bestNN,Neighbor}, ...
    'CrossoverFcn',{@crossover_cluster},...
    'MutationFcn',{@mutate_cluster, mutationRate,Neighbor}, ...
    'PlotFcn', {@plotfun,@gaplotscores,@gaplotpareto,@gaplotscorediversity}, ...
    'SelectionFcn',@selectiontournament, ...
    'Generations',gen,'PopulationSize',popSize, ...
    'StallTimeLimit',Inf, ...
    'StallGenLimit',20,'Vectorized','on');

lb=[];

ub=[];
    
[x,fval,reason,output,population,scores] = gamultiobj(FitnessFcn,numberOfVariables,[],[],[],[],lb,ub,options);


fname = ['result_x_fval.mat'];
           

            eval(['save ' fname  ' x fval -mat']);
%fval
%plotpareto(fval)
[maxmod i] = min(fval(:,1)); % 1 chooses la best modularity,  2 the best nmi 
maxmod=-maxmod;


ris =decodenew(x(i,:));

function pos=bestNeighbor(node,Neighbor) 
maxshared=-1;
pos=0;

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

