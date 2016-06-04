clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\Functions\')


erp='ERP'

salvar=0
%base_time=0;
% newsr=100;

%% Seleccionar el tipo de prueba a correr
% 
% tipo_full={'Retention' 'PostRetention' 'Decision' 'Retention_Objects' 'PostRetention_Objects' 'Decision_Objects' 'Retention_Features' 'PostRetention_Features' 'Decision_Features'};  %%canal desde 41
% test_full={'Faces' 'Faces' 'Faces' 'Objects' 'Objects' 'Objects' 'Features' 'Features' 'Features'};


tipo_full={'Retention'};
test_full={'Faces'} ;


%%
 
fname=['Paciente9_Integracion_Full_Filt']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'
%out_path='Figs\Noref\';
out_path_var='Mats\MI\';
rerefavg=1;

%%

eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']); %'Reref\'
EEG = eeg_checkset( EEG );
eeglab redraw

%%


EEG = eeg_checkset( EEG );
% EEG = pop_resample( EEG, newsr);
% [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
% EEG = eeg_checkset( EEG );
eeglab redraw


% EEG = pop_eegfilt( EEG, 0, 30, [], [0], 0, 0, 'fir1', 0);
% EEG = eeg_checkset( EEG );
% eeglab redraw

for condicion=1:size(tipo_full,2)
    
    
    tipo=cell2mat(tipo_full(condicion));
    test=cell2mat(test_full(condicion));

    if rerefavg == 1;
        
        badchans
        
        switch test
            
            case 'Faces'
                
                badchannels=faces_badchans;
                disp('Reref done!')
                
            case 'Objects'
                
                badchannels=objects_badchans;
                disp('Reref done!')
            case 'Features'
                
                badchannels=features_badchans;
                disp('Reref done!')
                
        end
        
        reref_avg;
        
    
    end


    
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
        
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0);
        
        
%         [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        EEG = eeg_checkset( EEG );
        
        eeglab redraw
        
    end
    
    
    [EEG ALLEEG CURRENTSET] = eeg_retrieve(ALLEEG,2);
    eeglab redraw;

     save([out_path_var tipo],'cond')

end


