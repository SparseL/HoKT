function scores = cluster_fitnessMod(x,matrix)
%function scores = cluster_fitness(x)
%CLUSTER_FITNESS  Custom fitness function for cluster. 
% Calculate the fitness each individual in the population. The fitness is the sum 
%of the scores of each cluster created.



scores = zeros(size(x,1),1);


mod=0;

for numchrom = 1:size(x,1)
    %x{numchrom}
 
    CC=decodenew(x(numchrom,:));
    scores(numchrom)= -computeGain(CC,matrix);
end


    function mod = computeGain(CC,M)
         mod=0;
         numEdges=sum(sum(M(:,:)));
        
         for k=1:size(CC,2)
                                             
            listnodes=CC{k};   
    %ls is the number of edges joining nodes of the community k
    %ds is the sum of the degrees of the nodes belonging to the community k
            ls=sum(sum(M(listnodes,listnodes)));
            ds=sum(sum(M(listnodes,:)));
            if (ds >0)
              mod = mod + (ls/numEdges - (ds/numEdges)^2);
            end
            
         end
    end
        
 

end