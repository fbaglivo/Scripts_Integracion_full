%-------OBJECTS--------------------------------------------------------
i = 0;

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'TPM';
EmpathyForPain_P9_Anatomic(i).channels = [1:4];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'TPL';
EmpathyForPain_P9_Anatomic(i).channels = [5:9];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'A';
EmpathyForPain_P9_Anatomic(i).channels = [10:15];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'STG';
EmpathyForPain_P9_Anatomic(i).channels = [16:18];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'FG';
EmpathyForPain_P9_Anatomic(i).channels = [19:22];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PITG';
EmpathyForPain_P9_Anatomic(i).channels = [26:27];

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
EmpathyForPain_P9_Anatomic(i).channels = [46:48];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IFG';
EmpathyForPain_P9_Anatomic(i).channels = [49:52];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'FO';
EmpathyForPain_P9_Anatomic(i).channels = [55:58];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IPG';
EmpathyForPain_P9_Anatomic(i).channels = [59:61];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'STS';
EmpathyForPain_P9_Anatomic(i).channels = [62:66];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PCC';
EmpathyForPain_P9_Anatomic(i).channels = [67:70];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PG';
EmpathyForPain_P9_Anatomic(i).channels = [71:81];

display(['Total Nr of ROIS: ' num2str(i)])

save EmpathyForPain_P9_Anatomic_Objects_Corrected.mat EmpathyForPain_P9_Anatomic

display('DONE')





