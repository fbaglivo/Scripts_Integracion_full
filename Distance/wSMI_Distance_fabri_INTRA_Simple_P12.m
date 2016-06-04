%Make wSMI Matrix
clc
clear all
close all

color={'k' 'k' 'k' 'k'}

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


%% Retention Low Feat vs Bind


for j=1:size(P12_ret_lofreq.WSMI_cond2TRIAL,3)
    
    Ptemp=squeeze(P12_ret_lofreq.WSMI_cond2TRIAL(:,:,j)-P12_ret_lofreq.WSMI_cond1TRIAL(:,:,j));
    Ptemp(find(P12_ret_lofreq.Ps>0.001))=0;
    Smean=triu(Ptemp);
    max_d=ceil(max(max(C_P12)));
    
    for i=1:max_d
        
        [z(i).a]=find(C_P12<i&C_P12>i-1);
        Vect(i).data=Smean(z(i).a);
        Vect(i).data(find(Vect(i).data==0))=[];
        vectn(i)=max(size(Vect(i).data));
        vect(i)=nanmean(Vect(i).data);
        if isnan(vect(i))
            vect(i)=0;
        end
    end
    
    mat_n(:,j)=vectn;
    mat_dist(:,j)=vect;

end

vect_dist=mean(mat_dist,2);
vect_n=mean(mat_n,2);

clc
t=1:1:i;
% 
% figure(7)
%  [ax linea1 linea2]=plotyy(t,vect_dist,t,vect_n);
%  set(linea1,'Color',color{1});
%  set(linea2,'LineStyle','--')
%  set(linea2,'Color',color{1});
%  set(ax(2),'ylim',[0 1000])

figure(1)
plot(t,vect_dist,color{1});
title('Low Frequency Distance Retention Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'P9 Low Frequency Distance Retention Feat versus Bind','jpg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Retention Low Feat vs Bind

for j=1:size(P12_ret_hifreq.WSMI_cond2TRIAL,3)
    
    Ptemp=squeeze(P12_ret_hifreq.WSMI_cond2TRIAL(:,:,j)-P12_ret_hifreq.WSMI_cond1TRIAL(:,:,j));
    Ptemp(find(P12_ret_hifreq.Ps>0.001))=0;
    Smean=triu(Ptemp);
    max_d=ceil(max(max(C_P12)));
    
    for i=1:max_d
        
        [z(i).a]=find(C_P12<i&C_P12>i-1);
        Vect(i).data=Smean(z(i).a);
        Vect(i).data(find(Vect(i).data==0))=[];
        vectn(i)=max(size(Vect(i).data));
        vect(i)=nanmean(Vect(i).data);
        if isnan(vect(i))
            vect(i)=0;
        end
    end
    
    
    mat_n(:,j)=vectn;
    mat_dist(:,j)=vect;

end

vect_dist=mean(mat_dist,2);
vect_n=mean(mat_n,2);

clc
t=1:1:i;

% [ax linea1 linea2]=plotyy(t,vect,t,vectn);
% set(linea1,'Color',color{2});
% set(linea2,'LineStyle','--')
% set(linea2,'Color',color{2});
% set(ax(2),'ylim',[0 1000])

figure(2)
plot(t,vect_dist,color{3});
title('High Frequency Distance Retention Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'P9 High Frequency Distance Retention Feat versus Bind','jpg')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PostRetention Low Feat vs Bind


for j=1:size(P12_postret_lofreq.WSMI_cond2TRIAL,3)
    
    Ptemp=squeeze(P12_postret_lofreq.WSMI_cond2TRIAL(:,:,j)-P12_postret_lofreq.WSMI_cond1TRIAL(:,:,j));
    Ptemp(find(P12_postret_lofreq.Ps>0.001))=0;
    Smean=triu(Ptemp);
    max_d=ceil(max(max(C_P12)));
    
    for i=1:max_d
        
        [z(i).a]=find(C_P12<i&C_P12>i-1);
        Vect(i).data=Smean(z(i).a);
        Vect(i).data(find(Vect(i).data==0))=[];
        vectn(i)=max(size(Vect(i).data));
        vect(i)=nanmean(Vect(i).data);
        if isnan(vect(i))
            vect(i)=0;
        end
    end
    
    mat_n(:,j)=vectn;
    mat_dist(:,j)=vect;
    
end

vect_dist=mean(mat_dist,2);
vect_n=mean(mat_n,2);

clc
t=1:1:i;

% [ax linea1 linea2]=plotyy(t,vect,t,vectn);
% set(linea1,'Color',color{2});
% set(linea2,'LineStyle','--')
% set(linea2,'Color',color{2});
% set(ax(2),'ylim',[0 1000])

figure(3)
plot(t,vect_dist,color{2});
title('Low Frequency Distance PostRetention Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')

saveas(gcf,'P9 Low Frequency Distance PostRetention Feat versus Bind','jpg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Retention Low Feat vs Bind

for j=1:size(P12_postret_hifreq.WSMI_cond2TRIAL,3)
    
    Ptemp=squeeze(P12_postret_hifreq.WSMI_cond2TRIAL(:,:,j)-P12_postret_hifreq.WSMI_cond1TRIAL(:,:,j));
    Ptemp(find(P12_postret_hifreq.Ps>0.001))=0;
    Smean=triu(Ptemp);
    max_d=ceil(max(max(C_P12)));
    
    for i=1:max_d
        
        [z(i).a]=find(C_P12<i&C_P12>i-1);
        Vect(i).data=Smean(z(i).a);
        Vect(i).data(find(Vect(i).data==0))=[];
        vectn(i)=max(size(Vect(i).data));
        vect(i)=nanmean(Vect(i).data);
        if isnan(vect(i))
            vect(i)=0;
        end
    end
    
    mat_n(:,j)=vectn;
    mat_dist(:,j)=vect;

end

vect_dist=mean(mat_dist,2);
vect_n=mean(mat_n,2);

clc
t=1:1:i;

% [ax linea1 linea2]=plotyy(t,vect,t,vectn);
% set(linea1,'Color',color{2});
% set(linea2,'LineStyle','--')
% set(linea2,'Color',color{2});
% set(ax(2),'ylim',[0 1000])

figure(4)
plot(t,vect_dist,color{4});
title('High Frequency Distance PostRetention Feat versus Bind')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'P9 High Frequency Distance PostRetention Feat versus Bind','jpg')
