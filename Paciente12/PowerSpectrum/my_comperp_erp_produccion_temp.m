close all
clear all
clc


restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\Functions\')
addpath('PowerSpectrum/')



erp='ERP'

salvar=0
% Seleccionar el tipo de prueba a correr

% tipo_full={'Retention' 'PostRetention' 'Decision' 'Retention_Objects' 'PostRetention_Objects' 'Decision_Objects' 'Retention_Features' 'PostRetention_Features' 'Decision_Features'};  %%canal desde 41
% test_full={'Faces' 'Faces' 'Faces' 'Objects' 'Objects' 'Objects' 'Features' 'Features' 'Features'};

tipo_full={ 'PostRetention_Objects'};  %%canal desde 41
test_full={ 'Objects'};


%%
% 
fname=['Paciente12_Integracion_Full_Filt']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente12_LB\ConMarcas\Integracion\'

out_path='ERPS\';

out_path_var='ERPS\';

conf_power_P12;

%%

eeglab

%%


EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']); %'Reref\'
EEG = eeg_checkset( EEG );
eeglab redraw


EEG_ORG=EEG;

for condicion=1:size(tipo_full,2)
    
    
    tipo=cell2mat(tipo_full(condicion));
    test=cell2mat(test_full(condicion));

    [cond epoch_window base_window]=configuracion(tipo);  
    base_time=abs(base_window(1)/1000);

    for i=1:size(cond,2)

        EEG=EEG_ORG;
        eeglab redraw
        EEG = eeg_checkset( EEG );
        
        
        EEG = pop_epoch( EEG,   cond(i).type  , epoch_window, 'newname', [cond(i).name], 'epochinfo', 'yes');
        EEG = eeg_checkset( EEG );
        EEG = pop_rmbase( EEG, base_window);
        EEG = eeg_checkset( EEG );
        cond(i).data=EEG.data;
        eeglab redraw
        
        %
        reref_avg_full
        
        % POWER
        
%        tlimits = [-400 1200]%epoch_window*1000; %para que esten los valores en ms
%        tlimitsForBaseline = base_window;

       tlimits = epoch_window*1000; %para que esten los valores en ms
       tlimitsForBaseline = base_window;


       patientROI(1).tipo=tipo;
       patientROI(1).prueba=test;
       patientROI(1).condicion=cond(i).name;
       
       
       [erpsMapsByTrialByROIs(i).data,erpsByROIs(i,:,:,:), meanERPSMap(i,:,:), R, Pboot, Rboot, ERP, freqs, timesout, mbase, maskersp, maskitc, g,Pboottrials] = PlotERPSByROI2(patientROI,EEG,tlimits,cycles,frequencyRange,alpha,fdrCorrect,'test',weightedSignificance,surroundingsWeight,scale,tlimitsForBaseline,basenorm,erpsmax,0);        
       
       
    end

    
    save(['Mats/Paciente12_' cell2mat(tipo_full(condicion)) '_' cell2mat(test_full(condicion)) '.mat'],'erpsMapsByTrialByROIs','erpsByROIs','meanERPSMap', 'freqs', 'timesout')
    
%     figure
%     map=squeeze(meanERPSMap(1,:,:)-meanERPSMap(2,:,:));
%     % imagesc(map)
%     surf(timesout,freqs,map,'edgecolor','none'); axis tight;
%     title([cond(1).name 'vs' cond(2).name '-' cell2mat(tipo_full) '-' cell2mat(test_full) ' ' patientROI.name])
%     l=line([0 0],[0 150]);
%     set(l,'linewidth',2,'color','k','LineStyle','--');
%     caxis([-5 5])
%     view(0,90);
%     ylim([0 150])
%     xlabel('Time (Seconds)'); ylabel('Hz');
%     
%     
%     saveas(gcf,['Figs/' cond(2).name '-' cond(1).name '-' cell2mat(tipo_full(condicion)) '-' cell2mat(test_full(condicion))],'jpg')
%     
    
end


%%
