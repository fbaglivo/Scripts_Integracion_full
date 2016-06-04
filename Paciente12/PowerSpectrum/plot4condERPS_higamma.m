
clear all
close all

% cd ..

rois

out_path='Figs\4Cond\'

tipo='Retention'
freq='55 to 150HZ'


p=0.002;
rois 

for i=[1 3 9 16]%1:size(roi,2)
    
    
    Faces=load(['Mats/' tipo '_Faces_' freq '_' roi(i).name '.mat' ]);
    Objects=load(['Mats/' tipo '_Objects_' freq '_' roi(i).name '.mat']);

     if strcmp(tipo,'Retention')
         
         [index]=find(Faces.timesout>-1400);
         t=Faces.timesout(index);
         t=t+1000;
         [indexbase]=find(t>-400 & t<-200);
         
     else
         
         index=1:size(Faces.timesout,2);
         t=Faces.timesout(index);
%          t=t+1000;
         [indexbase]=find(t>-400 & t<-200);
         
     end
    
     if size(Faces.meanCond1,1) == 1
         
         Faces.meanCond1=Faces.meanCond1';
         Faces.meanCond2=Faces.meanCond2';
         Objects.meanCond1=Objects.meanCond1';
         Objects.meanCond2=Objects.meanCond2';
     end
     
     
     for m=1:size(Faces.meanCond1,2)
         
         
         gcond(1).data=Faces.meanCond1(index,m);
         gcond(2).data=Faces.meanCond2(index,m);
         gcond(3).data=Objects.meanCond1(index,m);
         gcond(4).data=Objects.meanCond2(index,m);
         
         
         
         
         if strcmp(tipo,'Retention')
             
             gcond(1).data=gcond(1).data-ones(size(gcond(1).data,1),1)*mean(gcond(1).data(indexbase,:),1)+1;
             gcond(2).data=gcond(2).data-ones(size(gcond(1).data,1),1)*mean(gcond(2).data(indexbase,:),1)+1;
             gcond(3).data=gcond(3).data-ones(size(gcond(1).data,1),1)*mean(gcond(3).data(indexbase,:),1)+1;
             gcond(4).data=gcond(4).data-ones(size(gcond(1).data,1),1)*mean(gcond(4).data(indexbase,:),1)+1;
             
         end
         
         
         
         Gcond(1).mean=gcond(1).data;
         Gcond(2).mean=gcond(2).data;
         Gcond(3).mean=gcond(3).data;
         Gcond(4).mean=gcond(4).data;
         
             
         Gcond(1).std=std(squeeze(Faces.matCond1(:,:,m))',0,2);
         Gcond(2).std=std(squeeze(Faces.matCond2(:,:,m))',0,2);
         Gcond(3).std=std(squeeze(Objects.matCond1(:,:,m))',0,2);
         Gcond(4).std=std(squeeze(Objects.matCond2(:,:,m))',0,2);
         
         %      if strcmp(tipo,'Retention')
         %
         %          Gcond(1).mean=Gcond(1).mean-mean(Gcond(1).mean(indexbase))+1;
         %          Gcond(2).mean=Gcond(2).mean-mean(Gcond(2).mean(indexbase))+1;
         %          Gcond(3).mean=Gcond(3).mean-mean(Gcond(3).mean(indexbase))+1;
         %          Gcond(4).mean=Gcond(4).mean-mean(Gcond(4).mean(indexbase))+1;
         %
         %      end
         
         
         
         
         %%STATS
         
         %     DATA={gcond(1).data,gcond(2).data};
         %     [tf dff pvalsf] = statcond(DATA,'mode','perm','paired','on','naccu', 1000);
         %
         %     DATA={gcond(3).data,gcond(4).data};
         %     [to dfo pvalso] = statcond(DATA,'mode','perm','paired','on','naccu', 1000);
         %
         
         DATA={squeeze(Faces.matCond1(:,:,m))',squeeze(Faces.matCond2(:,:,m))'};
         [tf dff pvalsf] = statcond(DATA,'mode','perm','paired','on','naccu', 1500);
         
         DATA={squeeze(Objects.matCond1(:,:,m))',squeeze(Objects.matCond2(:,:,m))'};
         [to dfo pvalso] = statcond(DATA,'mode','perm','paired','on','naccu', 1500);
         
         
         i_indf=find(pvalsf<p);
         i_indo=find(pvalso<p);
         
         %%GRAPH
         
         color_code={[0 1 0],[0 1 1],[0 0 1],[1 0 0]};
         
         %     srate_new=Faces.newsr;
         %     base_time=Faces.base_time;
         if strcmp('Retention',tipo)
             
             base_time=0.4;
         end
         figure
         
         for k=1:size(gcond,2)
             
             
             epoch_l=size(Gcond(k).mean,1);
             
             %         t=[1:epoch_l]/srate_new-base_time;
             
             cond_avg=Gcond(k).mean;
             max_cond(k)=max(cond_avg);
             min_cond(k)=min(cond_avg);
             cond_std=Gcond(k).std;
             mean_plus_error = cond_avg + (cond_std / sqrt(size(Faces.matCond1,1))); % no of epochs
             mean_min_error = cond_avg - (cond_std / sqrt(size(Faces.matCond1,1)));
             hh(k)=plot(t,cond_avg, 'Color',color_code{k}, 'LineWidth', 1.5)
             hold on
             if size(Faces.meanCond1,1)>1
                 f_l=fill([t t(end:-1:1)],[mean_plus_error' mean_min_error(end:-1:1)'],color_code{k},'EdgeColor',color_code{k}); %shaded error bar
             end
             
             set(f_l,'FaceAlpha',.1,'EdgeAlpha',.1)
             
             %     [y,i_ind]= max(cond_avg(151:300));
             hold on;
             
         end
         
         ylim([0 max(max_cond)*1.3])
         xlim([min(t) max(t)])
         
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
                 set(gca,'XTick',(-300:200:1200))
                 
             case 'PostRetention'
                 
                 line([0 0],ylim,'Color','k')
                 line(xlim,[0 0],'Color','k')
                 set(gca,'fontsize', 8)
                 set(gca,'XTick',(-400:200:1600))
                 
             case 'Retention'
                 
                 line([0 0],ylim,'Color','k')
                 line(xlim,[0 0],'Color','k')
                 set(gca,'fontsize', 8)
                 set(gca,'XTick',(-400:200:1400))
                 
         end
         
         legend([hh(1) hh(2) hh(3) hh(4)],{'Faces Binding' 'Faces Features' 'Objects Binding' 'Objects Features'},'Location','NorthEast')
         title(['ERP - Region: ' roi(i).name])
         
         saveas(gcf,[out_path  tipo '_ERP_' roi(i).name '_' num2str(m) '_' freq],'jpg')
         
         
     end
    end
