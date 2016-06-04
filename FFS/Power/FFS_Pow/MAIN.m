close all
clear all
clc

freq='55 to 150'%'55 to 150'%'1 to 40Hz_'

w_size=500/1000;
offset=600/1000;  % Change between Retention (600) and Retrieval (1000)

tipo='Faces';
fase_temp='Retention';

switch tipo
   
    case 'Objects'
   
        fase=strcat(fase_temp,'_',tipo);
        brain_cor='cor2patOBJ_size2.mat';
        brain_sag='sag2patOBJ_size2.mat';
        brain_saginv='saginv2patOBJ_size2.mat';

        
    case 'Faces'
        
        fase=fase_temp;
        brain_cor='cor2patFAC_size2.mat';
        brain_sag='sag2patFAC_size2.mat';
        brain_saginv='saginv2patFAC_size2.mat';


end

[tt pp]=Main_multi_function_tvals24mayo(fase,tipo,freq,w_size,offset,brain_sag,brain_cor,brain_saginv)