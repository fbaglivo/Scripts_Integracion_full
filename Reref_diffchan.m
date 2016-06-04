clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')
%%

% filen(1).name=['Paciente9_Integracion_NonSpatialBinding'];
% % filen(1).marks={'1Acc0','2Acc0','3Acc0','5Acc0','1Acc1','2Acc1','3Acc1','5Acc1'};
% % 
% filen(2).name=['Paciente9_Integracion_SpatialBinding'];
% filen(2).marks={'8Acc0','9Acc0','10Acc0','11Acc0','8Acc1','9Acc1','10Acc1','11Acc1'};



%  filen(1).name=['Paciente6_ObjectBinding_new_filt'];
% filen(1).marks={'1Acc0','2Acc0','3Acc0','5Acc0','1Acc1','2Acc1','3Acc1','5Acc1'};
% 
%  filen(1).name=['Paciente6_ObjectFeature_new'];
% filen(2).marks={'8Acc0','9Acc0','10Acc0','11Acc0','8Acc1','9Acc1','10Acc1','11Acc1'};
% 
% filen(1).name=['Paciente6_Spatial_new'];
% % filen(3).marks={'15Acc0','16Acc0','17Acc0','19Acc0','15Acc1','16Acc1','17Acc1','19Acc1'};
% % 
% filen(2).name=['Paciente6_NonSpatial_new']; %Faltan los 23
% % filen(4).marks={'22Acc0','','24Acc0','26Acc0','22Acc1','','24Acc1','26Acc1'};
% %  
% filen(3).name=['Paciente6_FacesBinding_new']; % Ojo Paciente 6 tiene mal las marcas
% %  filen(1).marks={'29Acc0','30Acc0','42Acc0','32Acc0','29Acc1','30Acc1','42Acc1','32Acc1'};
% % 
% filen(4).name=['Paciente6_FacesFeatures_new'];
% % filen(2).marks={'35Acc0','36Acc0','41Acc0','38Acc0','35Acc1','36Acc1','41Acc1','35Acc1'};



filen(1).name=['Paciente8_Objects_Bind']; % Ojo Paciente 6 tiene mal las marcas
filen(1).marks={'29Acc0','30Acc0','42Acc0','32Acc0','29Acc1','30Acc1','42Acc1','32Acc1'};



%%

for k=1
    
    fname=[filen(k).name '_Filt'];
    file=[fname '.set']
%      path_set='D:\_INECO\Pacientes\Paciente9_AlfredoFarinelli\ConMarcas\INTEGRACION\'
%     path_set='D:\_INECO\Pacientes\Paciente6_LizandroAusello\Remark\Integracion\'
    path_set='D:\_INECO\Pacientes\Paciente8_FlorenciaIgnacio\ConMarcas\Integracion\Objects\';



    eeglab
    EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']);
    EEG = eeg_checkset( EEG );
    eeglab redraw

