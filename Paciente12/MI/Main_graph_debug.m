addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')


conf.test_type={'Objects'};
conf.stim_type={'Retention_Objects','PostRetention_Objects','Decision_Objects'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='P12_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMICoronalAuto.mat'
conf.configurationMat(2).config='wSMISagittalAuto.mat'
conf.configurationMat(3).config='wSMIAxialAuto.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\GraphBrain\Figs\'
conf.imageExt='jpg'

for tau=1:5

    for k=1 %:size(conf.test_type) %

        for u=1:size(conf.stim_type,2)

            file= ['P12_' cell2mat(conf.stim_type(u))   '_' num2str(tau) '.mat'];

            load(file)        

            WSMI_cond1(find(Ps>0.0001))=0;
            M=make_triang_edge(WSMI_cond1,-1,0.85*max(max(WSMI_cond1)));
            PrintEdgeFile(['GraphBrain/Edges/' file],M);
            outputFileNames{1}=[file  '_BindCoronal_' num2str(tau)];
            outputFileNames{2}=[file  '_BindSagittal_' num2str(tau)];
            outputFileNames{3}=[file  '_BindAxial_' num2str(tau)];
            Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);

            WSMI_cond2(find(Ps>0.0001))=0;
            M=make_triang_edge(WSMI_cond2,-1,0.85*max(max(WSMI_cond2)));
            PrintEdgeFile(['GraphBrain/Edges/' file],M);
            outputFileNames{1}=[file  '_FeatCoronal_' num2str(tau)];
            outputFileNames{2}=[file  '_FeatSagittal_' num2str(tau)];
            outputFileNames{3}=[file  '_FeatAxial_' num2str(tau)];
            Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);



    %         T(find(Ps>0.0001))=0;
    %         M=make_triang_edge(T,-0.85*min(min(T)),0.85*max(max(T)));
    %         PrintEdgeFile(['GraphBrain/Edges/' file],M);
    %         outputFileNames{1}=[file  '_TCoronal_' num2str(tau)];
    %         outputFileNames{2}=[file  '_TSagittal_' num2str(tau)];
    %         outputFileNames{3}=[file  '_TAxial_' num2str(tau)];
    %         Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file   '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
    %         
        end

        %
    end

end
