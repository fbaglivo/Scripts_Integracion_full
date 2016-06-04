close all
clear all
clc

file='Paciente9_TMaze_epochs.mat'

load(file)
%%

canales_selecc=[10:10];

for t=1:size(canales_selecc,2)
   
    nombre{t}=epochs(1).struct.chanlocs(canales_selecc(t)).labels
    
end

%%

for i=[1 2 9]
   
    data3d = epochs(i).data;
    data=[]
    
    for j=1:size(data3d,3)
    
        data=cat(2,data,squeeze(data3d(:,:,j)));
        
    end
    
    data=data';
    
    %% check powerspectra of all channels

    srate=epochs(i).struct.srate;
    set_w=srate;%window
    set_ov=0;%overlap
    set_nfft=srate;%nfft

    [Pxx,f] = pwelch(data(1:8*srate,1),set_w,set_ov,set_nfft,srate);
    data_pxx=zeros(length(f),size(data,2));

    for k=canales_selecc

        [Pxx,f] = pwelch(data(1:8*srate,k),set_w,set_ov,set_nfft,srate);
        data_pxx(:,k)=Pxx;

    end

    figure,hold on
    plot(f,log(data_pxx),'k')
    title(epochs(i).name)

    size(data_pxx)
    out(i,:,:)=data_pxx;
    
    clear Pxx, f
    
end

%%

    
        out=out+1;


%%
    figure,hold on
    plot(f,abs(log(squeeze(out(1,:,:)-out(2,:,:)))))
    fontt=legend(nombre{:})

    figure,hold on
    plot(f,abs(log(squeeze(out(2,:,:)-out(8,:,:)))))
    fontt=legend(nombre{:})
    