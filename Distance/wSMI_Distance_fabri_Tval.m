%Make wSMI Matrix
clc
clear all
close all

color={'b' 'r' 'c' 'k'}

D_P9=load('P9_electrode_dist.mat');
D_P12=load('P12_electrode_dist.mat');


% C_P9=triu(D_P9);
% C_P12=triu(D_P12);


P9_ret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_51000');
P12_ret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_51000')

P9_ret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_21000');
P12_ret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_21000');


P9_postret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_51000');
P12_postret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_51000')

P9_postret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_21000');
P12_postret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_21000');

%%
Ttemp=T;
Ttemp(find(T>0))=0;
Smean=abs(triu(Ttemp));
max_d=ceil(max(max(C)));

for i=1:max_d
    
    [z(i).a]=find(D<i&D>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end

plot(vect,cell2mat(color(1)))
hold on;
clear Ttemp
Ttemp=T;
Ttemp(find(T<0))=0;
Smean=abs(triu(Ttemp));
max_d=ceil(max(max(C)));

for i=1:max_d
    
    [z(i).a]=find(D<i&D>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end

plot(vect,cell2mat(color(comp)))
hold on;

