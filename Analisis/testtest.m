for u=1:size(cond,2)
    
    u
    
    gcond(u).data=[];
    gcondp(u).data=[];
    
    for p=1:size(roi(h).chan,2)
        
        
        if isempty(find(badchannels==roi(h).chan(p)))
            
            gcond(u).data=squeeze(cat(2,gcond(u).data,squeeze(cond(u).data(roi(h).chan(p),:,:))));
            gcondp(u).data=squeeze(cat(2,gcondp(u).data,squeeze(cond(u).data(roi(h).chan(p),:,:))));
            
        end
        
    end
    
end