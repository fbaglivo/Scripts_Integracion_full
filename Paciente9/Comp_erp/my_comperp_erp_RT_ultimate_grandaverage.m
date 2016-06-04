clear all
clc
close all

cd ..

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath('Functions\')


erp='ERP'

salvar=0
%base_time=0;
newsr=100;

% Seleccionar el tipo de prueba a correr

tipo='PostRetentionRT_Objects';  %%canal desde 41
test='Objects';
 

%%
% 
fname=['Paciente9_Integracion_Full_Filt']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'

out_path='Figs\Rerefavg_RT\';

out_path_var='Mats\';

[cond epoch_window base_window]=configuracion(tipo);  
base_time=abs(base_window(1)/1000);

load('Mats/RT.mat')

rerefavg = 1;

%%

eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']); %'Filt\''Reref\'
EEG = eeg_checkset( EEG );
eeglab redraw



    
    badchans
    
    switch test
        
        case 'Faces'
            
            badchannels=faces_badchans;
            
            
        case 'Objects'
            
            badchannels=objects_badchans;
            
        case 'Features'
            
            badchannels=features_badchans;
            
            
            if rerefavg == 1;
                
                
                reref_avg;
                disp('Reref done!')
            end
end


EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, newsr);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw


EEG = pop_eegfilt( EEG, 0, 30, [], [0], 0, 0, 'fir1', 0);
EEG = eeg_checkset( EEG );
eeglab redraw


for i=1:size(cond,2)
    
    EEG = pop_epoch( EEG,   cond(i).type  , epoch_window, 'newname', [cond(i).name], 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, base_window);
    EEG = eeg_checkset( EEG );
    cond(i).data=EEG.data;

    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',2,'study',0);


%     [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );

    eeglab redraw

end
%%

datasets=3:1:size(cond,2)+2;

%   pop_comperp( ALLEEG, 1, datasets ,[],'addavg','off','addstd','off','addall','on','lowpass',20,'subavg','on','diffavg','on','diffstd','off','tplotopt',{'ydir' 1 'ylim' [-1 1]});
% 
% saveas(gcf, [path_set '\Figs\' fname], 'fig')

srate_new=EEG.srate;

% %%
% ALLEEG = pop_delset( ALLEEG, [2  3  4  5  6] );
% [EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,1);
% 
% for i=1:size(cond,2)
%     
%     EEG = pop_epoch( EEG,   cond(i).type  , epoch_window, 'newname', [cond(i).name], 'epochinfo', 'yes');
%     EEG = eeg_checkset( EEG );
%     EEG = pop_rmbase( EEG, base_window);
%     EEG = eeg_checkset( EEG );
%     condp(i).data=EEG.data;
% 
%     [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
%     EEG = eeg_checkset( EEG );
% 
%     [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0);
% 
% 
% %     [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
%     EEG = eeg_checkset( EEG );
% 
%     eeglab redraw
% 
% end


srate_noresamp=EEG.srate;

%%

rois
sort_rt
%%
for h=1:size(roi,2)

    figure
    
    for u=1:size(cond,2)
    
        gcond(u).data=[];
%         gcondp(u).data=[];

        can_ok=0;

        for p=1:size(roi(h).chan,2)
 
            if isempty(find(badchannels==roi(h).chan(p)))
                       
                cond(u).data(roi(h).chan(p),:,:)=cond(u).data(roi(h).chan(p),:,index(u).data);
                gcond(u).data=squeeze(cat(2,gcond(u).data,squeeze(cond(u).data(roi(h).chan(p),:,:))));
%                 gcondp(u).data=squeeze(cat(2,gcondp(u).data,squeeze(cond(u).data(roi(h).chan(p),:,:))));          
                can_ok=can_ok+1;
            end
            
        end
        
        n=1;
        
        for indice=1:size(cond(u).data,3)
            
            for indice2=1:can_ok
        
                vect(:,n)=gcond(u).data(:,indice+(indice2-1)*size(cond(u).data,3));
                n=n+1;
                
            end
            
        end
        
        gcond(u).data=vect;
        clear vect
        
        Gcond(u).mean(:,h)=mean(gcond(u).data,2);
%         Gcondp(u).mean(:,h)=mean(gcondp(u).data,2);
        
        Gcond(u).std(:,h)=std(gcond(u).data,0,2);
%         Gcondp(u).std(:,h)=std(gcondp(u).data,0,2);
        
        
        %
        subplot(2,size(gcond,2),u)
        
        imagesc((1:1:size(gcond(u).data,1))/newsr-base_time,1:1:size(gcond(u).data,2),gcond(u).data')
        title(['Cond: ' cond(u).name ' - ROI: ' roi(h).name ])
        caxis([-150 150])
        
        line([0 0],ylim,'Color','k')
        line(xlim,[0 0],'Color','k')
        set(gca,'XTick',(-0.4:0.5:8))
        set(gca,'fontsize', 8)
        %
        hold on
    end
   
    statistics
    
    plot_with_sem_gaverage
    
    saveas(gcf,[out_path  test '\' tipo '\ROI_' roi(h).name '_stats'],'jpg')
        
    close gcf
       
%     
%     EEG.srate=srate_noresamp;
% 
%     timeF_variofgs_canales_new    

    
end



%%

