close all
clear all
clc

% 
% fname='Farinelli_DBT1_P1_PreProc_Filt'
% file=[fname '.set']
% path_set='E:\iEEG\9_Farinelli Alfredo\DBT\'
% 
% 
% eeglab
% EEG = pop_loadset('filename', file ,'filepath', [path_set 'Filt\']);
% EEG = eeg_checkset( EEG );
% eeglab redraw

fname='Repossini_DBT_PII_Filt'
file=[fname '.set']
path_set='E:\iEEG\10_Repossini_Florencia\DBT\Filt\'



eeglab
EEG = pop_loadset('filename', file ,'filepath', [path_set]);
EEG = eeg_checkset( EEG );
eeglab redraw




%%

data=EEG.data;
srate=EEG.srate;


%% Calculate bad channels . noisy ones 

a=var(data');
b=find(a>(5*median(a)));
c=find(a<(median(a)/5));

sub_info.bad_chans1=[];

if ~isempty([b c])
    disp(['additional bad channels: ' int2str(setdiff([b c],[sub_info.bad_chans1]))]); 
end 
disp('add additional bad channel when prompted')



%%

nr_jumps=zeros(1,size(data,1));
for k=1:size(data,1);
    nr_jumps(k)=length(find(diff(data(k,:))>100)); % find jumps>80uV
end
figure,plot(nr_jumps);
find(nr_jumps>0);


%%
set_w=srate;%window
set_ov=0;%overlap
set_nfft=srate;%nfft

% [Pxx,f] = pwelch(data(:,1:100*srate),set_w,set_ov,set_nfft,srate);


for k=1:size(data,1)
    
    [Pxx,f] = pwelch(data(k,1:200*srate),set_w,set_ov,set_nfft,srate);
    data_pxx(:,k)=Pxx;
    
end

figure,hold on
plot(f,log(data_pxx),'k')

size(data_pxx)
    
    


%     figure,hold on
%     plot(f,abs(log(squeeze(out(1,:,:)-out(2,:,:)))))
%     fontt=legend(nombre{:})

    