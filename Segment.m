clear all
clc
close all

restoredefaultpath
addpath('C:\Toolbox\eeglab11_0_4_3b\')


%%


fname='Repossini_DBT_PI_Filt_chanselecc'
file=[fname '.set']
path_set='E:\iEEG\10_Repossini_Florencia\DBT\'



eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Chanselecc\']);
EEG = eeg_checkset( EEG );
eeglab redraw

%% Filtering

target={'1','2','3','4','5','6','7','8','9'}

epoca_min=-0.2; % in sec
epoca_max=1;

baseline_max=0;
baseline_min=-200; %in sec

rmbase='on'

for i=[1 2 3 7 8 9]

    
    EEG = pop_epoch( EEG, {  target{i}  }, [epoca_min           epoca_max], 'xx', 'EDF file resampled epochs', 'epochinfo', 'yes');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','xx','gui','off'); 
    EEG = eeg_checkset( EEG );
    if strcmp(rmbase,'on')
        EEG = pop_rmbase( EEG, [baseline_min          baseline_max]);
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
        EEG = eeg_checkset( EEG );
    end
    eeglab redraw

    epochs(i).data=EEG.data;
    epochs(i).name=target{i};
    epochs(i).struct=EEG;

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0); 
    EEG = eeg_checkset( EEG );
    eeglab redraw

end

%%

save([path_set '\Epoched\' fname '_epoched'],'epochs');