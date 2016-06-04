%-------FACES--------------------------------------------------------
i = 0;

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'TPM';
EmpathyForPain_P9_Anatomic(i).channels = [1:2 5];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'TPL';
EmpathyForPain_P9_Anatomic(i).channels = [6:10];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'A';
EmpathyForPain_P9_Anatomic(i).channels = [11:16];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'STG';
EmpathyForPain_P9_Anatomic(i).channels = [17:19];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'FG';
EmpathyForPain_P9_Anatomic(i).channels = [20:22];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PITG';
EmpathyForPain_P9_Anatomic(i).channels = [24:27];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'POG';
EmpathyForPain_P9_Anatomic(i).channels = [28:35];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'LOG';
EmpathyForPain_P9_Anatomic(i).channels = [36:42];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'ACC';
EmpathyForPain_P9_Anatomic(i).channels = [43:45];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IFS';
EmpathyForPain_P9_Anatomic(i).channels = [46:49];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IFG';
EmpathyForPain_P9_Anatomic(i).channels = [50:54];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'FO';
EmpathyForPain_P9_Anatomic(i).channels = [55:58];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IPG';
EmpathyForPain_P9_Anatomic(i).channels = [59:62];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'STS';
EmpathyForPain_P9_Anatomic(i).channels = [63:67];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PCC';
EmpathyForPain_P9_Anatomic(i).channels = [68:71];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PG';
EmpathyForPain_P9_Anatomic(i).channels = [72:82];

display(['Total Nr of ROIS: ' num2str(i)])

save ERPS\EmpathyForPain_P9_Anatomic_Faces_Corrected.mat EmpathyForPain_P9_Anatomic

display('DONE')





