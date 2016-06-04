clear all
clc
close all

restoredefaultpath
addpath('C:\eeglab11_0_4_3b\')

%%

filen(1).name=['Paciente12_Integracion_Full']; % Ojo Paciente 6 tiene mal las marcas


%%

for k=1
    
    fname=[filen(k).name '_Filt'];
    file=[fname '.set']
    path_set='D:\_INECO\Pacientes\Paciente12_LB\ConMarcas\Integracion\';



    eeglab
    EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']);
    EEG = eeg_checkset( EEG );
    eeglab redraw

%% Paciente 8
% % 
% 1  -  EEG OI1
% 2  -  EEG OI2
% 3  -  EEG OI3
% 4  -  EEG OI4
% 5  -  EEG OI5
% 6  -  EEG OI6
% 7  -  EEG OI7
% 8  -  EEG OI8
% 9  -  EEG OI9
% 10  -  EEG OI10

electrode(1).chans=1:10;
electrode(1).name='OI';
% 
% 11  -  EEG OS1
% 12  -  EEG OS2
% 13  -  EEG OS3
% 14  -  EEG OS4
% 15  -  EEG OS5
% 16  -  EEG OS6
% 17  -  EEG OS7
% 18  -  EEG OS8
% 19  -  EEG OS9
% 20  -  EEG OS10

electrode(2).chans=11:20;
electrode(2).name='OSI';

% 21  -  EEG PC1
% 22  -  EEG PC2
% 23  -  EEG PC3
% 24  -  EEG PC4
% 25  -  EEG PC5
% 26  -  EEG PC6
% 27  -  EEG PC7
% 28  -  EEG PC8
% 29  -  EEG PC9
% 30  -  EEG PC10

electrode(3).chans=21:30;
electrode(3).name='PCI'
% 
% 31  -  EEG P1
% 32  -  EEG P2
% 33  -  EEG P 3
% 34  -  EEG P 4
% 35  -  EEG P5
% 36  -  EEG P6
% 37  -  EEG P7
% 38  -  EEG P8
% 39  -  EEG P9
% 40  -  EEG P10


electrode(4).chans=31:40;
electrode(4).name='PI'


% 41  -  EEG GCP1
% 42  -  EEG GCP2
% 43  -  EEG GCP3
% 44  -  EEG GCP4
% 45  -  EEG GCP5
% 46  -  EEG GCP6
% 47  -  EEG GCP7
% 48  -  EEG GCP8
% 49  -  EEG GCP9
% 50  -  EEG GCP10
% 51  -  EEG GCP11
% 52  -  EEG GCP12

electrode(5).chans=41:52;
electrode(5).name='GCP'

% 53  -  EEG TBP1
% 54  -  EEG TBP2
% 55  -  EEG TBP3
% 56  -  EEG TBP4
% 57  -  EEG TBP5
% 58  -  EEG TBP6
% 59  -  EEG TBP7
% 60  -  EEG TBP8
% 61  -  EEG TBP9
% 62  -  EEG TBP10

electrode(6).chans=53:62;
electrode(6).name='TBP'

% 63  -  EEG H1
% 64  -  EEG H2
% 65  -  EEG H3
% 66  -  EEG H4
% 67  -  EEG H5

electrode(7).chans=63:67;
electrode(7).name='HI'
% 
% 68  -  EEG elB35
% 69  -  EEG elB36
% 70  -  EEG elB37
% 71  -  EEG elB38
% 72  -  EEG elB39
% 73  -  EEG elB40
% 74  -  EEG elB41
% 75  -  EEG elB42
% 76  -  EEG elB43
% 77  -  EEG elB44
% 78  -  EEG elB45
% 79  -  EEG elB46
% 80  -  EEG elB47
% 81  -  EEG elB48
% 82  -  EEG elB49
% 83  -  EEG elB50
% 84  -  EEG elB51
% 85  -  EEG elB52
% 86  -  EEG elB53
% 87  -  EEG elB54
% 88  -  EEG elB55
% 89  -  EEG elB56
% 90  -  EEG elB57
% 91  -  EEG elB58
% 92  -  EEG elB59
% 93  -  EEG elB60
% 94  -  EEG elB61
% 95  -  EEG elB62
% 96  -  EEG elB63
% 97  -  EEG elB64

electrode(8).chans=68:97;
electrode(8).name='B'


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