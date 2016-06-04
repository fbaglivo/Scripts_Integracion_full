
function M=make_triang_edge_neg(M, low_edge, high_edge)

M3=M;

M3(find(M>low_edge))=0;


M2=M;

M2(find(M<high_edge))=0;


clear M;
M=M2+M3;

for k=1:size(M,1)
    for kk=1:size(M,2)
   
        if kk<=k
            M(k,kk)=0;
        end
            
        
    end
end

