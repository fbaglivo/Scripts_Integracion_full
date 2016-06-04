%%Configuraciones de Power Spectrum

typeproc = 1; %deprecated - useless
cycles = 0; %FFT
%cycles = [3 0.5]; %para usar wavelets
frequencyRange = [0 150];
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


patientROI(1).channels=[1 2];
patientROI(1).name='CAG';
% 
 patientROI(2).channels=[3];
 patientROI(2).name='VLG';

patientROI(3).channels=[4 5 6];
patientROI(3).name='FG';

patientROI(4).channels=[8:10];
patientROI(4).name='IOG';

patientROI(5).channels=[11:13];
patientROI(5).name='CN';

patientROI(6).channels=[14 15];
patientROI(6).name='SOG';

patientROI(7).channels=[16:18];
patientROI(7).name='MOG';

patientROI(8).channels=[21:26];
patientROI(8).name='VSPG';

patientROI(9).channels=[28:30];
patientROI(9).name='VAG';

patientROI(10).channels=[31:33];
patientROI(10).name='RP';

patientROI(11).channels=[35 36];
patientROI(11).name='RSPL';

patientROI(12).channels=[37:40];
patientROI(12).name='RAG';

patientROI(13).channels=[41:43];
patientROI(13).name='PCC';

patientROI(14).channels=[50:52];
patientROI(14).name='SMG';

patientROI(15).channels=[53:55];
patientROI(15).name='RLG';

patientROI(16).channels=[61:62];
patientROI(16).name='MITG';

patientROI(17).channels=[63:67];
patientROI(17).name='LSTG';

patientROI(18).channels=[21];
patientROI(18).name='VPC';


% 
% patientROI(1).channels= [1 2 3];
% patientROI(1).name= 'OCCIPITAL';
% 
% patientROI(2).channels= [10 11 12];
% patientROI(2).name= 'OCCIPITAL SUPERIOR';
% 
% patientROI(3).channels= [48 49 50];
% patientROI(3).name= 'TBP';
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
