
function CC = decodenew(x);

N = size(x,2);
p=1:1:N;
rank=zeros(1,N);
numCC=N;

for i=1:N
    if (x(i)~=0)
    n1= findSet(i,p);
    n2=findSet(x(i),p);
    if (n1 ~= n2) %if the  components to which n1 end n2 belong are different, they are merged  
                                  
       numCC=numCC-1;
        if rank(n1) > rank(n2)
            p(n2)=n1;
        else 
            p(n1)=n2;
        end
        if (rank(n1)==rank(n2))
            rank(n2)=rank(n1)+1;
        end
        
    end
    end
end
 
visited=zeros(1,N);
indCC=0;
for i=1:N
  if ((visited(i) == 0) && (x(i) ~= 0))
      indCC=indCC+1;
    repi = findSet(i,p);
    CC{indCC}=i;
    for j=i+1:N
        if (visited(j) == 0 && repi == findSet(j,p))
           CC{indCC} = [CC{indCC} j]; 
           visited(j)=1;
        end
    end
  end
end


function pi = findSet(i,p)
    
    while (i ~= p(i))
        i=p(i);
    end
pi=p(i);
end
end
