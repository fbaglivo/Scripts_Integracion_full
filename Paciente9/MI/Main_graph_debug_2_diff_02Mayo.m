% Calcula la diferencia entre las matrices de conectividad
% de dos frecuencias
% 
% 02/6/2016


addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')


conf.test_type={'Faces'};
conf.stim_type={'Retention' }%,'PostRetention_Objects','Decision_Objects'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='Farinelli_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMICoronal_New2mayoDiff.mat';
conf.configurationMat(2).config='wSMICoronal_New2mayoDiff.mat';
conf.configurationMat(3).config='wSMISagittal_New2mayoDiff.mat';%'wSMISagittal_New2mayoDiff.mat'
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\GraphBrain\Figs\'
conf.imageExt='eps'

tau=[2 5]

for k=1:size(conf.test_type,2) %
    
    for u=1:size(conf.stim_type,2)
        
        file= ['P9_' cell2mat(conf.stim_type(u))   '_' num2str(tau(1))];
        Hifreq=load([file '.mat']);
                
        file= ['P9_' cell2mat(conf.stim_type(u))   '_' num2str(tau(2))];
        Lofreq=load([file '.mat']);

        LF.tvals=Lofreq.T(find(Lofreq.Ps<0.005 & Lofreq.Ps>0.001));
        LF.tval=min(abs(LF.tvals)); %select t value close to p=0.005
        LF.Tgraph=-1*Lofreq.T;
        LF.Tgraph(abs(LF.Tgraph)<LF.tval)=0;
        LF.Tgraph=triu(LF.Tgraph);
        
        HF.tvals=Hifreq.T(find(Hifreq.Ps<0.005 & Hifreq.Ps>0.001));
        HF.tval=min(abs(HF.tvals)); %select t value close to p=0.005
        HF.Tgraph=-1*Hifreq.T;
        HF.Tgraph(abs(HF.Tgraph)<HF.tval)=0;
        HF.Tgraph=triu(HF.Tgraph);
        
        
        LF.Treshape=reshape(LF.Tgraph,size(LF.Tgraph,1)*size(LF.Tgraph,2),1);
        quantiles=quantile(LF.Treshape,[0.01 0.99]); %[0.25 0.75]
        ttresh=quantiles(find(max(abs(quantiles))));        
        LF.Tgraph(LF.Tgraph<abs(ttresh) & LF.Tgraph>-abs(ttresh))=0;
        
        
        HF.Treshape=reshape(HF.Tgraph,size(HF.Tgraph,1)*size(HF.Tgraph,2),1);
        quantiles=quantile(HF.Treshape,[0.01 0.99]); %[0.25 0.75]
        ttresh=quantiles(find(max(abs(quantiles))));        
        HF.Tgraph(HF.Tgraph<abs(ttresh) & HF.Tgraph>-abs(ttresh))=0;
        
               
        Tgraph=abs(HF.Tgraph)-abs(LF.Tgraph);
        
                        
        PrintEdgeFile(['GraphBrain/Edges/' file],Tgraph);
        
        
        outputFileNames{1}=[file ' diff ' cell2mat(conf.stim_type(u)) '_Coronal_' ];
        outputFileNames{2}=[file ' diff ' cell2mat(conf.stim_type(u)) '_Sagittal_' ];
        outputFileNames{3}=[file ' diff ' cell2mat(conf.stim_type(u)) '_Axial_' ];
        Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
               
    end
    
    
end

