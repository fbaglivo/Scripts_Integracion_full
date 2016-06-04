%Make wSMI Matrix
clc
clear all
close all

color={'r' 'b' 'k' 'k'}

D_P9=load('P9_electrode_dist.mat');
D_P12=load('P12_electrode_dist.mat');


C_P9=triu(D_P9.D);
C_P12=triu(D_P12.D);

%Load Retention low frequency Faces and Objects
P9_ret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_51000');
P12_ret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_51000')

P9_ret_lofreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_Objects_51000');
P12_ret_lofreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_Objects_51000')


%Load Retention High frequency Faces and Objects

P9_ret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_21000');
P12_ret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_21000');


P9_ret_hifreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_Objects_21000');
P12_ret_hifreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_Objects_21000');



%Load PostRetention Low frequency Faces and Objects

P9_postret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_51000');
P12_postret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_51000')

P9_postret_lofreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_Objects_51000');
P12_postret_lofreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_Objects_51000')

%Load PostRetention High frequency Faces and Objects

P9_postret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_21000');
P12_postret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_21000');


P9_postret_hifreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_Objects_21000');
P12_postret_hifreq_obj=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_Objects_21000');


%% Retention Low Feat vs Bind

%Faces
    
Ptemp=P9_ret_lofreq.WSMI_cond2;
Ptemp(P9_ret_lofreq.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
figure(1)
plot(t,vect,color{1});
hold on


Ptemp=P9_ret_lofreq.WSMI_cond1;
Ptemp(P9_ret_lofreq.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
plot(t,vect,color{2});

title('Low Frequency Distance Retentio Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'Figs/9Low Frequency Distance Retentio Feat versus Bind ','jpg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Retentio Low Feat vs Bind

%Objects
    
Ptemp=P9_ret_lofreq_obj.WSMI_cond2;
Ptemp(P9_ret_lofreq_obj.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
figure(2)
plot(t,vect,color{1});
hold on


Ptemp=P9_ret_lofreq_obj.WSMI_cond1;
Ptemp(P9_ret_lofreq_obj.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
plot(t,vect,color{2});

title('Low Frequency Distance Retentio Objects Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'Figs/9Low Frequency Distance Retentio Objects Feat versus Bind ','jpg')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Retention High


%Faces
    
Ptemp=P9_ret_hifreq.WSMI_cond2;
Ptemp(P9_ret_hifreq.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
figure(3)
plot(t,vect,color{1});
hold on


Ptemp=P9_ret_hifreq.WSMI_cond1;
Ptemp(P9_ret_hifreq.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
plot(t,vect,color{2});

title('High Frequency Distance Retentio Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'Figs/9High Frequency Distance Retentio Feat versus Bind ','jpg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Retention Low Feat vs Bind

%Objects
    
Ptemp=P9_ret_hifreq_obj.WSMI_cond2;
Ptemp(P9_ret_hifreq_obj.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
figure(4)
plot(t,vect,color{1});
hold on


Ptemp=P9_ret_hifreq_obj.WSMI_cond1;
Ptemp(P9_ret_hifreq_obj.Ps>0.001)=0;
Ptemp(Ptemp<0)=0;
Smean=triu(Ptemp);
max_d=ceil(max(max(C_P9)));

for i=1:max_d
    
    [z(i).a]=find(C_P9<i&C_P9>i-1);
    Vect(i).data=Smean(z(i).a);
    Vect(i).data(find(Vect(i).data==0))=[];
    vectn(i)=max(size(Vect(i).data));
    vect(i)=nanmean(Vect(i).data);
    if isnan(vect(i))
        vect(i)=0;
    end
end
    

clc
t=1:1:i;
plot(t,vect,color{2});

title('High Frequency Distance Retentio Objects Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'Figs/9High Frequency Distance Retentio Objects Feat versus Bind ','jpg')
