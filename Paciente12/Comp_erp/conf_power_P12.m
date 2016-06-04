%%Configuraciones de Power Spectrum

typeproc = 1; %deprecated - useless
cycles = 0; %FFT
%cycles = [3 0.5]; %para usar wavelets
frequencyRange = [0 50];
alpha = 0.05;
%alpha = 0;
scale = 'log';
erpsmax = [];
basenorm = 0; % 0: divisive baseline; 1: standard deviation

%si quiero false detection rate correction = 1 sino = 0;
fdrCorrect = 0;
%si quiero reduccion de significancia = 1 sino = 0;
weightedSignificance = 0;
surroundingsWeight = 0.5;

%path2save = 'ERPS\1_Complete\';
path2save = 'ERPS\';
erpsmaxForTipo = [4 4 4 3 3 3 3 3 3];
%erpsmax = [];

%CANAL

patientROI(1).channels= [1];
patientROI(1).name= 'C1';


% 
% patientROI(2).channels= [19 22:24 26 27];
% patientROI(2).name= 'FI';
% 
% patientROI(3).channels= [109:111 115:117];
% patientROI(3).name= 'LAD';
% 
% patientROI(4).channels= [29 24:26 39 40];
% patientROI(4).name= 'LAI';
% 
% patientROI(5).channels= [92 93 97 98 101 102];
% patientROI(5).name= 'LPD';
% 
% patientROI(6).channels= [41 42 45:47 52];
% patientROI(6).name= 'LPI';
% 
% patientROI(7).channels= [6 7 31 55 80 106];
% patientROI(7).name= 'C';
% 
% patientROI(8).channels= [74:76 82:84];
% patientROI(8).name= 'OD';
% 
% patientROI(9).channels= [64:66 69:71];
% patientROI(9).name= 'OI';
%EmpathyForPain_P9_Bipolar= EmpathyForPain_P9_Bipolar(1:41);
