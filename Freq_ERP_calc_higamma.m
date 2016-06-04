clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')

%%

fname=['Paciente9_Integracion_Full_Filt']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'



addpath(genpath('C:\Toolbox\fieldtrip\'))


eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']);
EEG = eeg_checkset( EEG );
eeglab redraw

data=double(EEG.data');
hb.name='higamma'
srate=EEG.srate;

%%
   for el=1:size(data,2)
       
        disp(['filter el ' int2str(el) ' of ' int2str(size(data,2))])
        hband=[71 75];
        hband_sig1=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig1=log(abs(hilbert(hband_sig1)).^2)-mean(log(abs(hilbert(hband_sig1)).^2));
        hband=[76 80];
        hband_sig2=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig2=log(abs(hilbert(hband_sig2)).^2)-mean(log(abs(hilbert(hband_sig2)).^2));
        hband=[81 85];
        hband_sig3=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig3=log(abs(hilbert(hband_sig3)).^2)-mean(log(abs(hilbert(hband_sig3)).^2));
        hband=[86 90];
        hband_sig4=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig4=log(abs(hilbert(hband_sig4)).^2)-mean(log(abs(hilbert(hband_sig4)).^2));
        hband=[81 95];
        hband_sig5=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig5=log(abs(hilbert(hband_sig5)).^2)-mean(log(abs(hilbert(hband_sig5)).^2));
        hband=[96 100];
        hband_sig6=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig6=log(abs(hilbert(hband_sig6)).^2)-mean(log(abs(hilbert(hband_sig6)).^2));
        hband=[101 105];
        hband_sig7=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig7=log(abs(hilbert(hband_sig7)).^2)-mean(log(abs(hilbert(hband_sig7)).^2));
        hband=[106 110];
        hband_sig8=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig8=log(abs(hilbert(hband_sig8)).^2)-mean(log(abs(hilbert(hband_sig8)).^2));
        hband=[131 135];
        hband_sig9=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig9=log(abs(hilbert(hband_sig9)).^2)-mean(log(abs(hilbert(hband_sig9)).^2));
        hband=[136 140];
        hband_sig10=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig10=log(abs(hilbert(hband_sig10)).^2)-mean(log(abs(hilbert(hband_sig10)).^2));
        hband=[141 145];
        hband_sig11=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig11=log(abs(hilbert(hband_sig11)).^2)-mean(log(abs(hilbert(hband_sig11)).^2));
        hband=[146 150];
        hband_sig12=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig12=log(abs(hilbert(hband_sig12)).^2)-mean(log(abs(hilbert(hband_sig12)).^2));
        hband_sig(:,el)=mean([hband_sig1 hband_sig2 hband_sig3 hband_sig4 hband_sig5 hband_sig6...
            hband_sig7 hband_sig8 hband_sig9 hband_sig10 hband_sig11 hband_sig12],2);

        clear hband_sig1 hband_sig2 hband_sig3 hband_sig4 hband_sig5 hband_sig6
        clear hband_sig7 hband_sig8 hband_sig9 hband_sig10 hband_sig11 hband_sig12
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
    
   

