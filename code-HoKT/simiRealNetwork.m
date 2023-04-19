function simirealNetworks = simiRealNetwork(fileEdges,T)
blogSize=[370, 373, 374, 374, 373, 373, 367, 365, 374, 384];
for i=1:T
W_Cube{i}=zeros(400,400);
edges_curr = [fileEdges '.t0' int2str(i) '.edges'];
W = edges2adj(edges_curr,blogSize(i));

W_Cube{i}(1:size(W,1),1:size(W,2)) = W;

end
for i=2:T
    for j=1:i-1
        simirealNetworks{i}(j)=similarity(W_Cube{1,i},W_Cube{1,j});
    end
end
end