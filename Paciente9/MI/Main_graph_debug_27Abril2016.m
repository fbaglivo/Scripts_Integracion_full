% Script para graficar los resultados de wSMI en modelo
% de cerebro con electrodos.
% Graficar valores con p<minpval. Se hace la resta entre condiciones
% Se normalizan los valores con el máximo valor en módulo de
% la diferencia. Se grafican aquellos que superan umbral


umbral=0.001;


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
conf.configurationMat(1).config='wSMICoronal_NEW27AprilOBJECT.mat'
conf.configurationMat(2).config='wSMISagittal_NEW27AprilOBJECT.mat'
conf.configurationMat(3).config='wSMIAxial.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\MI\GraphBrain\Figs\'
conf.imageExt='eps'

for tau=2%[2 5]

    for k=1:size(conf.test_type,2) %

        for u=1:size(conf.stim_type,2)

            file= ['P9_' cell2mat(conf.stim_type(u))   '_' num2str(tau) '1000'];

            load([file '.mat'])        

            %Select p values above umbral, make matrix triangular an change 
            %elements sign using T values
            
            Ps(find(Ps>umbral))=0;
            Ps=triu(Ps);            
            Tsign=sign(T);
            Psigned=Ps.*Tsign;
            
            % Scaling Matrix for graph purpose
            
            Psigned=1./Psigned;
            Psigned(find(Psigned==inf))=0;
            Psigned(find(Psigned==-inf))=0;
            Psigned=-10.*Psigned./max(max(Psigned)); 
            
            PrintEdgeFile(['GraphBrain/Edges/' file],Psigned);
            outputFileNames{1}=[file ' ' cell2mat(conf.stim_type(u)) '_Coronal_' num2str(tau)];
            outputFileNames{2}=[file ' ' cell2mat(conf.stim_type(u)) '_Sagittal_' num2str(tau)];
            outputFileNames{3}=[file ' ' cell2mat(conf.stim_type(u)) '_Axial_' num2str(tau)];
            Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);

           
            
  
        end

        
    end

end
