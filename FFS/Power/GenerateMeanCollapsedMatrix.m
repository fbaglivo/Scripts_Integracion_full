
% This script collapse electrodes and condition data
% into a struct named cond. 
% Should be executed after main_frange.m 

clear all


stim_type='Retention_Objects';
cond_type='Objects';

filename=['Paciente9ERPSOutputs__' stim_type '_' cond_type '_1 to 40Hz_']


%patient9

for i=1:90

    load(['Mats\' filename  num2str(i) '.mat'])
    
    cond(1).data(i,:,:)=meanCond1;
    cond(2).data(i,:,:)=meanCond2;
   
    clear matCond1 matCond2 meancCond1 mean Cond2 timesout
    
end

save(['Mats\' filename '.mat'], 'cond');




clear cond


filename=['Paciente12ERPSOutputs__' stim_type '_' cond_type '_1 to 40Hz_']

%patient12

for i=1:67

    load(['Mats\' filename  num2str(i) '.mat'])
    
    cond(1).data(i,:,:)=meanCond1;
    cond(2).data(i,:,:)=meanCond2;
   
    clear matCond1 matCond2 meancCond1 mean Cond2 timesout
    
end

save(['Mats\' filename '.mat'], 'cond');