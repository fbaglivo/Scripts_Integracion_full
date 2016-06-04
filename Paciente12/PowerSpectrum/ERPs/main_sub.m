function main_sub(stim_type, cond_type, basename, basename_out)


   
%CANAL

patientROI(1).channels= [2:4 9 10 124];
patientROI(1).name= 'FD';

patientROI(2).channels= [19 22:24 26 27];
patientROI(2).name= 'FI';

patientROI(3).channels= [109:111 115:117];
patientROI(3).name= 'LAD';

patientROI(4).channels= [29 24:26 39 40];
patientROI(4).name= 'LAI';

patientROI(5).channels= [92 93 97 98 101 102];
patientROI(5).name= 'LPD';

patientROI(6).channels= [41 42 45:47 52];
patientROI(6).name= 'LPI';

patientROI(7).channels= [6 7 31 55 80 106];
patientROI(7).name= 'C';

patientROI(8).channels= [74:76 82:84];
patientROI(8).name= 'OD';

patientROI(9).channels= [64:66 69:71];
patientROI(9).name= 'OI';

        
    
feat_outs=load([basename_out stim_type '_' cond_type.c1 '.mat']);
bind_outs=load([basename_out stim_type '_' cond_type.c2 '.mat']);

feat=load([basename stim_type '_' cond_type.c1 '.mat']);
bind=load([basename stim_type '_' cond_type.c2 '.mat']);

%         load(['EmpathyForPain_P9_Anatomic_' cond_type '_Corrected.mat'])


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
            
            
            freqRange(1).range=[1 10];
            freqRange(1).name='1 to 10Hz';
            
            freqRange(2).range=[10 20];
            freqRange(2).name='10 to 20Hz';
            
            freqRange(3).range=[20 40];
            freqRange(3).name='20 to 40Hz';
            
%             freqRange(3).range=[55 150];
%             freqRange(3).name='55 to 150Hz';
%             
%             
%             freqRange(4).range=[75 95];
%             freqRange(4).name='75 to 95Hz';
%             
%             
%             freqRange(5).range=[105 150];
%             freqRange(5).name='105 to 150Hz';
            
            
            for h=1:size(freqRange,2)
                
                freqRange(h).name
                prefixFileName=[stim_type '_' cond_type.t '_' freqRange(h).name '_' patientROI(t).name];
                titleName='Test2';%[stim_type '-' cond_type '-' freqRange(h).name '-' EmpathyForPain_P9_Anatomic(t).name];
                
                PlotCollapsedERPSFreqRangeAndBase(condMat1,condMat2,conditionName1,conditionName2,freqs,freqRange(h).range,timesout,baseTime,statmethod,p_value,prefixFileName,titleName,color1,color2,colorPvalue)
                
            end
            
            
            
        end