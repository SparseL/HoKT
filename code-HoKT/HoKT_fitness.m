function scores = HoKT_fitness(x,matrix,fileclassi,numclassi,numberOfVariables,simi,ave,SetClass,SetNumClass,numiter);
%function scores = cluster_fitness(x)
%CLUSTER_FITNESS  Custom fitness function for cluster. 
%   SCORES = CLUSTER_FITNESS(X,submatrix) Calculate the fitness 
%   of an individual. The fitness is the sum of the scores of each cluster
%   created.



for numchrom = 1:size(x,1)
  
   CC=decodenew(x(numchrom,:));
  
   scores(numchrom,1)=  -computeGain(CC,matrix);
   [~,maxsimi] = sort(simi{numiter},'descend');
   if numiter>2
       diff=simi{numiter}(maxsimi(1))-simi{numiter}(maxsimi(2));
       if diff>0.005
           scores(numchrom,2)=-computeFit(CC,SetClass{maxsimi(1)},SetNumClass{maxsimi(1)},numberOfVariables);
       else
            w(1)=0.5+diff*100;
            w(2)=0.5-diff*100;
            scores(numchrom,2)=-computeFit(CC,SetClass{maxsimi(1)},SetNumClass{maxsimi(1)},numberOfVariables)*w(1)+...
                          -computeFit(CC,SetClass{maxsimi(2)},SetNumClass{maxsimi(2)},numberOfVariables)*w(2);
       end
   else
       scores(numchrom,2)=-computeFit(CC,SetClass{maxsimi(1)},SetNumClass{maxsimi(1)},numberOfVariables);
   end
   
   
      
   end



function mod = computeGain(CC,M);
         mod=0;
         numEdges=sum(sum(M(:,:)));
        
         for k=1:size(CC,2)
                                             %che formano la componente corrente
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function nmi = computeFit(CC,fileclassi,numclassi,numberOfVariables);
       
      CM=confusionMatrixVar(CC,fileclassi,numclassi);  


       nmi= computeNMI(CM,size(fileclassi,1));      
       
       
         
    end
end