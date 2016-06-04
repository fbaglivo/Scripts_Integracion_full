% Script para graficar los resultados de wSMI en modelo
% de cerebro con electrodos.
% Graficar valores con p<minpval. Se hace la resta entre condiciones
% Se normalizan los valores con el máximo valor en módulo de
% la diferencia. Se grafican aquellos que superan umbral




%%%%%
%%  Ver si grafico los valores de t o los de wSMI
%%
%%%%


addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150807\')


conf.test_type={'Faces'};
conf.stim_type={'PostRetention' }%,'PostRetention_Objects','Decision_Objects'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='P12_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMISagittal_New29aprilFACES.mat'%'wSMICoronal_NEW27AprilOBJECT.mat'
conf.configurationMat(2).config='wSMICoronal_New29aprilFACES.mat'
conf.configurationMat(3).config='wSMISagittal_New29aprilFACES.mat'%'wSMIAxial.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\GraphBrain\Figs\'
conf.imageExt='eps'

for tau=[2 5]

    for k=1:size(conf.test_type,2) %

        for u=1:size(conf.stim_type,2)

            file= ['P12_' cell2mat(conf.stim_type(u))   '_' num2str(tau) '1000'];

            load([file '.mat'])        

            %Find T value assigned to 0.01<p<0.05
            
            
            tvals=T(find(Ps<0.001 & Ps>0.0005));
            tval=min(abs(tvals)); %select t value close to p=0.005
            Tgraph=-1*T;
            Tgraph(abs(Tgraph)<tval)=0;
            Tgraph=triu(Tgraph);
            
            Treshape=reshape(Tgraph,size(Tgraph,1)*size(Tgraph,2),1);
            quantiles=quantile(Treshape,[0.1 0.9]); %[0.25 0.75]
            
            ttresh=quantiles(find(max(abs(quantiles))));
            
            Tgraph(Tgraph<abs(ttresh) & Tgraph>-abs(ttresh))=0;
            
                        
            PrintEdgeFile(['GraphBrain/Edges/' file],Tgraph);
            outputFileNames{1}=[file ' ' cell2mat(conf.stim_type(u)) '_Coronal_' num2str(tau)];
            outputFileNames{2}=[file ' ' cell2mat(conf.stim_type(u)) '_Sagittal_' num2str(tau)];
            outputFileNames{3}=[file ' ' cell2mat(conf.stim_type(u)) '_Axial_' num2str(tau)];
            Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);

           
            
  
        end

        
    end

end
