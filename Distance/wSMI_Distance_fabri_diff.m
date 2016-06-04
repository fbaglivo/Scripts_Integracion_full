
%%Make wSMI Matrix

color={'b' 'r' 'c' 'k'}


    
    DATA = eval(['C_' num2str(comp1)])-eval(['C_' num2str(comp2)]);
    
%     DATA(find(P>0.01)) = 0;
    
    for j=1:size(DATA,2)
        
        S(j,:,:)=reshape(squeeze(DATA(:,j)),126,126);
        
    end
    
    Smean_t=squeeze(mean(S,1));
    
    load('ElectrodeDistanceEGIs126matoids.mat')
    C=triu(D);
    Smean=triu(Smean_t);
    max_d=ceil(max(max(C)));
    
    for i=1:max_d
        
        [z(i).a]=find(D<i&D>i-1);
        Vect(i).data=Smean(z(i).a);
        Vect(i).data(find(Vect(i).data==0))=[];
        vect(i)=mean(Vect(i).data);
    end
    
    plot(vect,'r')
    hold on;

