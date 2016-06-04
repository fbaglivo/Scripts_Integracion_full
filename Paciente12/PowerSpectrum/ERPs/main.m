clear all
close all
addpath('C:\toolbox\eeglab11_0_4_3b\')

basename_out='IntegracionEEGERPSOutputs_';
basename='IntegracionEEG_';

stim_type={'Retention' 'PostRetention' 'Decision'};
cond_type(1).c1='OB';
cond_type(1).c2='OF';
cond_type(1).t='Objects';

cond_type(2).c1='FB';
cond_type(2).c2='FF';
cond_type(2).t='Faces';

for i=1:size(cond_type,2)
    
    for j=1:size(stim_type,2)
     
        stim_type(j)
        
        main_sub(cell2mat(stim_type(j)), cond_type(i), basename, basename_out);
     
    end
    
end