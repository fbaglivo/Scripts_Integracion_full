% 
% function make_edge(basename,filename,M, low_edge, high_edge)


load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Analisis\Mats\Decision_corr_Kendal_noref.mat')
basename='';
filename='test.edge'
M=abs(feat(1).r);
low_edge=0.7
high_edge=1

M(find(M>high_edge))=0;

M(find(M<low_edge))=0;

for k=1:size(M,1)
    for kk=1:size(M,2)
   
        if kk<=k
            M(k,kk)=0;
        end
            
        
    end
end

fid=fopen([basename filename],'w');

for j=1:size(feat(1).r)
    
    fprintf(fid, num2str(M(j,:)));
    fprintf(fid, '\n');

end


fclose(fid)

