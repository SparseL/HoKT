function CM= confusionMatrixVar(CC,classi,numclass)


CM = zeros(numclass,size(CC,2));

for k=1:size(CC,2) %
     listnodes=CC{k};
    for j=1 : size(listnodes,2)
       nodo=listnodes(1,j);
       if (nodo ~= 0)
       pos=0;
       for i=1:size(classi,1)
           if (nodo == classi(i,1))
               pos=i;
               break;
           end
       end
       
       if (pos ~= 0)       
         classe = classi(pos,2);

         CM(classe,k)=  CM(classe,k)+1;
       end
       end
    end
      
end
     
end
    
