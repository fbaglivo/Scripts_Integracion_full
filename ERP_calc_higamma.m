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
        hband_sig1=hband_sig1-mean(hband_sig1);
        hband=[76 80];
        hband_sig2=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig2=hband_sig2-mean(hband_sig2);
        hband=[81 85];
        hband_sig3=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig3=hband_sig3-mean(hband_sig3);
        hband=[86 90];
        hband_sig4=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig4=hband_sig4-mean(hband_sig4);
        hband=[81 95];
        hband_sig5=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig5=hband_sig5-mean(hband_sig5);
        hband=[96 100];
        hband_sig6=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig6=hband_sig6-mean(hband_sig6);
        hband=[101 105];
        hband_sig7=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig7=hband_sig7-mean(hband_sig7);
        hband=[106 110];
        hband_sig8=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig8=hband_sig8-mean(hband_sig8);
        hband=[131 135];
        hband_sig9=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig9=hband_sig9-mean(hband_sig9);
        hband=[136 140];
        hband_sig10=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig10=hband_sig10-mean(hband_sig10);
        
        hband=[141 145];
        hband_sig11=butterpass_eeglabdata(data(:,el),hband,srate);
        hband_sig12=hband_sig11-mean(hband_sig11);
        hband=[146 150];
        hband_sig12=butterpass_eeglabdata(data(:,el),hband,srate);
       hband_sig12=hband_sig12-mean(hband_sig12);
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
    
    pop_saveset(EEG, 'filename',[fname '_' hb.name],'filepath',[path_set '/ERP_band'])
    disp([hb.name ' saved!!'])
    
   

