clear all
close all
clc

%%


path_mat=('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\SMI_P12\')
fname='Retention_Objects'
cond1=load([path_mat 'SMI_' fname '_Binding' '.mat']);
cond2=load([path_mat 'SMI_' fname '_Features' '.mat']);

%% Seleccionar el tau (Frecuencia de análisis)

% ntau=1;  tau=2;  f=85; taums = 2; 
ntau=2;  tau=4;  f=42;  taums = 4; 
% ntau=3;  tau=8;  f=21;  taums = 8; 
% ntau=4;  tau=16;  f=10;  taums = 16; 
% ntau=5;  tau=32;  f=5;  taums = 32; 
 

%%
%                              Comienza el Script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

color2 = [1 0 0]; %% 
color1 = [0 0 1]; %% 

%%
% 
% 
% load([path_mat 'channels.mat']);
% canales=size(channels,2);

%%

wSMI_cond1=cell2mat(cond1.wSMI.Trials(ntau));
wSMI_cond2=cell2mat(cond2.wSMI.Trials(ntau));


wSMI_cond1mean=cell2mat(cond1.wSMI.MEAN(ntau));
wSMI_cond2mean=cell2mat(cond2.wSMI.MEAN(ntau));



%%

% bl_whole = binding whole
% bl_single= binding single probe
% sol_whole= shape only whole
% sol_single= shape only single probe


n = 0;

for i = 1:67
    for j = (i+1):67
    
        n = n + 1;
        WSMI_cond1(i,j) = wSMI_cond1(n);
        WSMI_cond1(j,i) = wSMI_cond1(n);
        WSMI_cond2(i,j) = wSMI_cond2(n);
        WSMI_cond2(j,i) = wSMI_cond2(n);

        
        WSMI_cond1TRIAL(i,j,:)=wSMI_cond1(n,:);
        WSMI_cond1TRIAL(j,i,:)=wSMI_cond1(n,:);
        WSMI_cond2TRIAL(i,j,:)=wSMI_cond2(n,:);
        WSMI_cond2TRIAL(j,i,:)=wSMI_cond2(n,:);
        
    end
end



%%

% T_cond1=reshape(WSMI_cond1,1,max(size(WSMI_cond1))*max(size(WSMI_cond1)));
% 
% T_cond2=reshape(WSMI_cond2,1,max(size(WSMI_cond2))*max(size(WSMI_cond2)));


    


%% 
DATA={wSMI_cond1,wSMI_cond2};
[t df pvals] = statcond(DATA,'mode','bootstrap','paired','on','naccu', 1000);

n = 0;


for i = 1:67
    for j = (i+1):67
    
        n = n + 1;
        Ps(i,j) = pvals(n);
        Ps(j,i) = pvals(n);
        T (i,j) = t(n);
        T (j,i) = t(n);
        
    end
end


%%

save(['P12_' fname '_' num2str(ntau) '1000.mat' ],'WSMI_cond1','WSMI_cond2','WSMI_cond1TRIAL','WSMI_cond2TRIAL','T','Ps');