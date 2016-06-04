

for trial=1:size(rb,3)

    bind_v=rb(1,1:end,trial);
    
    for i=2:size(rb,1)
        
        bind_v=cat(2,bind_v,rb(i,i:end,trial));
        
    end
    
    Bind(trial,:)=bind_v;
    
    clear bind_v;
    
end



for trial=1:size(rf,3)

    feat_v=rf(1,1:end,trial);
    
    for i=2:size(rf,1)
        
        feat_v=cat(2,feat_v,rf(i,i:end,trial));
        
    end
    
    Feat(trial,:)=feat_v;
    
    clear feat_v;
    
end


[H,P,CI,STATS] = ttest2(Bind(:,:),Feat(:,:)); % rojo / azul    

n=0;

for i=1:90
    for j=i:90
   
        n=n+1;
        a(i,j)=P(1,n);
        a(j,i)=P(1,n);
        
    end
end