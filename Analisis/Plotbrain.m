

addpath(genpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\'))
% addpath('Euge\')


surfaceFile='BrainMesh_ICBM152.nv';
nodeFile='Farinelli_Complete_Monopolar_Nodes.node'
edgeFile='test.edge'
configurationMat='wSMICoronal.mat'
baseFileName='D:\_INECO\Procesamiento\Euge\'
outputFileNames='prueba_fabri'
imageExt='jpg'


fileName = [baseFileName outputFileNames '.' imageExt];
BrainNet_MapCfg(surfaceFile,nodeFile,edgeFile,configurationMat,fileName);


