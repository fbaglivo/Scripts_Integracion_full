addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')


conf.test_type={'Faces'};
conf.stim_type={'PostRetention' }%,'PostRetention_Objects','Decision_Objects'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='P12_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMICoronal.mat'
conf.configurationMat(2).config='wSMISagittal.mat'
conf.configurationMat(3).config='wSMIAxial.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\GraphBrain\Figs\'
conf.imageExt='jpg'

for tau=5

    for k=1:size(conf.test_type,2) %

        for u=1:size(conf.stim_type,2)

            file= ['P12_' cell2mat(conf.stim_type(u))   '_' num2str(tau) '1000'];

            load([file '.mat'])        

            WSMI_cond1(find(Ps>0.001))=0;
            WSMI_cond2(find(Ps>0.001))=0;
            diff=-WSMI_cond1+WSMI_cond2; %Bind (neg)-BLUE / Feat (pos) RED
            limit=max(max(abs(diff)));
            M=make_triang_edge(diff,-0.25*limit,0.25*limit);
            PrintEdgeFile(['GraphBrain/Edges/' file],M);
            outputFileNames{1}=[file ' ' cell2mat(conf.stim_type(u)) '_Coronal_' num2str(tau)];
            outputFileNames{2}=[file ' ' cell2mat(conf.stim_type(u)) '_Sagittal_' num2str(tau)];
            outputFileNames{3}=[file ' ' cell2mat(conf.stim_type(u)) '_Axial_' num2str(tau)];
            Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);

            close all
            figure
            
            im=imread(['GraphBrain\Figs\' file ' ' cell2mat(conf.stim_type(u)) '_Sagittal_' num2str(tau) '.jpg']);
            subplot(1,2,1)
            image(im)
            set(gca,'xtick',[])
            set(gca,'xticklabel',[])
            set(gca,'ytick',[])
            set(gca,'yticklabel',[])
            
            
            im=imread(['GraphBrain\Figs\' file  ' ' cell2mat(conf.stim_type(u)) '_Coronal_' num2str(tau) '.jpg']);
            subplot(1,2,2)
            image(im)
            set(gca,'xtick',[])
            set(gca,'xticklabel',[])
            set(gca,'ytick',[])
            set(gca,'yticklabel',[])
            
            
%             im=imread(['GraphBrain\Figs\' file ' ' cell2mat(conf.stim_type(u)) '_Axial_' num2str(tau) '.jpg']);
%             subplot(2,2,3)
%             image(im)
%             set(gca,'xtick',[])
%             set(gca,'xticklabel',[])
%             set(gca,'ytick',[])
%             set(gca,'yticklabel',[])
%             set(gca,'fontsize',36)
%             
%             text(1500,-2300,['P12 - wSMI ' cell2mat(conf.stim_type(u)) 'tau= ' num2str(tau) '.jpg']);
%             
%             %%+l_inf
%             
%             h=gcf;
%             
%             set(h,'PaperPositionMode', 'auto')
%             set(h,'PaperOrientation','landscape');
%             set(h,'Position',[0 0 1200 800]);
%             print(gcf, '-dpdf', ['GraphBrain\Pdf\P12-'  cell2mat(conf.stim_type(u)) ' tau' num2str(tau) '.pdf'])

            
  
        end

        
    end

end
