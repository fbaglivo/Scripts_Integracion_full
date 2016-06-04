clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath(genpath('D:\_INECO\Procesamiento\Toolbox\fieldtrip\'))



filen(1).name=['Paciente12_Integracion_FacesBinding512']; % Ojo Paciente 6 tiene mal las marcas


for k=1:size(filen,2)

    fname=filen(k).name
    file=[fname '.set']
    path_set='D:\_INECO\Pacientes\Paciente12_LB\ConMarcas\Integracion\';


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
