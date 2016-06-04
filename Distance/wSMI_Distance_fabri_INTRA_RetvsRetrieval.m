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

%% Retention Low ret vs postret

Pret=cat(3,P9_ret_lofreq.WSMI_cond2TRIAL,P9_ret_lofreq.WSMI_cond1TRIAL);
Ppostret=cat(3,P9_postret_lofreq.WSMI_cond2TRIAL,P9_postret_lofreq.WSMI_cond1TRIAL);

%make boostrap comparisson

wSMI_ret=reshape(Pret,size(Pret,1)*size(Pret,2),size(Pret,3));

wSMI_postret=reshape(Ppostret,size(Ppostret,1)*size(Ppostret,2),size(Ppostret,3));

DATA={wSMI_ret,wSMI_postret};
[t df pvals] = statcond(DATA,'mode','bootstrap','paired','on','naccu', 1000);

n = 0;


for i = 1:size(Pret,1)
    for j = (i+1):size(Pret,1)
    
        n = n + 1;
        Ps(i,j) = pvals(n);
        Ps(j,i) = pvals(n);
        T (i,j) = t(n);
        T (j,i) = t(n);
        
    end
end


%%
for j=1:size(Pret,3)
    
    Pretonetrial=squeeze(Pret(:,:,j));
    Ppostretonetrial=squeeze(Ppostret(:,:,j));
    
    Pretonetrial(find(Ps>0.001))=0;
    Ppostretonetrial(find(Ps>0.001))=0;
    
    Ptemp=Pretonetrial-Ppostretonetrial;
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
title('Low Frequency Distance diff Ret vs Post')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'Low Frequency Distance Retention diff Feat versus Bind','jpg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Retention Low ret vs postret

Pret=cat(3,P9_ret_hifreq.WSMI_cond2TRIAL,P9_ret_hifreq.WSMI_cond1TRIAL);
Ppostret=cat(3,P9_postret_hifreq.WSMI_cond2TRIAL,P9_postret_hifreq.WSMI_cond1TRIAL);

%make boostrap comparisson

wSMI_ret=reshape(Pret,size(Pret,1)*size(Pret,2),size(Pret,3));

wSMI_postret=reshape(Ppostret,size(Ppostret,1)*size(Ppostret,2),size(Ppostret,3));

DATA={wSMI_ret,wSMI_postret};
[t df pvals] = statcond(DATA,'mode','bootstrap','paired','on','naccu', 1000);

n = 0;


for i = 1:size(Pret,1)
    for j = (i+1):size(Pret,1)
    
        n = n + 1;
        Ps(i,j) = pvals(n);
        Ps(j,i) = pvals(n);
        T (i,j) = t(n);
        T (j,i) = t(n);
        
    end
end


%%
for j=1:size(Pret,3)
    
    Pretonetrial=squeeze(Pret(:,:,j));
    Ppostretonetrial=squeeze(Ppostret(:,:,j));
    
    Pretonetrial(find(Ps>0.001))=0;
    Ppostretonetrial(find(Ps>0.001))=0;
    
    Ptemp=Pretonetrial-Ppostretonetrial;
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
title('High Frequency Distance diff Ret vs Post')
xlabel('Distance')
ylabel('wSMI')
saveas(gcf,'High Frequency Distance diff Retention Feat versus Bind','jpg')
