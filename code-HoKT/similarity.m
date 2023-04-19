function similar = similarity(W_Cube1,W_Cube2)
%SIMILARITY 计算两个邻接矩阵的相似性
%   此处显示详细说明
logic = (W_Cube1==W_Cube2);
numEdge=length(find(logic==1));
totalEdge = size(W_Cube1,1);
totalEdge=totalEdge^2;
similar = numEdge/totalEdge;
end

