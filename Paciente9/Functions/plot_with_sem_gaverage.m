

i_ind=find(pvals<0.005);

color_code={[0 0 1],[1 0 0],[0 1 1],[0 1 0]};

% figure

for k=1:size(cond,2)

%      subplot(3,size(cond,2),size(cond,2)+1:size(cond,2)*2)
    
    subplot(2,size(cond,2),3:4)
    
    epoch_l=size(Gcond(k).mean,1);
%     srate_new=EEG.srate;
    t=[1:epoch_l]/srate_new-base_time;

    cond_avg=Gcond(k).mean(:,h);
    max_cond(k)=max(cond_avg);
    cond_std=Gcond(k).std(:,h);
	mean_plus_error = cond_avg + (cond_std / sqrt(size(gcond(k).data,2))); % no of epochs
	mean_min_error = cond_avg - (cond_std / sqrt(size(gcond(k).data,2)));
    hh(k)=plot(t,cond_avg, 'Color',color_code{k}, 'LineWidth', 1.5)
    hold on
    f_l=fill([t t(end:-1:1)],[mean_plus_error' mean_min_error(end:-1:1)'],color_code{k},'EdgeColor',color_code{k}); %shaded error bar
	set(f_l,'FaceAlpha',.1,'EdgeAlpha',.1)

%     [y,i_ind]= max(cond_avg(151:300));
    hold on;
    
end

if ~isempty(i_ind)

    plot(t(i_ind),max(max_cond)*1.1,'*', 'Color',[0.5 0.5 0.5], 'MarkerSize', 2)

end

switch test
    
    case 'Faces'
% 
%           line([-1 -1],ylim,'Color','k','LineStyle',':')
%           line([-3 -3],ylim,'Color','k','LineStyle',':')
%           line([-4.2 -4.2],ylim,'Color','r','LineStyle',':')
%           line([-4.4 -4.4],ylim,'Color','r','LineStyle',':')
%           line([0 0],ylim,'Color','k')
         line([0 0],ylim,'Color','k')
         line(xlim,[0 0],'Color','k')
          set(gca,'XTick',(-4.8:0.5:1))
         set(gca,'fontsize', 8)
%          set(gca,'XTick',(0:0.1:2))
%           set(gca,'XTick',(-0.4:0.1:2))
set(gca,'XTick',(-0.4:0.5:8))

     case 'Objects'  

% %          
%          line([-1 -1],ylim,'Color','k','LineStyle',':')
%          line([-4 -4],ylim,'Color','k','LineStyle',':')
%          line([-7 -7],ylim,'Color','k','LineStyle',':')
%          line([-9.2 -9.2],ylim,'Color','r','LineStyle',':')
%          line([-9.4 -9.4],ylim,'Color','r','LineStyle',':')
%          line([0 0],ylim,'Color','k')
         line([0 0],ylim,'Color','k')
         line(xlim,[0 0],'Color','k')
          set(gca,'XTick',(-0.4:0.5:8))
         
%          set(gca,'XTick',(-9.4:0.5:1))
         set(gca,'fontsize', 8)
         
     case  'Features'
%         
%          line([-1 -1],ylim,'Color','k','LineStyle',':')
%          line([-4 -4],ylim,'Color','k','LineStyle',':')
%          line([-7 -7],ylim,'Color','k','LineStyle',':')
%          line([-9.2 -9.2],ylim,'Color','r','LineStyle',':')
%          line([-9.4 -9.4],ylim,'Color','r','LineStyle',':')
%          line([0 0],ylim,'Color','k')
         line([0 0],ylim,'Color','k')
         line(xlim,[0 0],'Color','k')
         set(gca,'XTick',(-0.4:0.1:1.5))
         
%          set(gca,'XTick',(-9.6:0.5:1))
         set(gca,'fontsize', 8)
         
end

        
tam=size(hh,2);

switch tam

    case 3
        
        legend([hh(1) hh(2) hh(3)],{cond(1).name cond(2).name cond(3).name},'Location','NorthWest')
    
    case 2
        
        legend([hh(1) hh(2)],{cond(1).name cond(2).name },'Location','NorthWest')

    case 4

        legend([hh(1) hh(2) hh(3) hh(4)],{cond(1).name cond(2).name cond(3).name cond(4).name },'Location','NorthWest')

    end
    

title([erp ' Roi: ' roi(h).name ])

%  
%  if salvar==1
%  
%     saveas(gcf,[out_path erp '_electrodo_' num2str(EEG.chanlocs(canal).labels) ],'fig')
%  
%  end