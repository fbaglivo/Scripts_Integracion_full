
clear all
close all

% cd ..
%CANAL

patientROI(1).channels= [2:4 9 10 124];
patientROI(1).name= 'FD';

patientROI(2).channels= [19 22:24 26 27];
patientROI(2).name= 'FI';

patientROI(3).channels= [109:111 115:117];
patientROI(3).name= 'LAD';

patientROI(4).channels= [29 24:26 39 40];
patientROI(4).name= 'LAI';

patientROI(5).channels= [92 93 97 98 101 102];
patientROI(5).name= 'LPD';

patientROI(6).channels= [41 42 45:47 52];
patientROI(6).name= 'LPI';

patientROI(7).channels= [6 7 31 55 80 106];
patientROI(7).name= 'C';

patientROI(8).channels= [74:76 82:84];
patientROI(8).name= 'OD';

patientROI(9).channels= [64:66 69:71];
patientROI(9).name= 'OI';



out_path='Figs\4Cond\'

tipo='PostRetention'
freq='20 to 40HZ'


p=0.005;
rois 

for i=1:size(patientROI,2)
    
    
    Faces=load(['Mats/' tipo '_Faces_' freq '_' patientROI(i).name '.mat' ]);
    Objects=load(['Mats/' tipo '_Objects_' freq '_' patientROI(i).name '.mat']);
% 
     if strcmp(tipo,'Retention')

         index=1:size(Faces.timesout,2);
         t=Faces.timesout(index);
%          t=t;
         [indexbase]=find(t>-1000 & t<-800);
         
     else
         
         index=1:size(Faces.timesout,2);
         t=Faces.timesout(index);
%          t=t+1000;
         [indexbase]=find(t>-200 & t<0);
         
     end
    
    gcond(1).data=Faces.meanCond1(index,:);
    gcond(2).data=Faces.meanCond2(index,:);
    gcond(3).data=Objects.meanCond1(index,:);
    gcond(4).data=Objects.meanCond2(index,:);

%      if strcmp(tipo,'Retention')
%          
%          gcond(1).data=gcond(1).data-ones(size(gcond(1).data,1),1)*mean(gcond(1).data(indexbase,:),1)+1;
%          gcond(2).data=gcond(2).data-ones(size(gcond(1).data,1),1)*mean(gcond(2).data(indexbase,:),1)+1;
%          gcond(3).data=gcond(3).data-ones(size(gcond(1).data,1),1)*mean(gcond(3).data(indexbase,:),1)+1;
%          gcond(4).data=gcond(4).data-ones(size(gcond(1).data,1),1)*mean(gcond(4).data(indexbase,:),1)+1;
%     
%      end
        
       
    Gcond(1).mean=mean(gcond(1).data,2);
    Gcond(2).mean=mean(gcond(2).data,2);
    Gcond(3).mean=mean(gcond(3).data,2);
    Gcond(4).mean=mean(gcond(4).data,2);

%      if strcmp(tipo,'Retention')
%          
%          Gcond(1).mean=Gcond(1).mean-mean(Gcond(1).mean(indexbase))+1;
%          Gcond(2).mean=Gcond(2).mean-mean(Gcond(2).mean(indexbase))+1;
%          Gcond(3).mean=Gcond(3).mean-mean(Gcond(3).mean(indexbase))+1;
%          Gcond(4).mean=Gcond(4).mean-mean(Gcond(4).mean(indexbase))+1;
%          
%      end
    Gcond(1).std=std(gcond(1).data,0,2);
    Gcond(2).std=std(gcond(2).data,0,2);
    Gcond(3).std=std(gcond(3).data,0,2);
    Gcond(4).std=std(gcond(4).data,0,2);
    
    
    
    
    %%STATS
    
    DATA={gcond(1).data,gcond(2).data};
    [tf dff pvalsf] = statcond(DATA,'mode','perm','paired','on','naccu', 1000);
    
    DATA={gcond(3).data,gcond(4).data};
    [to dfo pvalso] = statcond(DATA,'mode','perm','paired','on','naccu', 1000);
    
    i_indf=find(pvalsf<p);
    i_indo=find(pvalso<p);
    
    %%GRAPH
    
    color_code={[0 1 0],[0 1 1],[0 0 1],[1 0 0]};
    
%     srate_new=Faces.newsr;
%     base_time=Faces.base_time;
    if strcmp('Retention',tipo)
        
        base_time=-0.8;
    end
    figure
    
    for k=1:size(gcond,2)
        
        
        epoch_l=size(Gcond(k).mean,1);
        
%         t=[1:epoch_l]/srate_new-base_time;
       
        cond_avg=Gcond(k).mean;
        max_cond(k)=max(cond_avg);
        min_cond(k)=min(cond_avg);
        cond_std=Gcond(k).std;
        mean_plus_error = cond_avg + (cond_std / sqrt(size(gcond(k).data,2))); % no of epochs
        mean_min_error = cond_avg - (cond_std / sqrt(size(gcond(k).data,2)));
        hh(k)=plot(t,cond_avg, 'Color',color_code{k}, 'LineWidth', 1.5)
        hold on
        f_l=fill([t t(end:-1:1)],[mean_plus_error' mean_min_error(end:-1:1)'],color_code{k},'EdgeColor',color_code{k}); %shaded error bar
        set(f_l,'FaceAlpha',.1,'EdgeAlpha',.1)
        
        %     [y,i_ind]= max(cond_avg(151:300));
        hold on;
        
    end
    
%     ylim([-10 max(max_cond)*1.3])
     ylim([0.5 max(max_cond)*1.3])
    if ~isempty(i_indf)
        
        plot(t(i_indf),max(max_cond)*1.1,'*', 'Color',[0.1 0.5 0.1], 'MarkerSize', 2)
        
    end
    
    
    if ~isempty(i_indo)
        
        plot(t(i_indo),0.7,'*', 'Color',[0.5 0.1 0.5], 'MarkerSize', 2)
        
    end
    
    switch tipo
        
        case 'Decision'
            
            line([0 0],ylim,'Color','k')
            line(xlim,[0 0],'Color','k')
            set(gca,'fontsize', 8)
            set(gca,'XTick',(-600:200:1000))
            
        case 'PostRetention'
            
            line([0 0],ylim,'Color','k')
            line(xlim,[0 0],'Color','k')
            set(gca,'fontsize', 8)
            set(gca,'XTick',(-200:100:1000))
            
        case 'Retention'
            
            line([0 0],ylim,'Color','k')
            line(xlim,[0 0],'Color','k')
            set(gca,'fontsize', 8)
            set(gca,'XTick',(-1000:200:1000))
            
    end
    
    legend([hh(1) hh(2) hh(3) hh(4)],{'Faces Binding' 'Faces Features' 'Objects Binding' 'Objects Features'},'Location','NorthEast')
    title(['ERP - Region: ' patientROI(i).name])
    
    saveas(gcf,[out_path  tipo '_ERP_' patientROI(i).name freq],'jpg')
    
end
