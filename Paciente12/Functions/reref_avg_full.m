
ref1Limit = 67; %referencias diferentes para los 2 cabezales

chan2remove =[];% ;badchannels%cond(i).badchans;

%ANTES DE EPOCHEAR CAMBIO LA POLARIDAD DE LOS QUE ESTAN INVERTIDOS
gref1 = EEG.data(1:ref1Limit,:); %grupo de canales a referencia 1
group1=gref1;

%elimino los canales ruidosos
gref1chans = chan2remove(chan2remove <= ref1Limit);
gref1(gref1chans,:) = [];
% 
% gref2 = EEG.data(ref1Limit+1:end,:); %grupo de canales a referencia 2
% group2=gref2;
% 
% %invierto la polaridad del grupo 2
% gref2 = gref2 * (-1);
% %elimino los canales ruidosos
% 
% %ver
% gref2chans = chan2remove(chan2remove > ref1Limit) - ref1Limit;
% gref2(gref2chans,:) = [];

%RE REFERENCIO A LA MEDIA POR GRUPO DE CANALES EN CADA REFERENCIA
avg1 = mean(gref1,1);
group1 = group1 - repmat(avg1,size(group1,1),1);
% 
% avg2 = mean(gref2,1);
% group2 = group2 - repmat(avg2,size(group2,1),1);

%reemplazo nuevamente la estructura de eeg
EEG.data = group1; %cat(1,group1,group2);