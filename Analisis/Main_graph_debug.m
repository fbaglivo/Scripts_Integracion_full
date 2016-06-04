addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')


conf.test_type={'Faces'};
conf.stim_type={'Retention','PostRetention','Decision'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='P12_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='Coronal.mat'
conf.configurationMat(2).config='Sagittal.mat'
conf.configurationMat(3).config='Axial.mat'
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\MI\GraphBrain\Figs\'
conf.imageExt='jpg'


for k=1 %:size(conf.test_type) %
    
    for u=1:size(conf.stim_type,2)
        
        file= ['P12_Retention_1.mat'];
        
        load(['Mats/' file])        
        
        
        M=make_triang_edge(wSMI_cond1,-10,10);
        PrintEdgeFile(['GraphBrain/Edges/' file '_window_'  num2str(slide_w)],M);
        outputFileNames{1}=[file '_window_bind'  num2str(slide_w) '_Coronal'];
        outputFileNames{2}=[file '_window_bind'  num2str(slide_w) '_Sagittal'];
        outputFileNames{3}=[file '_window_bind'  num2str(slide_w) '_Axial'];
        Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file '_window_'  num2str(slide_w) '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
        
    end
    
    %
end