%     %%%%%Paciente 6 Channels
% %
% 
%     electrode(1).chans=1:12;
%     electrode(1).name='OF';
% 
% 
% % 1  -  EEG OF1
% % 2  -  EEG OF2
% % 3  -  EEG OF3
% % 4  -  EEG OF4
% % 5  -  EEG OF5
% % 6  -  EEG OF6
% % 7  -  EEG OF7
% % 8  -  EEG OF8
% % 9  -  EEG OF9
% % 10  -  EEG OF10
% % 11  -  EEG OF11
% % 12  -  EEG OF12
% 
% 
%     electrode(2).chans=13:22;
%     electrode(3).name='HA';
% 
% % 13  -  EEG HA1
% % 14  -  EEG HA2
% % 15  -  EEG HA3
% % 16  -  EEG HA4
% % 17  -  EEG HA5
% % 18  -  EEG HA6
% % 19  -  EEG HA7
% % 20  -  EEG HA8
% % 21  -  EEG HA9
% % 22  -  EEG HA10
% 
% 
%     electrode(3).chans=23:32;
%     electrode(3).name='HP';
% 
% % 23  -  EEG HP1
% % 24  -  EEG HP2
% % 25  -  EEG HP3
% % 26  -  EEG HP4
% % 27  -  EEG HP5
% % 28  -  EEG HP6
% % 29  -  EEG HP7
% % 30  -  EEG HP8
% % 31  -  EEG HP9
% % 32  -  EEG HP10
% 
% 
%     electrode(4).chans=33:44;
%     electrode(4).name='GCA';
% 
% % 33  -  EEG GCA1
% % 34  -  EEG GCA2
% % 35  -  EEG GCA3
% % 36  -  EEG GCA4
% % 37  -  EEG GCA5
% % 38  -  EEG GCA6
% % 39  -  EEG GCA7
% % 40  -  EEG GCA8
% % 41  -  EEG GCA9
% % 42  -  EEG GCA10
% % 43  -  EEG GCA11
% % 44  -  EEG GCA12
% 
% 
%     electrode(5).chans=45:56;
%     electrode(5).name='F';
% 
% % 45  -  EEG F1
% % 46  -  EEG F2
% % 47  -  EEG F 3
% % 48  -  EEG F 4
% % 49  -  EEG F5
% % 50  -  EEG F6
% % 51  -  EEG F 7
% % 52  -  EEG F 8
% % 53  -  EEG F9
% % 54  -  EEG F10
% % 55  -  EEG F11
% % 56  -  EEG F12
% 
% 
%     electrode(6).chans=57:68;
%     electrode(6).name='M';
%     
%     
% % 57  -  EEG M1
% % 58  -  EEG M2
% % 59  -  EEG M3
% % 60  -  EEG M4
% % 61  -  EEG M5
% % 62  -  EEG M6
% % 63  -  EEG M7
% % 64  -  EEG M8
% % 65  -  EEG M9
% % 66  -  EEG M10
% % 67  -  EEG M11
% % 68  -  EEG M12
% 
% 
%     electrode(7).chans=69:78;
%     electrode(7).name='PT';
%     
%     
% % 69  -  EEG PT1
% % 70  -  EEG PT2
% % 71  -  EEG PT3
% % 72  -  EEG PT4
% % 73  -  EEG PT5
% % 74  -  EEG PT6
% % 75  -  EEG PT7
% % 76  -  EEG PT8
% % 77  -  EEG PT9
% % 78  -  EEG PT10
% 
% 
%     electrode(8).chans=79:88;
%     electrode(8).name='FS';
% 
% % 79  -  EEG FS1
% % 80  -  EEG FS2
% % 81  -  EEG FS3
% % 82  -  EEG FS4
% % 83  -  EEG FS5
% % 84  -  EEG FS6
% % 85  -  EEG FS7
% % 86  -  EEG FS8
% % 87  -  EEG FS9
% % 88  -  EEG FS10
% 
% 
%     electrode(9).chans=89:93;
%     electrode(9).name='T';
% 
% % 89  -  EEG T1
% % 90  -  EEG T2
% % 91  -  EEG T 3
% % 92  -  EEG T 4
% % 93  -  EEG T 5
% % 
% % % %Object Binding off
%     electrode(10).chans=94:98;
%     electrode(10).name='OP';
% 
% % 94  -  EEG OP1
% % 95  -  EEG OP2
% % 96  -  EEG OP3
% % 97  -  EEG OP4
% % 98  -  EEG OP5
%     
%% Paciente 8
% 
% 1  -  EEG OF'1
% 2  -  EEG OF'2
% 3  -  EEG OF'3
% 4  -  EEG OF'4
% 5  -  EEG OF'5

electrode(1).chans=1:5;
electrode(1).name='OFi';

% 
% 6  -  EEG OF'11
% 7  -  EEG OF'12
% 8  -  EEG OF'13
% 9  -  EEG OF'14
% 10  -  EEG OF'15


electrode(2).chans=6:10;
electrode(2).name='OFI'

% 11  -  EEG G'1
% 12  -  EEG G'2
% 13  -  EEG G'3
% 14  -  EEG G'4
% 15  -  EEG G'5

electrode(3).chans=11:15;
electrode(3).name='Gi'
% 
% 16  -  EEG G'11
% 17  -  EEG G'12
% 18  -  EEG G'13
% 19  -  EEG G'14
% 20  -  EEG G'15

