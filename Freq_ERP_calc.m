clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')

%%

fname=['Paciente9_Integracion_Full_Filt_Reref']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'



addpath(genpath('C:\Toolbox\fieldtrip\'))


eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Reref\']);
EEG = eeg_checkset( EEG );
eeglab redraw


%%


hb(1).band= [2 4]
hb(1).name= 'delta'

hb(2).band= [4 8]
hb(2).name= 'theta'

hb(3).band= [8 12]
hb(3).name= 'alpha'


for f=1:3
    
    hband=hb(f).band;
    EEG = pop_eegfilt( EEG, hband(1), hband(2), [], [0], 0, 1, 'fir1', 0);
  
    hband_sig=EEG.data;
   
    for el=1:size(hband_sig,1)

        hband_sig1(el,:)=log(abs(hilbert(hband_sig(el,:))).^2)-mean(log(abs(hilbert(hband_sig(el,:))).^2));


    end


    EEG.data=hband_sig1;

    EEG = eeg_checkset( EEG );
    EEG = pop_resample( EEG, 100);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0);

    eeglab redraw
    clear hband_sig  hband_sig1

    disp(['downsampled to 100Hz'])
    
    pop_saveset(EEG, 'filename',[fname '_' hb(f).name],'filepath',[path_set '/Powerbands'])
    disp([hb(f).name ' saved!!'])
end