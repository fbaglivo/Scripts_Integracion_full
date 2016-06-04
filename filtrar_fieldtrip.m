clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath(genpath('D:\_INECO\Procesamiento\Toolbox\fieldtrip\'))

%% Paciente 9
% 
% filen(1).name=['Paciente9_Integracion_NonSpatialBinding'];
% filen(1).marks={'1Acc0','2Acc0','3Acc0','5Acc0','1Acc1','2Acc1','3Acc1','5Acc1'};
% 
% filen(2).name=['Paciente9_Integracion_SpatialBinding'];
% filen(2).marks={'8Acc0','9Acc0','10Acc0','11Acc0','8Acc1','9Acc1','10Acc1','11Acc1'};
% 
% 

% filen(1).name=['Paciente9_Integracion_ObjectBinding'];
% filen(1).marks={'1Acc0','2Acc0','3Acc0','5Acc0','1Acc1','2Acc1','3Acc1','5Acc1'};
% 
% filen(2).name=['Paciente9_Integracion_ObjectFeatures__'];
% filen(2).marks={'8Acc0','9Acc0','10Acc0','11Acc0','8Acc1','9Acc1','10Acc1','11Acc1'};
% 
% filen(3).name=['Paciente9_Integracion_SpatialBinding'];
% filen(3).marks={'15Acc0','16Acc0','17Acc0','19Acc0','15Acc1','16Acc1','17Acc1','19Acc1'};
% 
% filen(4).name=['Paciente9_Integracion_NoNSpatialBinding']; %Faltan los 23
% filen(4).marks={'22Acc0','','24Acc0','26Acc0','22Acc1','','24Acc1','26Acc1'};
% 
% filen(5).name=['Paciente9_Integracion_FaceBinding']; % Ojo Paciente 6 tiene mal las marcas
% filen(5).marks={'29Acc0','30Acc0','42Acc0','32Acc0','29Acc1','30Acc1','42Acc1','32Acc1'};
% 
% filen(6).name=['Paciente9_Integracion_FaceFeatures'];
% filen(6).marks={'35Acc0','36Acc0','41Acc0','38Acc0','35Acc1','36Acc1','41Acc1','35Acc1'};


%%

% 
% % 
% filen(1).name=['Paciente6_ObjectBinding_new_filt'];
% filen(1).marks={'1Acc0','2Acc0','3Acc0','5Acc0','1Acc1','2Acc1','3Acc1','5Acc1'};

% filen(1).name=['Paciente6_ObjectFeature_new'];
% filen(1).marks={'8Acc0','9Acc0','10Acc0','11Acc0','8Acc1','9Acc1','10Acc1','11Acc1'};
% 
% filen(1).name=['Paciente6_Spatial_new'];
% filen(3).marks={'15Acc0','16Acc0','17Acc0','19Acc0','15Acc1','16Acc1','17Acc1','19Acc1'};
% 
 %filen(1).name=['Paciente6_NonSpatial_new']; %Faltan los 23
% filen(4).marks={'22Acc0','','24Acc0','26Acc0','22Acc1','','24Acc1','26Acc1'};
% 
% filen(1).name=['Paciente6_FacesBinding_new']; % Ojo Paciente 6 tiene mal las marcas
% filen(5).marks={'29Acc0','30Acc0','42Acc0','32Acc0','29Acc1','30Acc1','42Acc1','32Acc1'};
% 
% filen(1).name=['Paciente6_FacesFeatures_new'];
% filen(6).marks={'35Acc0','36Acc0','41Acc0','38Acc0','35Acc1','36Acc1','41Acc1','35Acc1'};
% 
% 
% tipos={'Paciente6_ObjectBinding','Paciente6_ObjectoFeatures','Paciente6_SpatialBinding','Paciente6_NoNSpatialBinding','Paciente6_FaceBinding','Paciente6_FaceFeatures'}
% stims={'S1acc0', 'S2acc0', 'S3acc0', 'Testacc0','S1acc1', 'S2acc1', 'S3acc1', 'Testacc1'};

%% Paciente 8
% 
% filen(1).name=['Paciente8_Faces_Bind']; % Ojo Paciente 6 tiene mal las marcas
% filen(1).marks={'29Acc0','30Acc0','42Acc0','32Acc0','29Acc1','30Acc1','42Acc1','32Acc1'};


filen(1).name=['Paciente8_Objects_Bind']; % Ojo Paciente 6 tiene mal las marcas
filen(1).marks={'29Acc0','30Acc0','42Acc0','32Acc0','29Acc1','30Acc1','42Acc1','32Acc1'};


for k=1:size(filen,2)

    fname=filen(k).name
    file=[fname '.set']
 %   path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'
%     path_set='D:\_INECO\Pacientes\Paciente6_LizandroAusello\Remark\Integracion\'
    path_set='D:\_INECO\Pacientes\Paciente8_FlorenciaIgnacio\ConMarcas\Integracion\Objects\';


    cfg.dataset      = [path_set file] %string with the filename
    cfg.continuous   = 'yes' 
    cfg.lpfilter      = 'yes' %   lowpass filter (default = 'no')
    cfg.bsfilter      = 'yes' %or 'yes'  bandstop filter (default = 'no')
    cfg.lpfreq        = 180 %lowpass  frequency in Hz
    cfg.bsfreq        = [48 52; 98 102; 148 152] %bandstop frequency range, specified as [low high] in Hz
    cfg.padding         = 10
    cfg.lpfiltord     = 8 %lowpass  filter order (default set in low-level function)
    cfg.lpfilttype    = 'but' %digital filter type, 'but' or 'firws' or 'fir' or 'firls' (default = 'but')
    cfg.lpfiltdir     = 'twopass' %filter direction, 'twopass' (default), 'onepass' or 'onepass-reverse' or 'onepass-zerophase' (default for firws) or 'onepass-minphase' (firws, non-linear!)
    cfg.lpinstabilityfix = 'split' %deal with filter instability, 'no', 'reduce', 'split' (default  = 'no')
    cfg.lpfiltwintype = 'hamming' %lowpass window type, 'hann' or 'hamming' (default) or 'blackman' or 'kaiser' (firws)
    cfg.plotfiltresp  ='yes';% 'no' or 'yes', plot filter responses (firws, default = 'no')

    [data] = ft_preprocessing(cfg)

    %% HighPass

    hpf=1
    [filt] = ft_preproc_highpassfilter(cell2mat(data.trial)', data.fsample, hpf, 6, 'but','twopass');
    [filt2] = ft_preproc_highpassfilter(filt, data.fsample, hpf, 6, 'but','twopass');
    data.trial=mat2cell(filt2');

    disp('Highpassfiltering done!')

    %% EEGLAB 

    eeglab

    EEG = pop_loadset('filename', file ,'filepath', path_set);
    EEG = eeg_checkset( EEG );
    eeglab redraw

    EEG.data=cell2mat(data.trial);

    if EEG.srate~=512

        disp(['Resampling... original Fs=' num2str(EEG.srate) ' new Fs=512'])
        EEG=pop_resample(EEG,512);


    end

    path_set_out=[path_set 'Filt\'];
    outf=[fname '_Filt'];

    pop_saveset(EEG,'filename', outf,'filepath',path_set_out);
    disp([fname 'filt done!'])
    clear fname file

end
