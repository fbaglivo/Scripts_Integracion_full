


data=squeeze(condp(k).data(canal,:,:));


base_line=ceil(0.2*EEG.srate);




for u=1:size(data,2)

    media_baseline=mean(data(1:base_line,u),1);
    std_baseline=std(data(1:base_line,u));
    data(:,u)=(data(:,u)-media_baseline)/std_baseline;

end


for i=1:size(data,2)

    [S(i,:,:),F(i,:,:),T(i,:,:),P(i,:,:)] = spectrogram(double(data(:,i))',hamming(200),128,256,512);

end


Fm=squeeze(mean(F,1));
Tm=squeeze(mean(T,1));
Pm=squeeze(mean(P,1));

figure


surf(Tm,Fm,10*log10(Pm),'edgecolor','none'); axis tight; 
view(0,90);
ylim([0 150])
xlabel('Time (Seconds)'); ylabel('Hz');
% title(['Binding' chan.chan(canal)])
% caxis([-500 100])
