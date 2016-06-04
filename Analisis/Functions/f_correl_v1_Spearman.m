function f_correl_v1_Spearman(tipo)

out_path_var='Mats/';

data=open(['Mats/' tipo '.mat']);

switch tipo

    
    case 'Decision'
        
        w_size_v=0.2; %segundos
        offset_v=[-0.3 0 0.3 0.5 0.7]+0.4; %segundos

    case 'PostRetention'
    
        
        w_size_v=0.2; %segundos
        offset_v=[-0.3 0  0.5 1 1.5]+0.4; %segundos

    case 'Retention'

        
        w_size_v=0.2; %segundos
        offset_v=[-3.4 -2.7 -1.8 -0.7 0]+4.4; %segundos
        
    case 'Retention_Objects'
        
        w_size_v=0.2; %segundos
        offset_v=[-8 -6.8 -5 -3.7 -2 -0.75 0]+9.4; %segundos
    
    case 'PostRetention_Objects'
    
        
        w_size_v=0.2; %segundos
        offset_v=[-0.3 0  0.5 1 1.5]+0.4; %segundos

        
    case 'Decision_Objects'
        
        w_size_v=0.2; %segundos
        offset_v=[-0.3 0 0.3 0.5 0.7]+0.4; %segundos

        
end
load(['Mats/channels.mat']);
canales=size(channels,2);


for l=1:size(offset_v,2)

    w_size =ceil(w_size_v  * data.srate_noresamp);
    offset = ceil(offset_v(l)  * data.srate_noresamp);
    range = [offset-ceil(w_size/2) offset+ceil(w_size/2)]+1;


    data.condp(1).window=data.condp(1).data(:,range(1):range(2),:);
    data.condp(2).window=data.condp(2).data(:,range(1):range(2),:);

    for trial=1:size(data.condp(1).window,3);


        m1=squeeze(data.condp(1).window(:,:,trial))';
        m2=squeeze(data.condp(1).window(:,:,trial))';
        [rb(:,:,trial) pb(:,:,trial)]=corr(m1,m2,'type','Spearman');

        bind_v=[];
        
        for i=1:canales
            
            bind_v=[bind_v rb(i,i:canales,trial)];
            
        end
    
        Bind(:,trial,l)=bind_v; 
        
    end

    for trial=1:size(data.condp(2).window,3);

        m1f=squeeze(data.condp(2).window(:,:,trial))';
        m2f=squeeze(data.condp(2).window(:,:,trial))';
        %[r p]=corr(m,'type','Pearson');
        [rf(:,:,trial) pf(:,:,trial)]=corr(m1f,m2f,'type','Spearman');

        feat_v=[];
        
        for i=1:canales
            
            feat_v=[feat_v rf(i,i:canales,trial)];
        
        end
                    
        Feat(:,trial,l)=feat_v;
                
    end

    
    rbinding=mean(rb,3);
    rfeatures=mean(rf,3);

    bind(l).r=rbinding;
    feat(l).r=rfeatures;
   
    l
end

%% Calculo estadística


    
%Hay que hacerlo por trial

for p=1:size(Bind,3)
    
    [H,P,CI,STATS] = ttest2(squeeze(Bind(:,:,p))',squeeze(Feat(:,:,p))'); % rojo / azul
    
    n = 0;
    
    for i = 1:canales
        for j = (i+1):canales
            
            n = n + 1;
            Ps(p).data(i,j) = P(n);
            Ps(p).data(j,i) = P(n);
            T(p).data(i,j) = STATS.tstat(n);
            T(p).data(j,i) = STATS.tstat(n);
            
        end
    end

end



save([out_path_var tipo '_corr_spearman' ],'rf','rb','bind','feat','Ps','T')

%%


chan_num=size(channels,2);

for i=1:chan_num
   
    canales_label2{i}=cell2mat(channels(i));
    
end

%rotateXLabels(gca , 90)
%set(gca,'position',[0.01 0.1 1 0.8])
figure

for l=1:size(bind,2)
   
%     subplot(2,1,1)
    A=bind(l).r-feat(l).r;
    A(find(Ps(l).data>0.01))=0;
    imagesc(A);
    caxis([-0.1 0.1])
    set(gca,'XTick',1:1:chan_num)
    set(gca,'XTickLabel',canales_label2)
    set(gca,'YTick',1:1:chan_num)
    set(gca,'YTickLabel',canales_label2)
    rotateXLabels(gca , 90)
    title(['t= ' num2str(offset_v(l)-0.4) ' seg'])
%     subplot(2,1,2)
%     imagesc(Ps(l).data);
%     caxis([-0.05 0.05])
    pause(2)
    
end

%%