electrode(4).chans=16:20;
electrode(4).name='GI'


% 21  -  EEG GC'1
% 22  -  EEG GC'2
% 23  -  EEG GC'3
% 24  -  EEG GC'4
% 25  -  EEG GC'5

electrode(5).chans=21:125;
electrode(5).name='GCi'

% 
% 26  -  EEG GC'11
% 27  -  EEG GC'12
% 28  -  EEG GC'13
% 29  -  EEG GC'14
% 30  -  EEG GC'15

electrode(6).chans=26:30;
electrode(6).name='GCI'

% 
% 31  -  EEG F'1
% 32  -  EEG F'2
% 33  -  EEG F'3
% 34  -  EEG F'4
% 35  -  EEG F'5

electrode(7).chans=31:35;
electrode(7).name='Fi'
% 
% 36  -  EEG F'11
% 37  -  EEG F'12
% 38  -  EEG F'13
% 39  -  EEG F'14
% 40  -  EEG F'15

electrode(8).chans=36:40;
electrode(8).name='FI'
% 
% 41  -  EEG PM'1
% 42  -  EEG PM'2
% 43  -  EEG PM'3
% 44  -  EEG PM'4
% 45  -  EEG PM'5

electrode(9).chans=41:45;
electrode(9).name='PMi'
% 
% 46  -  EEG PM'11
% 47  -  EEG PM'12
% 48  -  EEG PM'13
% 49  -  EEG PM'14
% 50  -  EEG PM'15

electrode(10).chans=46:50;
electrode(10).name='PMI'

% 
% 51  -  EEG M'1
% 52  -  EEG M'2
% 53  -  EEG M'3
% 54  -  EEG M'4
% 55  -  EEG M'5

electrode(11).chans=51:55;
electrode(11).name='Mi'
% 
% 56  -  EEG M'11
% 57  -  EEG M'12
% 58  -  EEG M'13
% 59  -  EEG M'14
% 60  -  EEG M'15

electrode(12).chans=56:60;
electrode(12).name='MI'
% 
% 61  -  EEG OP'1
% 62  -  EEG OP'2
% 63  -  EEG OP'3
% 64  -  EEG OP'4
% 65  -  EEG OP'5

electrode(13).chans=61:64;
electrode(13).name='OPi'
% 
% 66  -  EEG R'1
% 67  -  EEG R'2
% 68  -  EEG R'3
% 69  -  EEG R'4
% 70  -  EEG R'5

electrode(14).chans=66:70;
electrode(14).name='Ri'
% 
% 71  -  EEG A'1
% 72  -  EEG A'2
% 73  -  EEG A'3
% 74  -  EEG A'4

electrode(15).chans=71:74;
electrode(15).name='Ai'
% 
% 75  -  EEG A'7
% 76  -  EEG A'8
% 77  -  EEG A'9
% 78  -  EEG A'10

electrode(16).chans=75:78;
electrode(16).name='AI'

% 79  -  EEG HP'1
% 80  -  EEG HP'2
% 81  -  EEG HP'3
% 82  -  EEG HP'4

electrode(17).chans=79:82;
electrode(17).name='HPi'

% 
% 83  -  EEG HP'7
% 84  -  EEG HP'8
% 85  -  EEG HP'9
% 86  -  EEG HP'10

electrode(18).chans=83:86;
electrode(18).name='HPI'
% 
% 87  -  EEG T'1
% 88  -  EEG T'2
% 89  -  EEG T'3
% 90  -  EEG T'4
% 91  -  EEG T'5

electrode(19).chans=87:91;
electrode(19).name='Ti'

% 
% 92  -  EEG PS'1
% 93  -  EEG PS'2
% 94  -  EEG PS'3
% 95  -  EEG PS'4
% 96  -  EEG PS'5

electrode(20).chans=92:96;
electrode(20).name='PSi'

% 97  -  EEG PS'11
% 98  -  EEG PS'12
% 99  -  EEG PS'13
% 100  -  EEG PS'14
% 101  -  EEG PS'15

