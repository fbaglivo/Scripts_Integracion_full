clc,clear all,

addpath('C:\Toolbox\eeglab11_0_4_3b\')
addpath('Sym\')
addpath(genpath('D:\_INECO\Procesamiento\Toolbox\fieldtrip'));

direc = 'D:\_INECO\Pacientes_Integracion\';

conds1 = {'OB','OF','FB', 'FF'};


tipo='Decision'
pref='RT'

j=0;
for i = [2 3 5:7 10 11  14 16 17 21 26 30 21]%2 3 5:7 10 11 13
    
    j=j+1;
    
    for cond = 1:4
        
        
        disp(['leyendo sujeto ', num2str(i),' cond ',num2str(cond)])
        
        path_set=fullfile(direc,tipo);
        
        if i<10
            
            pac=strcat('S0',num2str(i),pref,'_',num2str(cond),conds1(cond));
            
        else
            
            pac=strcat('S',num2str(i),pref,'_',num2str(cond),conds1(cond));
            
            
        end
        file=strcat(pac,'.set');
        
        eeglab
        EEG = pop_loadset('filename', file ,'filepath', path_set );
        EEG = eeg_checkset( EEG );
        eeglab redraw
        
        data=EEG.data;
        
        Matriz(j,cond,:,:)=mean(data,3);
        
    end
    


end

%%

srate=EEG.srate;

save(['Mats/' tipo '.m'],'Matriz','srate','conds1')
