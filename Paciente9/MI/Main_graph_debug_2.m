% Script para graficar los resultados de wSMI en modelo
% de cerebro con electrodos.
% Graficar valores con p<minpval. Se hace la resta entre condiciones
% Se normalizan los valores con el máximo valor en módulo de
% la diferencia. Se grafican aquellos que superan umbral


minpval=0.001;
umbral=0.5;


%%%%%
%%  Ver si grafico los valores de t o los de wSMI
%%
%%%%


addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150807\')


conf.test_type={'Objects'};
conf.stim_type={'Retention_Objects'}%,'PostRetention_Objects','Decision_Objects'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='Farinelli_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMICoronal_NEW.mat'
conf.configurationMat(2).config='wSMISagittal_NEW.mat'
conf.configurationMat(3).config='wSMIAxial.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\GraphBrain\Figs\'
conf.imageExt='jpg'

for tau=2%[2 5]

    for k=1:size(conf.test_type,2) %

        for u=1:size(conf.stim_type,2)

            file= ['P9_' cell2mat(conf.stim_type(u))   '_' num2str(tau) '1000'];

            load([file '.mat'])        

            WSMI_cond1(find(Ps>minpval))=0;
            WSMI_cond2(find(Ps>minpval))=0;
            diff=-WSMI_cond1+WSMI_cond2; %Bind (neg)-BLUE / Feat (pos) RED
            limit=max(max(abs(diff)));
            diff=diff/limit;
            M=0.7*make_triang_edge(diff,-umbral,umbral);
            
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
            
%             
%             im=imread(['GraphBrain\Figs\' file ' ' cell2mat(conf.stim_type(u)) '_Axial_' num2str(tau) '.jpg']);
%             subplot(2,2,3)
%             image(im)
%             set(gca,'xtick',[])
%             set(gca,'xticklabel',[])
%             set(gca,'ytick',[])
%             set(gca,'yticklabel',[])
%             set(gca,'fontsize',36)
% %             
%             text(1500,-2300,['P12 - wSMI ' cell2mat(conf.stim_type(u)) 'tau= ' num2str(tau) '.jpg']);
%             
            %%+l_inf
            
%             h=gcf;
%             
%             set(h,'PaperPositionMode', 'auto')
%             set(h,'PaperOrientation','landscape');
%             set(h,'Position',[0 0 1200 800]);
%             print(gcf, '-dpdf', ['GraphBrain\Pdf\P12-'  cell2mat(conf.stim_type(u)) ' tau' num2str(tau) '.pdf'])

            
  
        end

        
    end

end
