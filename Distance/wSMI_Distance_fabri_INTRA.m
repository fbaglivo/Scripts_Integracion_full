%Make wSMI Matrix
clc
clear all
close all

color={'b' 'r' 'c' 'k'}

D_P9=load('P9_electrode_dist.mat');
D_P12=load('P12_electrode_dist.mat');


C_P9=triu(D_P9.D);
C_P12=triu(D_P12.D);


P9_ret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_51000');
P12_ret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_51000')

P9_ret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_Retention_21000');
P12_ret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_Retention_21000');


P9_postret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_51000');
P12_postret_lofreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_51000')

P9_postret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\P9_PostRetention_21000');
P12_postret_hifreq=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\P12_PostRetention_21000');

%% Retention vs Retrieval


for j=1:size(P9_ret_hifreq.WSMI_cond2TRIAL,3)
    
    Ptemp=squeeze(P9_ret_hifreq.WSMI_cond2TRIAL(:,:,j)-P9_ret_hifreq.WSMI_cond1TRIAL(:,:,j));
    Ptemp(find(P9_ret_hifreq.Ps>0.001))=0;
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
    

    mat_dist(:,j)=vect;

end

vect_dist=mean(mat_dist,2);

clc
t=1:1:i;

% [ax linea1 linea2]=plotyy(t,vect,t,vectn);
% set(linea1,'Color',color{2});
% set(linea2,'LineStyle','--')
% set(linea2,'Color',color{2});
% set(ax(2),'ylim',[0 1000])
plot(t,vect_dist,color{1});


hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear Ptemp

for j=1:size(P9_ret_lofreq.WSMI_cond2TRIAL,3)

    Ptemp=P9_postret_lofreq.WSMI_cond2TRIAL(:,:,j)-P9_postret_lofreq.WSMI_cond1TRIAL(:,:,j);
    Ptemp(find(P9_postret_lofreq.Ps>0.001))=0;
    Smean=triu(Ptemp);
    max_d=ceil(max(max(C_P9)));
    
    
    for i=1:max_d
        
        [z(i).a]=find(C_P9<i&C_P9>i-1);
        Vect2(i).data=Smean(z(i).a);
        Vect2(i).data(find(Vect(i).data==0))=[];
        
        vectn(i)=max(size(Vect(i).data));
        vect2(i)=nanmean(Vect(i).data);
        if isnan(vect2(i))
            vect2(i)=0;
        end
    end

    
    mat_dist2(:,j)=vect2;
end
%%

clc
% t=1:1:i;
% [ax linea1 linea2]=plotyy(t,vect,t,vectn);
% set(linea1,'Color',color{1});
% set(linea2,'LineStyle','--')
% set(linea2,'Color',color{1});
% set(ax(2),'ylim',[0 1000])


vect_dist2=mean(mat_dist2,2);


plot(t,vect_dist2,color{2});
hold on;


