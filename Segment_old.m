clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath(genpath('D:\_INECO\Procesamiento\Toolbox\fieldtrip\'))

%%

file='Paciente9_TMaze.set'
path='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\TMAZE\'
outputf=[path file '_epochs']


eeglab
EEG = pop_loadset('filename', file ,'filepath', path);
EEG = eeg_checkset( EEG );
eeglab redraw


%%

target={'222','223','224','225','212','213','214','215'}


%%


epoca_min=; % En segundos
epoca_max=;
r_baseline='on';
baseline_min=-0.2;  % En ms
baseline_max=0;



for i=[1:4 6 7]

    
    EEG = pop_epoch( EEG, {  target{i}  }, [epoca_min           epoca_max], 'xx', 'EDF file resampled epochs', 'epochinfo', 'yes');
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','xx','gui','off'); 
    EEG = eeg_checkset( EEG );
    if strcmo(r_baseline,'on')
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
save(outputf,'epochs')