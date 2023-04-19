

function dynMoeaResult = run_HoKTmain(W_Cube,nbCluster,gen,popSize,CrossoverFraction,mutationRate,simi,ave);

numtimestamp=size(W_Cube,2);
dynMoeaResult=[];




[fid, message] = fopen('Ris.txt','wt');


M=sparse(W_Cube{1});
timetot=0; 

timetot=0; 
alfa=2;
numberOfVariables = size(M,1);       %number of variables is the row-column number 
%tic
[currsol miglioremod]=firststep(M,gen,popSize,CrossoverFraction,mutationRate); %Solution at tme step 0 without the second objective
%time=toc
%timetot=timetot+time


class=zeros(numberOfVariables,2);

%disp('number of obtained clusters')
numClass=size(currsol,2); 

fprintf(fid,'timestamp: 0 modularity=%d  numClusters=%d\n',miglioremod,numClass);


for i=1:numClass
    listnodes=currsol{i};
    for j=1 : size(listnodes,2)
        class(listnodes(1,j),2)=i;%class vector obtained for each node 
        class(listnodes(1,j),1)=listnodes(1,j); 
    end
end
SetClass{1}=class;
SetNumClass{1}=numClass;


dynMoeaResult(:,1)=class(:,2);

for numiter=2:numtimestamp
   M=sparse(W_Cube{numiter});

%tic
[bestCC miglioremod]=HoKTcluster(M,class,numClass,gen,popSize,CrossoverFraction,mutationRate,simi,ave,SetClass,SetNumClass,numiter);
%time=toc
%timetot=timetot+time


numClass=size(bestCC,2);


clear class;

class=zeros(numberOfVariables,2);

%compute the classes for the solution  bestCC
%these classes will be considered as the true classes at the next timestamp
%class contains the node in the first position and the corresponding class
%in the second one

SetNumClass{numiter}=numClass;
for i=1:numClass
    listnodes=bestCC{i};
    if (size(listnodes,2) ==1) & (W_Cube{numiter}(listnodes(1,1))==0)
        disp('error, we are considering null node')
        listnodes(1,1)
        W_Cube{numiter}(listnodes(1,1))
        class(listnodes(1,1),2)=0;
        class(listnodes(1,1),1)=0;
    else
    for j=1 : size(listnodes,2)
        class(listnodes(1,j),2)=i;
        class(listnodes(1,j),1)=listnodes(1,j); 
    end
    end
end
SetClass{numiter}=class;
dynMoeaResult(:,numiter)=class(:,2);
fprintf(fid,'timestamp: %d modularity=%d  numClusters=%d\n',numiter,miglioremod,numClass);

fprintf(fid,'best partitioning: \n');

for i1 = 1:size(bestCC,2)
    
    listnodes=bestCC{i1};
    for j1= 1:size(listnodes,2)
       
            fprintf(fid,'%d ',listnodes(1,j1));
    end
    fprintf(fid,'\n');
end


 fprintf(fid,'\n clusters: \n');
% 
 for i = 1:numberOfVariables
     for j= 1:2
        
             fprintf(fid,'%d ',class(i,j));
     end
     fprintf(fid,'\n');
 end
 
 end


end
        

