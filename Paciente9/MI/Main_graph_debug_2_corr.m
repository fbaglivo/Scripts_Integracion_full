% Calcula la diferencia entre las matrices de conectividad
% de dos frecuencias
% 
% 25/01/2016



addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')


conf.test_type={'Objects'};
conf.stim_type={'PostRetention_Objects' }%,'PostRetention_Objects','Decision_Objects'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='Farinelli_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMICoronaldiff.mat'
conf.configurationMat(2).config='wSMISagittaldiff.mat'
conf.configurationMat(3).config='wSMIAxialdiff.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\GraphBrain\Figs\'
conf.imageExt='jpg'

tau=[2 5]

for k=1:size(conf.test_type,2) %
    
    for u=1:size(conf.stim_type,2)
        
        file= ['P9_' cell2mat(conf.stim_type(u))   '_' num2str(tau(1))];
        Hifreq=load([file '.mat']);
        
        
        file= ['P9_' cell2mat(conf.stim_type(u))   '_' num2str(tau(2))];
        Lofreq=load([file '.mat']);
        
        Hi=cat(3,Hifreq.WSMI_cond1TRIAL,Hifreq.WSMI_cond2TRIAL);
        
        Lo=cat(3,Lofreq.WSMI_cond1TRIAL,Lofreq.WSMI_cond2TRIAL);
        
        for i = 1:90
            for j = (i+1):90

                C(i,j)=corr(squeeze(Hi(i,j,:)),squeeze(Lo(i,j,:)));
                C(j,i)=C(i,j);
            end
       end
        
        
        

        thres=max(max(abs(C)));
        
        M=make_triang_edge(C,-0.75*thres,0.75*thres);
                
        
        PrintEdgeFile(['GraphBrain/Edges/' file],M);
        outputFileNames{1}=[file ' corr ' cell2mat(conf.stim_type(u)) '_Coronal_' ];
        outputFileNames{2}=[file ' corr ' cell2mat(conf.stim_type(u)) '_Sagittal_' ];
        outputFileNames{3}=[file ' corr ' cell2mat(conf.stim_type(u)) '_Axial_' ];
        Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
        
        close all
        figure
        
        im=imread(['GraphBrain\Figs\' file ' corr ' cell2mat(conf.stim_type(u)) '_Sagittal_.jpg']);
        subplot(1,2,1)
        image(im)
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        set(gca,'ytick',[])
        set(gca,'yticklabel',[])
        
        
        im=imread(['GraphBrain\Figs\' file  ' corr ' cell2mat(conf.stim_type(u)) '_Coronal_.jpg']);
        subplot(1,2,2)
        image(im)
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        set(gca,'ytick',[])
        set(gca,'yticklabel',[])
        
        
%         im=imread(['GraphBrain\Figs\' file ' corr ' cell2mat(conf.stim_type(u)) '_Axial_.jpg']);
%         subplot(2,2,3)
%         image(im)
%         set(gca,'xtick',[])
%         set(gca,'xticklabel',[])
%         set(gca,'ytick',[])
%         set(gca,'yticklabel',[])
%         set(gca,'fontsize',36)
        
%         text(1500,-2300,['P9 - wSMI corr' cell2mat(conf.stim_type(u)) '.jpg']);
%         
%         %%+l_inf
%         
%         h=gcf;
%         
%         set(h,'PaperPositionMode', 'auto')
%         set(h,'PaperOrientation','landscape');
%         set(h,'Position',[0 0 1200 800]);
%         print(gcf, '-dpdf', ['GraphBrain\Pdf\P9-corr'  cell2mat(conf.stim_type(u)) '.pdf'])
%         
%         
        
        
    end
    
    
end

