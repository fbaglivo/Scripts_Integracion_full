clear all
close all
clc

electrodo='FS4'
electrodo_num=22;

Retention=open(['Mats/Retention_vs_Electrodo_' electrodo 'diff.mat']);
Decision=open(['Mats/Decision_vs_Electrodo_' electrodo 'diff.mat']);

retention_mean=mean(Retention.cond(1).data(22,:,:),3);

decision_mean=mean(Decision.cond(1).data(22,:,:),3);

% scatter(retention_mean(1:100), decision_mean(21:120),5,'filled');

m=[retention_mean(1:100);decision_mean(21:120)];
[r p]=corr(m');

createFit(double(retention_mean(1:100)),double(decision_mean(21:120)))

