function pop = create_populationLS(NVARS,FitnessFcn,options,bestNeig,Neighbor);
%CREATE_POPULATION Creates a population of chromosome.


totalPopulationSize = sum(options.PopulationSize);

pop = zeros(totalPopulationSize,NVARS);
rand('twister',sum(1000*clock));
prob=0.5;
for i = 1:totalPopulationSize

    for k=1:NVARS
        
        if (Neighbor{k} == 0) 
            
            chrom(k)=0;
        else
             if ((rand < prob) || (bestNeig(k) ==0))
                 
                position = ceil(size(Neighbor{k},2)*rand);
             else 
                 
                position=bestNeig(k);
             end
             chrom(k)= Neighbor{k}(position);
        end
    end
   
     pop(i,:) = chrom;

end



end
