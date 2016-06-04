%-------FEATURES--------------------------------------------------------
i = 0;

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'TPM';
EmpathyForPain_P9_Anatomic(i).channels = [1:2];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'TPL';
EmpathyForPain_P9_Anatomic(i).channels = [3:6];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'A';
EmpathyForPain_P9_Anatomic(i).channels = [7:11];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'STG';
EmpathyForPain_P9_Anatomic(i).channels = [12:13];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'FG';
EmpathyForPain_P9_Anatomic(i).channels = [14:18];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PITG';
EmpathyForPain_P9_Anatomic(i).channels = [20:22];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'POG';
EmpathyForPain_P9_Anatomic(i).channels = [23:30];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'LOG';
EmpathyForPain_P9_Anatomic(i).channels = [31:37];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'ACC';
EmpathyForPain_P9_Anatomic(i).channels = [38:40];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IFS';
EmpathyForPain_P9_Anatomic(i).channels = [41:44];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IFG';
EmpathyForPain_P9_Anatomic(i).channels = [45:47];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'FO';
EmpathyForPain_P9_Anatomic(i).channels = [50:52];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'IPG';
EmpathyForPain_P9_Anatomic(i).channels = [54:57];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'STS';
EmpathyForPain_P9_Anatomic(i).channels = [58:62];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PCC';
EmpathyForPain_P9_Anatomic(i).channels = [64:67];

i = i+1;
EmpathyForPain_P9_Anatomic(i).name = 'PG';
EmpathyForPain_P9_Anatomic(i).channels = [73 77];

display(['Total Nr of ROIS: ' num2str(i)])

save EmpathyForPain_P9_Anatomic_Features_Corrected.mat EmpathyForPain_P9_Anatomic

display('DONE')





