% clear all
% clc
% close all
% 
% fname=['Paciente9_Integracion_Full_Filt']
% file=[fname '.set']
% path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'
% 
% 
% eeglab
% EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']);
% EEG = eeg_checkset( EEG );
% eeglab redraw
% 
% 
% 
% addpath('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion')
paciente='Paciente9_AlfredoFarinelli'
paradigma='Integracion'
% archivo='20141102_Farinelli_Mario_Faces_PII'

% archivo='2014_11_1_Alfredo_MarioWM_Objetos' 

path=['D:\_INECO\Pacientes\' paciente '\Logs\' paradigma '\']
% file='2014_11_1_Alfredo_MarioWM_Objetos'
% sheet='2014_11_1_Alfredo_MarioWM_Objet'
file='2014_11_3_Alfredo_MarioWM_Integracion2'
sheet='2014_11_3_Alfredo_MarioWM_Integ'



Range6='I67:I131'
Range7='J67:J131'


rt=make_logtimevector(path,file,sheet,Range7);
acc=make_logtimevector(path,file,sheet,Range6);


%% 32 Test Binding y 38 Test Features

% Buscar las marcas en donde se inicia el paradigma de face y agregar las
% respuesta...

indices=[];
for i=1:size(EEG.event,2)
    
    types{i}=EEG.event(i).type;
%     if strcmp(types(i),'32Acc0') || strcmp(types(i),'32Acc1')
%         indices=[indices i];
%     end

    if strcmp(types(i),'19Acc0') || strcmp(types(i),'19Acc1')
        indices=[indices i];
    end


end

k=size(rt,1);

%%

for j=1:size(indices,2)

    EEG = pop_editeventvals(EEG,'append',{indices(size(indices,2)+1-j) [] [] [] []},'changefield',{indices(size(indices,2)+1-j)+1 'latency' EEG.event(indices(size(indices,2)+1-j)).latency/EEG.srate+rt(k-j+1)/1000},'changefield',{indices(size(indices,2)+1-j)+1 'type' ['R' EEG.event(indices(size(indices,2)+1-j)).type]},'changefield',{indices(size(indices,2)+1-j)+1 'duration' 0});
   

end

eeglab redraw

%%
% 
% indices=[];
% for i=1:size(EEG.event,2)
%     
%     types{i}=EEG.event(i).type;
% %     if strcmp(types(i),'38Acc0') || strcmp(types(i),'38Acc1')
% %         indices=[indices i];
% %     end
% %     
% 
%     if strcmp(types(i),'11Acc0') || strcmp(types(i),'11Acc1')
%         indices=[indices i];
%     end
%     
% end
% 
% k=size(rt,1);
% %%
% 
% 
% for j=1:size(indices,2)
% 
%     EEG = pop_editeventvals(EEG,'append',{indices(size(indices,2)+1-j) [] [] [] []},'changefield',{indices(size(indices,2)+1-j)+1 'latency' EEG.event(indices(size(indices,2)+1-j)).latency/EEG.srate+rt(k-j+1)/1000},'changefield',{indices(size(indices,2)+1-j)+1 'type' ['R' EEG.event(indices(size(indices,2)+1-j)).type]},'changefield',{indices(size(indices,2)+1-j)+1 'duration' 0});
%    
% 
% end
% 
% eeglab redraw
