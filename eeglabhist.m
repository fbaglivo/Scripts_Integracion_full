% EEGLAB history file generated on the 17-Mar-2015
% ------------------------------------------------

EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
% multiple datasets command: EEG = pop_loadset('filename',{'Paciente9_Integracion_FaceBinding_Filt_Reref.set' 'Paciente9_Integracion_FaceFeatures_Filt_Reref.set' 'Paciente9_Integracion_ObjectBinding_Filt_Reref.set' 'Paciente9_Integracion_ObjectFeatures___Filt_Reref.set' 'Paciente9_Integracion_SpatialBinding_Filt_Reref.set'},'filepath','D:\\_INECO\\Pacientes\\Paciente9_AlfredoFarinelli\\ConMarcas\\INTEGRACION\\Reref\\');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_mergeset( ALLEEG, [1  2  3  4  5], 0);
EEG.setname='Paciente9_Integracion_Full';
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_eegfilt( EEG, 0, 30, [], [0], 0, 0, 'fir1', 0);
EEG = eeg_checkset( EEG );
