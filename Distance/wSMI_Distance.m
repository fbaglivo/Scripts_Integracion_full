%% wSMI and Electrode Distance

% Load M matrix and then run


alpha=0.001;
dir='/Volumes/FAT/Intero';
cd(dir)

load('ElectrodeDistanceBS128.mat')
triu_d=triu(d);
triu_d=triu_d(triu_d~=0);


%% Resting State
% 
% Control_Rest=squeeze(M(1,:,1,:,:));
% Paciente_Rest=squeeze(M(2,:,1,:,:));
% 
% 
% for i=1:10
%     Control_Rest(i,:,:)=triu(squeeze(Control_Rest(i,:,:)));
% end
% 
% for i=1:10
%     Paciente_Rest(i,:,:)=triu(squeeze(Paciente_Rest(i,:,:)));
% end
% 
% 
% % test=squeeze(Paciente_Rest(1,:,:));
%   
%  
% AVG_control=squeeze(nanmean(Control_Rest, 1));
% AVG_paciente=squeeze(nanmean(Paciente_Rest, 1));
% 
% triu_control=triu(AVG_control);
% triu_paciente=triu(AVG_paciente);
% 
% 
% triu_control=triu_control(triu_control~=0);
% triu_paciente=triu_paciente(triu_paciente~=0);
% triu_d=triu_d(triu_d~=0);
% 
% control=cat(3, triu_control,triu_d);
% paciente=cat(3, triu_paciente,triu_d);
% 
% control=squeeze(control);
% paciente=squeeze(paciente);
% 
% con_ordered_rest=sortrows(control,2);
% pac_ordered_rest=sortrows(paciente,2);
% 
% plot(con_ordered_rest(:,2),smooth(con_ordered_rest(:,1),80))
% hold on
% plot(pac_ordered_rest(:,2), smooth(pac_ordered_rest(:,1),80), 'r')
% 
% 
% predata_con=reshape(Control_Rest,size(Control_Rest,1),size(Control_Rest,2)*size(Control_Rest,3));
% predata_pac=reshape(Paciente_Rest, size(Paciente_Rest,1), size(Paciente_Rest,2)*size(Paciente_Rest,3));
% predata_con=predata_con';
% predata_pac=predata_pac';
% 
% 
% % Elimino sujeto faltante
% Rest_con=predata_con(:,2:10);
% Rest_pac=predata_pac(:,2:10);
% 
% 
% % Calcula Estadística
% data={Rest_con,Rest_pac};
% [t df pvals] = statcond(data, 'mode', 'bootstrap', 'naccu', 1000);
% 
% nr_sig_dif=pvals(pvals<0.001);
% Pvals_matrix=reshape(pvals, 60,60);
% 
% triu_Pvals=triu(Pvals_matrix);
% 
% triu_Pvals(logical(eye(size(triu_Pvals)))) = 0;
% Pvals_ord=triu_Pvals(triu_Pvals~=0);
% 
% Pvals_result=squeeze(cat(3, Pvals_ord, triu_d));
% Pvals_result_ordered=sortrows(Pvals_result,2);
% 
% Pvals_result_ordered(Pvals_result_ordered(:,1)>alpha)=0;
% 
% 
% [i_ind]=find(Pvals_result_ordered(:,1)~=0);
% 
% 
% figure
% %subplot(2,1,1)
% plot(con_ordered_rest(:,2),smooth(con_ordered_rest(:,1),80))
% hold on
% plot(pac_ordered_rest(:,2), smooth(pac_ordered_rest(:,1),80), 'r')
% hold on
% plot(con_ordered_rest(i_ind,2), 0.06, '*', 'Color', 'k', 'MarkerSize', 5)
% ylim([-0.08 0.08])
% 
% % subplot(2,1,2)
% % plot(Pvals_result_ordered(:,2), Pvals_result_ordered(:,1))


%% Active Task


% if condicion==2
%     Task='Pre';
%     
% elseif condicion==4
%     Task='Post';
% end


% All Trials
% control_Active=eval(['C_' num2str(condicion)]); % control;
% paciente_Active=eval(['P_' num2str(condicion)]); % paciente

control_Active=C_2; % pre
paciente_Active=C_4; % post


% Only Correct Trials
% control_Active=eval(['C_' num2str(condicion) 'c']); % control;
% paciente_Active=eval(['P_' num2str(condicion) 'c']); % paciente


triu_d=triu(d);
triu_d=triu_d(triu_d~=0);

mean_control_xChannel=nanmean(control_Active,2);
mean_paciente_xChannel=nanmean(paciente_Active,2);

mean_control_matrix=reshape(mean_control_xChannel, 128,128);
triu_mean_control=triu(mean_control_matrix);
mean_paciente_matrix=reshape(mean_paciente_xChannel, 128,128);
triu_mean_paciente=triu(mean_paciente_matrix);

pre_data_control_active=mean_control_matrix(triu_mean_control~=0);
data_control_active=cat(2,pre_data_control_active, triu_d);
data_control_active_ordered=sortrows(data_control_active, 2);

pre_data_paciente_active=mean_paciente_matrix(triu_mean_paciente~=0);
data_paciente_active=cat(2, pre_data_paciente_active, triu_d);
data_paciente_active_ordered=sortrows(data_paciente_active,2);


Control_Active=zeros(50,128,128);
Paciente_Active=zeros(50,128,128);



    for s=1:50       
        Control_Active(s,:,:)=squeeze(nanmean(M(1,s).Bl3y4, 3));
    end
        
    for s=1:50
        Paciente_Active(s,:,:)=squeeze(nanmean(M(1,s).Bl6y7, 3));
    end

