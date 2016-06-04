% 
clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')

addpath('Functions')
erp='ERP'

salvar=0
base_time=0.2;
% newsr=100;
%canales=25;  %Canal para plotear x trial
fname=['Paciente9_Integracion_Full_Filt_Reref']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'



% Seleccionar el tipo de prueba a correr

%   tipo='Facebind_vs_Faceint_S1';
%tipo='Faces_vs_objects_S1';
%   tipo='Retention'
  tipo='PostRetention'


[cond epoch_window base_window]=configuracion(tipo);  
base_time=abs(base_window(1)/1000);

eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Reref\']);
EEG = eeg_checkset( EEG );
eeglab redraw



for i=1:size(cond,2)
    
    EEG = pop_epoch( EEG,   cond(i).type  , epoch_window, 'newname', [cond(i).name], 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, base_window);
    EEG = eeg_checkset( EEG );
    cond(i).data=EEG.data;

    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',1,'study',0);


%     [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );

    eeglab redraw

end

% canales=input('Ingrese canales a plotear entre [] : ')
%
%%
% 

canal=44
figure;
for j=2:3
    
subplot(2,1,j-1)
% %     subplot(3,size(cond,2),size(cond,2)+j-1)
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',j,'study',0);
    %         eeglab redraw
%     pop_newtimef(EEG, 1, canal, epoch_window*1000, [3 0.5] , 'baseline',base_window, 'alpha',0.05, 'freqs', [0 150], 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1);
    [ersp(j-1,:,:) itc powbase times freqs erspboot itcboot tfdata]=pop_newtimef(EEG, 1, canal, epoch_window*1000 + [0 100], [3 0.5] ,'baseline',0 , 'alpha',0.05, 'freqs', [0 150],'nfreqs', 50 , 'plotitc' , 'off', 'plotphase', 'off', 'padratio', 1);
%     title(['Channel ', EEG.chanlocs(canal,1).labels ' Cond: ' cond(j-2).name])
     set(gca,'fontsize', 8)
end
    
%%
figure
diff=squeeze(ersp(2,:,:))-squeeze(ersp(1,:,:));
imagesc(diff)
    