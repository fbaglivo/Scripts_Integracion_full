if strcmp(test,'Faces')
    
    RTfeat=RT.faces.features;
    RTbind=RT.faces.binding;
    
elseif strcmp(test,'Objects')
        
    RTfeat=RT.objects.features;
    RTbind=RT.objects.binding;
    
end


[RTfeatsort index(2).data]=sort(RTfeat);
[RTbindsort index(1).data]=sort(RTbind);

%%%%%%%% ver como solucionar el tema de las ROIS