% if condicion==2
%     for s=1:9       
%         Control_Active(s,:,:)=squeeze(nanmean(M(1,s).C2c, 3));
%     end
%         
%     for s=1:9
%         Paciente_Active(s,:,:)=squeeze(nanmean(M(2,s).C2c, 3));
%     end
% end

    
Control_Active_All=Control_Active;
Paciente_Active_All=Paciente_Active;
    
    for i=1:50
        Control_Active(i,:,:)=triu(squeeze(Control_Active(i,:,:)));
    end

    for i=1:50
        Paciente_Active(i,:,:)=triu(squeeze(Paciente_Active(i,:,:)));
    end

Control_Active(isnan(Control_Active))=0;
Paciente_Active(isnan(Paciente_Active))=0;


Data_Active_Control=zeros(8128,50);
Data_Active_Paciente=zeros(8128,50);


for i=1:50
    A=squeeze(Control_Active(i,:,:));
    B=A(A~=0);
    Data_Active_Control(:,i)=B;
end

for i=1:50
    A=squeeze(Paciente_Active(i,:,:));
    B=A(A~=0);
    Data_Active_Paciente(:,i)=B;
end
  


% Calcula Estadística
data={Data_Active_Control,Data_Active_Paciente};
[t df pvals] = statcond(data, 'mode', 'bootstrap', 'naccu', 1000);

nr_sig_dif=pvals(pvals<alpha);


Pvals_result=squeeze(cat(3, pvals, triu_d));
Pvals_result_ordered=sortrows(Pvals_result,2);

Pvals_result_ordered(Pvals_result_ordered(:,1)>alpha)=0;


[i_ind]=find(Pvals_result_ordered(:,1)~=0);


% Plot

% Figura sin Smoothing
f1=figure;
plot(data_control_active_ordered(:,2), data_control_active_ordered(:,1))
hold on
plot(data_paciente_active_ordered(:,2), data_paciente_active_ordered(:,1), 'r')
hold on
plot(data_control_active_ordered(i_ind,2), 0.07, '*', 'Color', 'k', 'MarkerSize', 5)
title(['Tau= ' num2str(tau) ' - ' Task])

f2=figure;
plot(data_control_active_ordered(:,2), smooth(data_control_active_ordered(:,1), 80))
hold on
plot(data_paciente_active_ordered(:,2), smooth(data_paciente_active_ordered(:,1), 80), 'r')
hold on
plot(data_control_active_ordered(i_ind,2), 0.09, '*', 'Color', 'k', 'MarkerSize', 5)
ylim([-0.1 0.1])
title(['Tau= ' num2str(tau) ' - ' Task])

%%
% ROI


ROI_F=[62:69 73:77];

Channels_to_delete=1:128;
Channels_to_delete(ROI_F)=[];

d_ROI=d;
d_ROI(Channels_to_delete,:)=[];
d_ROI_vector=reshape(d_ROI, 1664,1);
d_ROI_vector(d_ROI_vector==0)=[];


% Calcula Estadística
Control_Active_ROI=Control_Active_All;
Control_Active_ROI(:,Channels_to_delete,:)=[];

Paciente_Active_ROI=Paciente_Active_All;
Paciente_Active_ROI(:,Channels_to_delete,:)=[];
 

Data_Active_Control_ROI=zeros(1664,50);
Data_Active_Paciente_ROI=zeros(1664,50);

for i=1:50
    A=squeeze(Control_Active_ROI(i,:,:));
    B=A(A~=0);
    Data_Active_Control_ROI(:,i)=B;
end

for i=1:50
    A=squeeze(Paciente_Active_ROI(i,:,:));
    B=A(A~=0);
    Data_Active_Paciente_ROI(:,i)=B;
end


Data_Active_Control_ROI=Data_Active_Control_ROI(~any(isnan(Data_Active_Control_ROI),2),:);
Data_Active_Paciente_ROI=Data_Active_Paciente_ROI(~any(isnan(Data_Active_Paciente_ROI),2),:);


data={Data_Active_Control_ROI,Data_Active_Paciente_ROI};
[t df pvals_ROI] = statcond(data, 'mode', 'bootstrap', 'naccu', 1000);


mean_ROI_con=nanmean(Data_Active_Control_ROI,2);
mean_ROI_pac=nanmean(Data_Active_Paciente_ROI,2);
mean_ROI_con_pac=cat(2, mean_ROI_con, mean_ROI_pac);

mean_ROI_d=cat(2,mean_ROI_con_pac, d_ROI_vector);
mean_ROI_d_pvals=cat(2, mean_ROI_d, pvals_ROI);

Mean_ROI_ordered=sortrows(mean_ROI_d_pvals, 3);

indexes_ROI=find(Mean_ROI_ordered(:,4)<alpha);

f3=figure;
plot(Mean_ROI_ordered(:,3), smooth(Mean_ROI_ordered(:,1), 80), 'r')
hold on
plot(Mean_ROI_ordered(:,3), smooth(Mean_ROI_ordered(:,2), 80), 'b')
hold on
plot(Mean_ROI_ordered(indexes_ROI,3), 0.0635, '*', 'Color', 'k', 'MarkerSize', 5)
ylim([0.048 0.065])
xlim([0.7 1.9])

%title(['Frontal ROI - Tau: ' num2str(tau) ' - ' num2str(Task)])


