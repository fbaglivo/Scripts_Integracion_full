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

data=double(EEG.data');
hb.name='beta'
srate=EEG.srate;

%%
   for el=1:size(data,2)
       
        disp(['filter el ' int2str(el) ' of ' int2str(size(data,2))])
        hband=[13 17];
        hband_sig1=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig1=log(abs(hilbert(hband_sig1)).^2)-mean(log(abs(hilbert(hband_sig1)).^2));
        hband=[18 22];
        hband_sig2=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig2=log(abs(hilbert(hband_sig2)).^2)-mean(log(abs(hilbert(hband_sig2)).^2));
        hband=[23 27];
        hband_sig3=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig3=log(abs(hilbert(hband_sig3)).^2)-mean(log(abs(hilbert(hband_sig3)).^2));
        hband=[31 34];
        hband_sig4=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig4=log(abs(hilbert(hband_sig4)).^2)-mean(log(abs(hilbert(hband_sig4)).^2));
        hband_sig(:,el)=mean([hband_sig1 hband_sig2 hband_sig3 hband_sig4 ],2);

        clear hband_sig1 hband_sig2 hband_sig3 hband_sig4
    end
 
    EEG.data=hband_sig';

    EEG = eeg_checkset( EEG );
    EEG = pop_resample( EEG, 100);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
   
    eeglab redraw
    clear hband_sig  
    
    disp(['downsampled to 100Hz'])
    
    pop_saveset(EEG, 'filename',[fname '_' hb.name],'filepath',[path_set '/Powerbands'])
    disp([hb.name ' saved!!'])
    
   

