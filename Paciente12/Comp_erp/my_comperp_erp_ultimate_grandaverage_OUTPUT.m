clear all
clc
close all

cd ..

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
addpath('Functions\')


erp='ERP'

salvar=0
%base_time=0;
newsr=100;

% Seleccionar el tipo de prueba a correr

%  tipo='Facebind_vs_Faceint_S1';
% tipo='PostRetention'
% tipo='PostRetention_Objects'
%tipo= 'Faces_vs_objects_S1';
% tipo='Decision_vs'
tipo='Decision_Objects';  %%canal desde 41
test='Objects';

% 
% % 
% fname=['Paciente8_Faces_Bind_Filt_Reref']
% file=[fname '.set']
% path_set='D:\_INECO\Pacientes\Paciente8_FlorenciaIgnacio\ConMarcas\Integracion\Faces\'
% 
% out_path='Figs\';
% 
% out_path_var='Mats\';
% 
% [cond epoch_window base_window]=configuracion_P8(tipo);  
% base_time=abs(base_window(1)/1000);


% fname=['Paciente6_Object_new']
% file=[fname '.set']
% path_set='D:\_INECO\Pacientes\Paciente6_LizandroAusello\Remark\Integracion\'
% out_path='Figs\Paciente6\';
% 
% out_path_var='Mats\Paciente6\';
% 
% [cond epoch_window base_window]=configuracion_P6(tipo);  
% base_time=abs(base_window(1)/1000);
% 
% 

%%
% 
fname=['Paciente12_Integracion_Full_Filt']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente12_LB\ConMarcas\Integracion\'

out_path='Mats\';

out_path_var='Mats\';

[cond epoch_window base_window]=configuracion(tipo);  
base_time=abs(base_window(1)/1000);

rerefavg = 1;

%%

eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']); %'Filt\''Reref\'
EEG = eeg_checkset( EEG );
eeglab redraw



    
%     badchans
    
%     switch test
        
%         case 'Faces'
%             
%             badchannels=faces_badchans;
%             
%             
%         case 'Objects'
%             
%             badchannels=objects_badchans;
%             
%         case 'Features'
%             
%             badchannels=features_badchans;
%             
%             
            if rerefavg == 1
                              
                reref_avg_full;
                disp('Reref done!')
            
            end
            
%     end


EEG = eeg_checkset( EEG );
EEG = pop_resample( EEG, newsr);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
eeglab redraw


EEG = pop_eegfilt( EEG, 0, 30, [], [0], 0, 0, 'fir1', 0);
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

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',2,'study',0);


%     [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );

    eeglab redraw

end
%%

srate_noresamp=EEG.srate;

%%

rois

%%
for h=1:size(roi,2)

%     figure
    
    for u=1:size(cond,2)
    
        gcond(u).data=[];
%         gcondp(u).data=[];
        
        for p=1:size(roi(h).chan,2)
 
            
                    gcond(u).data=squeeze(cat(2,gcond(u).data,squeeze(cond(u).data(roi(h).chan(p),:,:))));
                
        end
            
        
        Gcond(u).mean(:,h)=mean(gcond(u).data,2);
%         Gcondp(u).mean(:,h)=mean(gcondp(u).data,2);
        
        Gcond(u).std(:,h)=std(gcond(u).data,0,2);
%         Gcondp(u).std(:,h)=std(gcondp(u).data,0,2);
        
        out(h).gcond(u)=gcond(u);
        
        
    end
   
end
    
cd Comp_erp

save([out_path 'ERPs_' test '_' tipo ],'out','base_time','newsr');
%%