electrode(21).chans=97:101;
electrode(21).name='PSI'

% 
% 102  -  EEG GP'1
% 103  -  EEG GP'2
% 104  -  EEG GP'3
% 105  -  EEG GP'4
% 106  -  EEG GP'5

electrode(22).chans=102:106;
electrode(22).name='GPi'

% 
% 107  -  EEG GP'11
% 108  -  EEG GP'12
% 109  -  EEG GP'13
% 110  -  EEG GP'14
% 111  -  EEG GP'15

electrode(23).chans=107:111;
electrode(23).name='GPI'

% 
% 112  -  EEG M1
% 113  -  EEG M2
% 114  -  EEG M3
% 115  -  EEG M4

electrode(24).chans=112:115;
electrode(24).name='Md'
% 
% 116  -  EEG M12
% 117  -  EEG M13
% 118  -  EEG M14
% 119  -  EEG M15

electrode(25).chans=116:119;
electrode(25).name='MD'
% 
% 120  -  EEG F1
% 121  -  EEG F2
% 122  -  EEG F3
% 123  -  EEG F4
% 124  -  EEG F5

electrode(26).chans=120:124;
electrode(26).name='Fd'
% 
% 125  -  EEG F12
% 126  -  EEG F13
% 127  -  EEG F14
% 128  -  EEG F15

electrode(27).chans=125:128;
electrode(27).name='FD'

    %% Paciente 9 Channels
% 
%     electrode(1).chans=1:10;
%     electrode(1).name='PT';
% 
%     % 
%     % 1  -  EEG PT1
%     % 2  -  EEG PT2
%     % 3  -  EEG PT3
%     % 4  -  EEG PT4
%     % 5  -  EEG PT5
%     % 6  -  EEG PT6
%     % 7  -  EEG PT7
%     % 8  -  EEG PT8
%     % 9  -  EEG PT9
%     % 10  -  EEG PT10
% 
%     electrode(2).chans=11:20;
%     electrode(2).name='A';
% 
% 
%     % 11  -  EEG A 1
%     % 12  -  EEG A 2
%     % 13  -  EEG A3
%     % 14  -  EEG A4
%     % 15  -  EEG A5
%     % 16  -  EEG A6
%     % 17  -  EEG A7
%     % 18  -  EEG A8
%     % 19  -  EEG A9
%     % 20  -  EEG A10
% 
%     electrode(3).chans=21:30;
%     electrode(3).name='FS';
% 
% 
%     % 21  -  EEG FS1
%     % 22  -  EEG FS2
%     % 23  -  EEG FS3
%     % 24  -  EEG FS4
%     % 25  -  EEG FS5
%     % 26  -  EEG FS6
%     % 27  -  EEG FS7
%     % 28  -  EEG FS8
%     % 29  -  EEG FS9
%     % 30  -  EEG FS10
% 
%     electrode(4).chans=31:45;
%     electrode(4).name='OF';
% 
%     % 
%     % 31  -  EEG OF1
%     % 32  -  EEG OF2
%     % 33  -  EEG OF3
%     % 34  -  EEG OF4
%     % 35  -  EEG OF5
%     % 36  -  EEG OF6
%     % 37  -  EEG OF7
%     % 38  -  EEG OF8
%     % 39  -  EEG OF9
%     % 40  -  EEG OF10
%     % 41  -  EEG OF11
%     % 42  -  EEG OF12
%     % 43  -  EEG OF13
%     % 44  -  EEG OF14
%     % 45  -  EEG OF15
% 
%     electrode(5).chans=46:60;
%     electrode(5).name='GCA';
% 
%     % 46  -  EEG GCA1
%     % 47  -  EEG GCA2
%     % 48  -  EEG GCA3
%     % 49  -  EEG GCA4
%     % 50  -  EEG GCA5
%     % 51  -  EEG GCA6
%     % 52  -  EEG GCA7
%     % 53  -  EEG GCA8
%     % 54  -  EEG GCA9
%     % 55  -  EEG GCA10
%     % 56  -  EEG GCA11
%     % 57  -  EEG GCA12
%     % 58  -  EEG GCA13
%     % 59  -  EEG GCA14
%     % 60  -  EEG GCA15
% 
%     electrode(6).chans=61:65;
%     electrode(6).name='R';
% 
%     % 
%     % 61  -  EEG R1
%     % 62  -  EEG R2
%     % 63  -  EEG R3
%     % 64  -  EEG R4  /Mark
%     % 65  -  EEG R5  /Mark
% 
%     electrode(7).chans=66:70;
%     electrode(7).name='OP';
% 
% 
%     % 66  -  EEG OP1
%     % 67  -  EEG OP2
%     % 68  -  EEG OP3
%     % 69  -  EEG OP4
%     % 70  -  EEG OP5
% 
%     electrode(8).chans=71:75;
%     electrode(8).name='T';
% 
%     % 
%     % 71  -  EEG T1
%     % 72  -  EEG T2
%     % 73  -  EEG T 3
%     % 74  -  EEG T 4
%     % 75  -  EEG T 5
% 
%     electrode(9).chans=76:90;
%     electrode(9).name='GCP';
% 
%     % 
%     % 76  -  EEG GCP1
%     % 77  -  EEG GCP2
%     % 78  -  EEG GCP3
%     % 79  -  EEG GCP4
%     % 80  -  EEG GCP5
%     % 81  -  EEG GCP6
%     % 82  -  EEG GCP7
%     % 83  -  EEG GCP8
%     % 84  -  EEG GCP9
%     % 85  -  EEG GCP10
%     % 86  -  EEG GCP11
%     % 87  -  EEG GCP12
%     % 88  -  EEG GCP13
%     % 89  -  EEG GCP14
%     % 90  -  EEG GCP15

