clear all
clc


basename_out='Paciente12ERPSOutputs_';
basename='Paciente12_';

% stim_type={'Retention' 'PostRetention' 'Decision'};
% cond_type={'Faces' 'Objects' };

stim_type='PostRetention';
cond_type='Objects';

load(['Mats\' basename stim_type '_' cond_type '.mat']);


roi=8;
for roi=1:18

    figure
    map=squeeze(abs(erpsByROIs(2,roi,:,:))-abs(erpsByROIs(1,roi,:,:)));
    imagesc(map)
    surf(timesout,freqs,map,'edgecolor','none'); axis tight;
    title(['ROI' num2str(roi)])
    l=line([0 0],[0 150]);
    set(l,'linewidth',2,'color','k','LineStyle','--');
    caxis([-10 10])
    view(0,90);
    ylim([0 150])
    xlabel('Time (Seconds)'); ylabel('Hz');

end


%%

%     
%     saveas(gcf,['Figs/' cond(2).name '-' cond(1).name '-' cell2mat(tipo_full(condicion)) '-' cell2mat(test_full(condicion))],'jpg')
%     