
addpath('C:\toolbox\eeglab11_0_4_3b\')

basename_out='Paciente12ERPSOutputs_';
basename='Paciente12_';

% stim_type={'Retention' 'PostRetention' 'Decision'};
% cond_type={'Faces' 'Objects' };

stim_type={'Retention'};
cond_type={'Faces' 'Objects' };



for i=1:size(cond_type,2)
    
    for j=1:size(stim_type,2)
     
        stim_type(j)
        
        main_sub(cell2mat(stim_type(j)), cell2mat(cond_type(i)), basename, basename_out);
     
    end
    
end