%%%%%%%%%%%%%%%%%%%%5
    % %% Paciente 10 Channels
    %  
    % electrode(1).chans=1:10;
    % electrode(1).name='M';
    % 
    % % 1  -  EEG M'1
    % % 2  -  EEG M'2
    % % 3  -  EEG M'3
    % % 4  -  EEG M'4
    % % 5  -  EEG M'5
    % % 6  -  EEG M'6
    % % 7  -  EEG M'7
    % % 8  -  EEG M'8
    % % 9  -  EEG M'9
    % % 10  -  EEG M'10
    % 
    % 
    % electrode(2).chans=11:25;
    % electrode(2).name='GC';
    % 
    % 
    % % 11  -  EEG GC'1
    % % 12  -  EEG GC'2
    % % 13  -  EEG GC'3
    % % 14  -  EEG GC'4
    % % 15  -  EEG GC'5
    % % 16  -  EEG GC'6
    % % 17  -  EEG GC'7
    % % 18  -  EEG GC'8
    % % 19  -  EEG GC'9
    % % 20  -  EEG GC'10
    % % 21  -  EEG GC'11
    % % 22  -  EEG GC'12
    % % 23  -  EEG GC'13
    % % 24  -  EEG GC'14
    % % 25  -  EEG GC'15
    % 
    % electrode(3).chans=26:30;
    % electrode(3).name='PI';
    % 
    % 
    % % 26  -  EEG PI'1
    % % 27  -  EEG PI'2
    % % 28  -  EEG PI'3
    % % 29  -  EEG PI'4
    % % 30  -  EEG PI'5
    % 
    % 
    % electrode(4).chans=31:40;
    % electrode(4).name='F';
    % 
    % 
    % % 31  -  EEG F'1
    % % 32  -  EEG F'2
    % % 33  -  EEG F'3
    % % 34  -  EEG F'4
    % % 35  -  EEG F'5
    % % 36  -  EEG F'6
    % % 37  -  EEG F'7
    % % 38  -  EEG F'8
    % % 39  -  EEG F'9
    % % 40  -  EEG F'10
    % 
    % 
    % 
    % electrode(5).chans=41:55;
    % electrode(5).name='OF';
    % 
    % 
    % % 41  -  EEG OF'1
    % % 42  -  EEG OF'2
    % % 43  -  EEG OF'3
    % % 44  -  EEG OF'4
    % % 45  -  EEG OF'5
    % % 46  -  EEG OF'6
    % % 47  -  EEG OF'7
    % % 48  -  EEG OF'8
    % % 49  -  EEG OF'9
    % % 50  -  EEG OF'10
    % % 51  -  EEG OF'11
    % % 52  -  EEG OF'12
    % % 53  -  EEG OF'13
    % % 54  -  EEG OF'14
    % % 55  -  EEG OF'15
    % 
    % 
    % electrode(6).chans=56:65;
    % electrode(6).name='A';
    % 
    % 
    % % 56  -  EEG A'1
    % % 57  -  EEG A'2
    % % 58  -  EEG A'3
    % % 59  -  EEG A'4
    % % 60  -  EEG A'5
    % % 61  -  EEG A'6
    % % 62  -  EEG A'7
    % % 63  -  EEG A'8
    % % 64  -  EEG A'9
    % % 65  -  EEG A'10 
    % 
    % 
    % electrode(7).chans=66:75;
    % electrode(7).name='H';
    % 
    % 
    % % 66  -  EEG H'1
    % % 67  -  EEG H'2
    % % 68  -  EEG H'3
    % % 69  -  EEG H'4
    % % 70  -  EEG H'5
    % % 71  -  EEG H'6
    % % 72  -  EEG H'7
    % % 73  -  EEG H'8
    % % 74  -  EEG H'9
    % % 75  -  EEG H'10
    % 
    % 
    % electrode(8).chans=76:80;
    % electrode(8).name='Tl';
    % 
    % 
    % % 76  -  EEG T1'1
    % % 77  -  EEG T1'2
    % % 78  -  EEG T1'3
    % % 79  -  EEG T1'4
    % % 80  -  EEG T1'5
    % 
    % 
    % electrode(9).chans=81:90;
    % electrode(9).name='PC';
    % 
    % % 81  -  EEG PC'1
    % % 82  -  EEG PC'2
    % % 83  -  EEG PC'3
    % % 84  -  EEG PC'4
    % % 85  -  EEG PC'5
    % % 86  -  EEG PC'6
    % % 87  -  EEG PC'7
    % % 88  -  EEG PC'8
    % % 89  -  EEG PC'9
    % % 90  -  EEG PC'10
    % 
    % 
    % electrode(10).chans=91:95;
    % electrode(10).name='I';
    % 
    % 
    % % 91  -  EEG I'51
    % % 92  -  EEG I'52
    % % 93  -  EEG I'53
    % % 94  -  EEG I'54
    % % 95  -  EEG I'55
    % 
    % 
    % electrode(11).chans=96:105;
    % electrode(11).name='AS';
    % 
    % 
    % % 96  -  EEG AS'1
    % % 97  -  EEG AS'2
    % % 98  -  EEG AS'3
    % % 99  -  EEG AS'4
    % % 100  -  EEG AS'5
    % % 101  -  EEG AS'6
    % % 102  -  EEG AS'7
    % % 103  -  EEG AS'8
    % % 104  -  EEG AS'9
    % % 105  -  EEG AS'10

    %%

    data_1=EEG.data;
    data=[data_1(1,:)' zeros(1,size(data_1,2))' data_1(2:size(data_1,1),:)']';
    
    index=1;

    for i=1:size(electrode,2)

        for j=1:size(electrode(i).chans,2)-1

            data_reref(index,:)=data(electrode(i).chans(j+1),:)-data(electrode(i).chans(j),:);
            data_name(index).labels=[electrode(i).name num2str(j) 'diff'];
            index=index+1;

        end
    end


    elim_chan=size(data,1)-size(data_reref,1);
    for i=1:elim_chan
        EEG=pop_select( EEG,'nochannel',{EEG.chanlocs(i).labels});
    end


    EEG.data=data_reref;
    for i=1:size(data_name,2)
        EEG.chanlocs(i).labels=data_name(i).labels;
    end

    eeglab redraw
    
    
    path_set_out=[path_set 'Reref\'];
    outf=[fname '_Reref'];

    pop_saveset(EEG,'filename', outf,'filepath',path_set_out);
    disp([fname 'reref done!'])
    
    clear data_reref
end