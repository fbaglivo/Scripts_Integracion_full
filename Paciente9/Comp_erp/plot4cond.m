
clear all
close all

cd ..

rois

out_path='Figs\4Cond\'

tipo='Retention'

Faces=load(['Mats/ERPs_Faces_' tipo '.mat' ]);
Objects=load(['Mats/ERPs_Objects_' tipo '.mat' ]);

p=0.005;

for i=1:size(Faces.out,2)
    
    gcond(1).data=Faces.out(i).gcond(1).data;
    gcond(2).data=Faces.out(i).gcond(2).data;
    gcond(3).data=Objects.out(i).gcond(1).data;
    gcond(4).data=Objects.out(i).gcond(2).data;
    
    Gcond(1).mean=mean(Faces.out(i).gcond(1).data,2);
    Gcond(2).mean=mean(Faces.out(i).gcond(2).data,2);
    Gcond(3).mean=mean(Objects.out(i).gcond(1).data,2);
    Gcond(4).mean=mean(Objects.out(i).gcond(2).data,2);
    
    
    Gcond(1).std=std(Faces.out(i).gcond(1).data,0,2);
    Gcond(2).std=std(Faces.out(i).gcond(2).data,0,2);
    Gcond(3).std=std(Objects.out(i).gcond(1).data,0,2);
    Gcond(4).std=std(Objects.out(i).gcond(2).data,0,2);
    
    %%STATS
    
    DATA={gcond(1).data,gcond(2).data};
    [tf dff pvalsf] = statcond(DATA,'mode','perm','paired','on','naccu', 1000);

    DATA={gcond(3).data,gcond(4).data};
    [to dfo pvalso] = statcond(DATA,'mode','perm','paired','on','naccu', 1000);

    i_indf=find(pvalsf<p);
    i_indo=find(pvalso<p);
    
    %%GRAPH
    
    color_code={[0 1 0],[0 1 1],[0 0 1],[1 0 0]};
    
    srate_new=Faces.newsr;
    base_time=Faces.base_time;
    if strcmp('Retention',tipo)
       
        base_time=0.4;
    end
    figure
    
    for k=1:size(gcond,2)
        
        
        epoch_l=size(Gcond(k).mean,1);
        
        t=[1:epoch_l]/srate_new-base_time;
        
        cond_avg=Gcond(k).mean;
        max_cond(k)=max(cond_avg);
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
    
    ylim([-150 max(max_cond)*1.5])
    
    if ~isempty(i_indf)
    
        plot(t(i_indf),max(max_cond)*1.1,'*', 'Color',[0.1 0.5 0.1], 'MarkerSize', 2)
    
    end
    
    
    if ~isempty(i_indo)
    
        plot(t(i_indo),-100,'*', 'Color',[0.5 0.1 0.5], 'MarkerSize', 2)
    
    end
    
    switch tipo
        
        case 'Decision'
            
            line([0 0],ylim,'Color','k')
            line(xlim,[0 0],'Color','k')
            set(gca,'fontsize', 8)
            set(gca,'XTick',(-0.4:0.2:1.5))
            
        case 'PostRetention'
            
            line([0 0],ylim,'Color','k')
            line(xlim,[0 0],'Color','k')
            set(gca,'fontsize', 8)
            set(gca,'XTick',(-0.4:0.2:2))
      
        case 'Retention'
            
            line([0 0],ylim,'Color','k')
            line(xlim,[0 0],'Color','k')
            set(gca,'fontsize', 8)
            set(gca,'XTick',(-0.4:0.2:1.2))
      
    end
    
    legend([hh(1) hh(2) hh(3) hh(4)],{'Faces Binding' 'Faces Features' 'Objects Binding' 'Objects Features'},'Location','NorthEast')
    title(['ERP - Region: ' roi(i).name])
    
    saveas(gcf,[out_path  tipo '_ERP_' roi(i).name],'jpg')

end

