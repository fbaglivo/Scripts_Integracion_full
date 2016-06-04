function main_sub(stim_type, cond_type, basename, basename_out)


switch cond_type
    
    case 'Features'
   
        feat_outs=load([basename_out stim_type '_' cond_type '_Spatial.mat']);
        bind_outs=load([basename_out stim_type '_' cond_type '_NonSpatial.mat']);
        
        feat=load([basename stim_type '_' cond_type '_Spatial.mat']);
        bind=load([basename stim_type '_' cond_type '_NonSpatial.mat']);
        
        load(['EmpathyForPain_P9_Anatomic_' cond_type '_Corrected.mat'])
   
        
    otherwise
    
        feat_outs=load([basename_out stim_type '_' cond_type '_Features.mat']);
        bind_outs=load([basename_out stim_type '_' cond_type '_Binding.mat']);
        
        feat=load([basename stim_type '_' cond_type '_Features.mat']);
        bind=load([basename stim_type '_' cond_type '_Binding.mat']);
        
        load(['EmpathyForPain_P9_Anatomic_' cond_type '_Corrected.mat'])
    
end
        
        tipo=stim_type;
               
            
            switch tipo
                
                case 'Retention'
                    
                    baseTime=[0];
                    init=1;
                    fin=200;
%                     init=180;
%                     fin=200;
%                     
                case 'PostRetention'
                    
                    baseTime=[-200];
                    init=1;
                    fin=200;
                    
                case 'Decision'
                    
                    baseTime=[-200];
                    init=1;
                    fin=200;
                    
            end
            
        
        
        for t=1:max(size(bind.erpsMapsByTrialByROIs))
            
            condMat1=bind.erpsMapsByTrialByROIs(t).erpsByTrial(:,init:fin,:);
            conditionName1='Binding';
            condMat2=feat.erpsMapsByTrialByROIs(t).erpsByTrial(:,init:fin,:);
            conditionName2='Features';
            
            timesout=feat_outs.timesout(init:fin);
            
            
            freqs=feat_outs.freqs;
            statmethod='perm';
            p_value=0.001;
            
            
            color1=[0 0 1];
            color2=[1 0 0];
            colorPvalue=[0.1 0.1 0.1];
            
            
            freqRange(1).range=[1 20];
            freqRange(1).name='1 to 20Hz';
            
            freqRange(2).range=[20 40];
            freqRange(2).name='20 to 40Hz';
            
            freqRange(3).range=[55 150];
            freqRange(3).name='55 to 150Hz';
            
%             
%             freqRange(4).range=[75 95];
%             freqRange(4).name='75 to 95Hz';
%             
%             
%             freqRange(5).range=[105 150];
%             freqRange(5).name='105 to 150Hz';
            
            
            for h=1:size(freqRange,2)
                
                freqRange(h).name
                prefixFileName=[stim_type '_' cond_type '_' freqRange(h).name '_' EmpathyForPain_P9_Anatomic(t).name];
                titleName=[stim_type '-' cond_type '-' freqRange(h).name '-' EmpathyForPain_P9_Anatomic(t).name];
                
                PlotCollapsedERPSFreqRangeAndBase(condMat1,condMat2,conditionName1,conditionName2,freqs,freqRange(h).range,timesout,baseTime,statmethod,p_value,prefixFileName,titleName,color1,color2,colorPvalue)
                
            end
            
            
            
        end