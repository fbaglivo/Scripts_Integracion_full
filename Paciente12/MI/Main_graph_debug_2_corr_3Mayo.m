% Calcula la diferencia entre las matrices de conectividad
% de dos frecuencias
% 
% 25/01/2016

clear all
close all

addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')


conf.test_type={'Faces'};
conf.stim_type={'PostRetention' }%,'PostRetention_Objects','Decision_Objects'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='P12_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMICoronal_New3mayoCorr.mat'
conf.configurationMat(2).config='wSMISagittal_New3mayoCorr.mat'
conf.configurationMat(3).config='wSMISagittal_New3mayoCorr.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\GraphBrain\Figs\'
conf.imageExt='eps'

tau=[2 5]

for k=1:size(conf.test_type,2) %
    
    for u=1:size(conf.stim_type,2)
        
        file= ['P12_' cell2mat(conf.stim_type(u))   '_' num2str(tau(1))];
        Hifreq=load(['Mats\' file '.mat']);
        
        file= ['P12_' cell2mat(conf.stim_type(u))   '_' num2str(tau(2))];
        Lofreq=load(['Mats\' file '.mat']);       
        
        % Voy a quedarme con las conecciones que son significativas
        % Quiero binarizar mis matrices de wSMI
        
        LF.tvals=Lofreq.T(find(Lofreq.Ps<0.005 & Lofreq.Ps>0.001));
        LF.tval=min(abs(LF.tvals)); %select t value close to p=0.005
        LF.Tgraph=-1*Lofreq.T;
        LF.Tgraph(abs(LF.Tgraph)<LF.tval)=0;
        LF.Tgraph=triu(LF.Tgraph);
        
        LFbin=zeros(size(LF.Tgraph,1),size(LF.Tgraph,2));
        LFbin(LF.Tgraph>0)=1;
        LFbin(LF.Tgraph<0)=-1;
        
        HF.tvals=Hifreq.T(find(Hifreq.Ps<0.005 & Hifreq.Ps>0.001));
        HF.tval=min(abs(HF.tvals)); %select t value close to p=0.005
        HF.Tgraph=-1*Hifreq.T;
        HF.Tgraph(abs(HF.Tgraph)<HF.tval)=0;
        HF.Tgraph=triu(HF.Tgraph);
        
        HFbin=zeros(size(HF.Tgraph,1),size(HF.Tgraph,2));
        HFbin(HF.Tgraph>0)=1;
        HFbin(HF.Tgraph<0)=-1;
        
        % Preparo las matrices de wSMI
        
        Hifreq.WSMI_cond1TRIAL(Hifreq.WSMI_cond1TRIAL<0)=0;
        Hifreq.WSMI_cond2TRIAL(Hifreq.WSMI_cond2TRIAL<0)=0;
        Lofreq.WSMI_cond1TRIAL(Lofreq.WSMI_cond1TRIAL<0)=0;
        Lofreq.WSMI_cond2TRIAL(Lofreq.WSMI_cond2TRIAL<0)=0;
        
        for k=1:size(Hifreq.WSMI_cond1TRIAL,3)
        
            Hifreq.WSMI_cond1TRIAL(:,:,k)=squeeze(Hifreq.WSMI_cond1TRIAL(:,:,k)).*HFbin;
            Hifreq.WSMI_cond2TRIAL(:,:,k)=squeeze(Hifreq.WSMI_cond2TRIAL(:,:,k)).*HFbin;
            Lofreq.WSMI_cond1TRIAL(:,:,k)=squeeze(Lofreq.WSMI_cond1TRIAL(:,:,k)).*LFbin;
            Lofreq.WSMI_cond2TRIAL(:,:,k)=squeeze(Lofreq.WSMI_cond2TRIAL(:,:,k)).*LFbin
            
        end
        
        %
        
        Hi=cat(3,Hifreq.WSMI_cond1TRIAL,Hifreq.WSMI_cond2TRIAL);
        Lo=cat(3,Lofreq.WSMI_cond1TRIAL,Lofreq.WSMI_cond2TRIAL);

        for i = 1:67
            for j = (i+1):67

                C(i,j)=corr(squeeze(Hi(i,j,:)),squeeze(Lo(i,j,:)));
                C(j,i)=C(i,j);
            end
       end
        
%         thres=max(max(abs(C)));
%         
%         M=make_triang_edge(C,-0.75*thres,0.75*thres);
        

        M=make_triang_edge(C,-0.5,0.5);
                
        PrintEdgeFile(['GraphBrain/Edges/' file],M);
        outputFileNames{1}=[file ' corr ' cell2mat(conf.stim_type(u)) '_Coronal_' date];
        outputFileNames{2}=[file ' corr ' cell2mat(conf.stim_type(u)) '_Sagittal_' date];
        outputFileNames{3}=[file ' corr ' cell2mat(conf.stim_type(u)) '_Axial_' date];
        Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
        
    end
    
    
end

