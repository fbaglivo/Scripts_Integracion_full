clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath('Functions\')


erp='ERP'

salvar=0
%base_time=0;
newsr=100;

% Seleccionar el tipo de prueba a correr

%  tipo='Facebind_vs_Faceint_S1';
% tipo='PostRetention'
% tipo='PostRetention_Objects'
%tipo= 'Faces_vs_objects_S1';
% tipo='Decision_vs'
tipo_full={'Retention' 'PostRetention' 'Decision' 'Retention_Objects' 'PostRetention_Objects' 'Decision_Objects' 'Retention_Features' 'PostRetention_Features' 'Decision_Features'};  %%canal desde 41
test_full={'Faces' 'Faces' 'Faces' 'Objects' 'Objects' 'Objects' 'Features' 'Features' 'Features'};

% 
% % 
% fname=['Paciente8_Faces_Bind_Filt_Reref']
% file=[fname '.set']
% path_set='D:\_INECO\Pacientes\Paciente8_FlorenciaIgnacio\ConMarcas\Integracion\Faces\'
% 
% out_path='Figs\';
% 
% out_path_var='Mats\';
% 
% [cond epoch_window base_window]=configuracion_P8(tipo);  
% base_time=abs(base_window(1)/1000);


% fname=['Paciente6_Object_new']
% file=[fname '.set']
% path_set='D:\_INECO\Pacientes\Paciente6_LizandroAusello\Remark\Integracion\'
% out_path='Figs\Paciente6\';
% 
% out_path_var='Mats\Paciente6\';
% 
% [cond epoch_window base_window]=configuracion_P6(tipo);  
% base_time=abs(base_window(1)/1000);
% 
% 

%%
% 
fname=['Paciente9_Integracion_Full_Filt']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'

rerefavg = 1;

out_path='Figs\Rerefavg\';

out_path_var='Mats\';


%%

eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']); %'Reref\'
EEG = eeg_checkset( EEG );
eeglab redraw

if rerefavg == 1; reref_avg; end

EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, newsr);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw


EEG = pop_eegfilt( EEG, 0, 30, [], [0], 0, 0, 'fir1', 0);
EEG = eeg_checkset( EEG );
eeglab redraw

for condicion=1:size(tipo_full,2)
    
    
    tipo=cell2mat(tipo_full(condicion));
    test=cell2mat(test_full(condicion));

    [cond epoch_window base_window]=configuracion(tipo);  
    base_time=abs(base_window(1)/1000);

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
    
    
    
    %%
    
    % datasets=3:1:size(cond,2)+2;
    %
    %  pop_comperp( ALLEEG, 1, datasets ,[],'addavg','off','addstd','off','addall','on','lowpass',20,'subavg','on','diffavg','on','diffstd','off','tplotopt',{'ydir' 1 'ylim' [-150 150]});
    % %
    % % saveas(gcf, [path_set '\Figs\' fname], 'fig')
    %
    srate_new=EEG.srate;
    %
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
    %
    %
    srate_noresamp=EEG.srate;
    
    %%
    
    %  save([out_path_var tipo],'condp','srate_noresamp')
    
    
    
    for k=1:size(EEG.chanlocs,1)
        
        
        figure
        canal=k;
        
        for i=1:size(cond,2)
            
            
            subplot(3,size(cond,2),i)
            imagesc((1:1:size(cond(i).data,2))/newsr-base_time,1:1:size(cond(i).data,3),squeeze(cond(i).data(canal,:,:))')
            title(['Cond: ' cond(i).name ' - electrodo: ' num2str(EEG.chanlocs(canal).labels) ])
            caxis([-100 100])
            
            line([0 0],ylim,'Color','k')
            line(xlim,[0 0],'Color','k')
            set(gca,'XTick',(-9:0.2:1))
            set(gca,'fontsize', 8)
            %            set(gca,'XTick',(0:0.1:2))
            %
            %         set(gca,'XTick',(-2:0.1:0))
            
            
            hold on
        end
        
        
        %     statistics
        plot_with_sem_prod
        
        saveas(gcf,[out_path  test '\' tipo '\Electrodo_' num2str(canal)],'jpg')
        
        close gcf
        %     EEG.srate=srate_noresamp;
        %
        %     timeF_varios_canales_new
        %
        
        %save([out_path_var tipo '_Electrodo_' num2str(EEG.chanlocs(canal).labels) ],'cond')
        
        
        hold off
        
    end

    [EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,2);
    eeglab redraw;
    
end
