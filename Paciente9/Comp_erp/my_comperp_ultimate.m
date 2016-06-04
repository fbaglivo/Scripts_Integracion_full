


clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')

band='beta'

erp=['PERP' band];

salvar=0
base_time=0.2;
newsr=100;
%canales=25;  %Canal para plotear x trial
fname=['Paciente9_Integracion_Full_Filt_Reref_' band]
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'



% Seleccionar el tipo de prueba a correr

  tipo='Facebind_vs_Faceint_S1';
%tipo='Faces_vs_objects_S1';
% tipo='Valencias_palabras';
% tipo='Valencias';


switch tipo

    case 'Facebind_vs_Faceint_S1'
        cond(1).type={'29Acc0' '29Acc1'}
        cond(1).name='Face_binding'
        cond(2).type={'35Acc0' '35Acc1'}
        cond(2).name='Face_feature'
        
    case 'Faces_vs_objects_S1'
        
        cond(1).type={'29Acc1' '35Acc1' '29Acc0' '35Acc0'}
        cond(1).name='Faces'
        cond(2).type={'1Acc1'   '8Acc1' '1Acc0'   '8Acc0'}
         cond(2).name='Objects'
%         cond(3).type={'3'}
%         cond(3).name='Neutral'

        
    case 'Valencia_palabras'
        
        cond(1).type={'7'}
        cond(1).name='Negativo'
        cond(2).type={'8'}
        cond(2).name='Positivo'
        cond(3).type={'9'}
        cond(3).name='Neutral'


    case 'Valencias'
        
        cond(1).type={'1' '7'}
        cond(1).name='Negativo'
        cond(2).type={'2' '8'}
        cond(2).name='Positivo'
        cond(3).type={'3' '9'}
        cond(3).name='Neutral'

        
end



eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Powerbands\']);
EEG = eeg_checkset( EEG );
eeglab redraw


EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, newsr);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw


for i=1:size(cond,2)
    
    EEG = pop_epoch( EEG,   cond(i).type  , [-0.2  1.8], 'newname', [cond(i).name], 'epochinfo', 'yes');
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-200     0]);
    EEG = eeg_checkset( EEG );
    cond(i).data=EEG.data;

    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',2,'study',0);


%     [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );

    eeglab redraw

end
%%

datasets=3:1:size(cond,2)+2;

 pop_comperp( ALLEEG, 1, datasets ,[],'addavg','off','addstd','off','addall','on','lowpass',20,'subavg','on','diffavg','on','diffstd','off','tplotopt',{'ydir' 1 'ylim' [-10 10]});

saveas(gcf, [path_set '\Figs\' fname], 'fig')

%%

canales=input('Ingrese canales a plotear entre [] : ')

for k=1:size(canales,2)

    canal=canales(k);

%     for i=1:size(cond,2)
% 
% %         figure
% %         subplot(2,2,3:4)
%         imagesc((1:1:size(cond(i).data,2))/newsr-base_time,1:1:size(cond(i).data,3),squeeze(cond(i).data(canal,:,:))')
%         title(['Cond: ' cond(i).name ' - electrodo: ' num2str(EEG.chanlocs(canal).labels) ])
%         caxis([-2 2])
%         
%         line([0 0],ylim,'Color','k')
%         set(gca,'XTick',(-0.2:0.1:1.8))
%  
%         if salvar==1
%  
%             saveas(gcf,[out_path 'Cond_' cond(i).name '_electrodo_' num2str(EEG.chanlocs(canal).labels) '_' band ],'fig')
%         
%         end
%     end



    statistics
    plot_with_sem
    
end