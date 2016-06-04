function main_sub(stim_type, cond_type, basename, basename_out)


load(['Gen_PowerMats/Mats/' basename stim_type '_' cond_type '.mat']);
temp=load(['Gen_PowerMats/Mats/' basename stim_type '_' cond_type '.mat']);


tipo=stim_type;
               
            
switch tipo
    
    case 'Retention'
        
        baseTime=[-200];
        init=1;
        fin=200;
        %                     init=180;
        %                     fin=200;
        %
    case 'PostRetention'
        
        baseTime=[-200];
        init=1;
        fin=200;
     
    
    case 'Retention_Objects'
        
        baseTime=[-200];
        init=1;
        fin=200;
        %                     init=180;
        %                     fin=200;
        %
    case 'PostRetention_Objects'
        
        baseTime=[-200];
        init=1;
        fin=200;
            
    case 'Decision'
        
        baseTime=[-400];
        init=1;
%         fin=400;
        
    
    case 'Decision_Objects'
        
        baseTime=[-400];
        init=1;
%         fin=400;
            
        
end

freqss=temp.freqs;

tam=size(erpsMapsByTrialByROIs(1).erpsByTrial,2)

for t=1:tam
    
    condMat1=squeeze(erpsMapsByTrialByROIs(1).erpsByTrial(t).erpsByTrial(:,init:end,:));
    conditionName1='Binding';
    condMat2=squeeze(erpsMapsByTrialByROIs(2).erpsByTrial(t).erpsByTrial(:,init:end,:));;
    conditionName2='Features';
    
    
    
    statmethod='perm';
    p_value=0.001;
    
    
    color1=[0 0 1];
    color2=[1 0 0];
    colorPvalue=[0.1 0.1 0.1];
    
    
    freqRange(1).range=[1 40];
    freqRange(1).name='1 to 40Hz';
%     
%     freqRange(2).range=[10 20];
%     freqRange(2).name='10 to 20Hz';
%     
%     freqRange(3).range=[55 150];
%     freqRange(3).name='55 to 150Hz';
%     
    
%     freqRange(4).range=[75 95];
%     freqRange(4).name='75 to 95Hz';
%     
%     
%     freqRange(5).range=[105 150];
%     freqRange(5).name='105 to 150Hz';
    
    
    for h=1:size(freqRange,2)
        
        freqRange(h).name
        prefixFileName=[basename_out '_' stim_type '_' cond_type '_' freqRange(h).name '_' num2str(t)];
        titleName=[basename_out '_' stim_type '-' cond_type '-' freqRange(h).name '-' num2str(t)];
        
        PlotCollapsedERPSFreqRangeAndBase(condMat1,condMat2,conditionName1,conditionName2,freqss,freqRange(h).range,timesout,baseTime,statmethod,p_value,prefixFileName,titleName,color1,color2,colorPvalue)
        
    end
    
    
    
end