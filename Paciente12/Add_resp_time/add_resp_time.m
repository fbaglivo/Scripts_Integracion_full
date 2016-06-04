clear all
clc
close all

% 
fname=['Paciente12_Integracion_Full_Filt_FaceResp']
file=[fname '.set']
path_set='D:\_INECO\Pacientes\Paciente12_LB\ConMarcas\Integracion\'

% 
% fname=['Paciente6_Object_new'] %['Paciente6_Faces_new']
% file=[fname '.set']
% path_set='D:\_INECO\Pacientes\Paciente6_LizandroAusello\Remark\Integracion\'



eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']);
EEG = eeg_checkset( EEG );
eeglab redraw



addpath('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion')

%%


paciente='Paciente12_LB'
paradigma='Integracion'


path=['D:\_INECO\Pacientes\' paciente '\Logs\' paradigma '\' ]


file='Objects'
sheet='Objects'
 
%P6 
% file='Parra_FaceBindingFeatures_Ausello_10_06_14'
% sheet='Parra_FaceBindingFeatures_Ausel'

% file='Parra_ObjectBindingFeatures_Ausello_09_06_14.xls'
% sheet='Parra_ObjectBindingFeatures_Aus'

Range6='I2:I141'
% Range7='J2:J131'


rt=make_logtimevector(path,file,sheet,Range6);
% acc=make_logtimevector(path,file,sheet,Range6);


%% 32 Test Binding y 38 Test Features

% Buscar las marcas en donde se inicia el paradigma de face y agregar las
% respuesta...

indices=[];
for i=1:size(EEG.event,2)
    
    types{i}=EEG.event(i).type;
    if strcmp(types(i),'12') %Feat faces 38
        indices=[indices i];
    end

%     if strcmp(types(i),'5Acc0') || strcmp(types(i),'5Acc1')
%         indices=[indices i];
%     end


end

k=size(rt,1)/2;

%%

for j=1:size(indices,2)

    EEG = pop_editeventvals(EEG,'append',{indices(size(indices,2)+1-j) [] [] [] []},'changefield',{indices(size(indices,2)+1-j)+1 'latency' EEG.event(indices(size(indices,2)+1-j)).latency/EEG.srate+rt(k-j+1)/1000},'changefield',{indices(size(indices,2)+1-j)+1 'type' ['R' EEG.event(indices(size(indices,2)+1-j)).type]},'changefield',{indices(size(indices,2)+1-j)+1 'duration' 0});
   

end

eeglab redraw

%%

indices=[];
for i=1:size(EEG.event,2)
    
    types{i}=EEG.event(i).type;
        if strcmp(types(i),'5')%Bind faces 32
            indices=[indices i];
        end
    
% 
%     if strcmp(types(i),'11Acc0') || strcmp(types(i),'11Acc1')
%         indices=[indices i];
%     end
    
end

k=size(rt,1);
%%


for j=1:size(indices,2)

    EEG = pop_editeventvals(EEG,'append',{indices(size(indices,2)+1-j) [] [] [] []},'changefield',{indices(size(indices,2)+1-j)+1 'latency' EEG.event(indices(size(indices,2)+1-j)).latency/EEG.srate+rt(k-j+1)/1000},'changefield',{indices(size(indices,2)+1-j)+1 'type' ['R' EEG.event(indices(size(indices,2)+1-j)).type]},'changefield',{indices(size(indices,2)+1-j)+1 'duration' 0});
   

end

eeglab redraw
