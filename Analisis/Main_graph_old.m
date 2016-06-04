addpath('Functions/')
addpath('GraphBrain/')
addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')


conf.corr_type={'pearson','spearman','Kendal'};
conf.reref_type={'No_ref','Avg_ref','reref'}; 
conf.test_type={'Faces','Objects','Features'};
conf.stim_type={'Retention','PostRetention','Decision'};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile='Farinelli_Complete_Monopolar_Nodes.node'
conf.configurationMat(1).config='wSMICoronal.mat'
conf.configurationMat(2).config='wSMISagittal.mat'
conf.configurationMat(3).config='wSMIAxial.mat'
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Analisis\Figs\Heads\'
conf.imageExt='jpg'



conf.high_correl=1;
conf.high_T=1;
conf.high_diff=0.2;


conf.low_correl=0.9;
conf.low_T=-1;
conf.low_diff=-0.2;
conf.p=0.001;

for i=1:size(conf.corr_type,2)
   
    for j= 2%No_ref
        
        for k=2:size(conf.test_type,2) %Faces
                    
            for u=1:size(conf.stim_type,2)
              
                file= [cell2mat(conf.stim_type(u)) '_' cell2mat(conf.test_type(k)) '_corr_' cell2mat(conf.corr_type(i))];
                
                load(['Mats/' cell2mat(conf.reref_type(j)) '/' file])
                
                % Correl bind
                
                for slide_w=1:size(bind,2)
                
                    M=bind(slide_w).r;
                    badchans
                    switch cell2mat(conf.test_type(k))
                        case 'Faces'
                            M(faces_badchans,:)=0;
                            M(:,faces_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Objects'
                            
                            M(objects_badchans,:)=0;
                            M(:,objects_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Features'
                            
                            M(features_badchans,:)=0;
                            M(:,features_badchans)=0;
                            disp('bad_chans eliminados')
                    end
                        
                    M=make_triang_edge(M,conf.low_correl,conf.high_correl);
                    PrintEdgeFile(['GraphBrain/Edges/' file '_window_'  num2str(slide_w)],M);
                    outputFileNames{1}=[file '_window_bind'  num2str(slide_w) '_Coronal'];
                    outputFileNames{2}=[file '_window_bind'  num2str(slide_w) '_Sagittal'];
                    outputFileNames{3}=[file '_window_bind'  num2str(slide_w) '_Axial'];
                    Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file '_window_'  num2str(slide_w) '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
                    
                end
                
                %Correl feat
                          
                for slide_w=1:size(feat,2)
                
                    M=feat(slide_w).r;
                    
                    switch cell2mat(conf.test_type(k))
                        case 'Faces'
                            M(faces_badchans,:)=0;
                            M(:,faces_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Objects'
                            
                            M(objects_badchans,:)=0;
                            M(:,objects_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Features'
                            
                            M(features_badchans,:)=0;
                            M(:,features_badchans)=0;
                            disp('bad_chans eliminados')
                    end
                    
                    M=make_triang_edge(M,conf.low_correl,conf.high_correl);
                    PrintEdgeFile(['GraphBrain/Edges/' file '_window_'  num2str(slide_w)],M);
                    outputFileNames{1}=[file '_window_feat'  num2str(slide_w) '_Coronal'];
                    outputFileNames{2}=[file '_window_feat'  num2str(slide_w) '_Sagittal'];
                    outputFileNames{3}=[file '_window_feat'  num2str(slide_w) '_Axial'];
                    Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file '_window_'  num2str(slide_w) '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
                    
                end
                
                % Diff
                
                for slide_w=1:size(feat,2)
                
                    M=bind(slide_w).r-feat(slide_w).r;
                    
                    switch cell2mat(conf.test_type(k))
                        case 'Faces'
                            M(faces_badchans,:)=0;
                            M(:,faces_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Objects'
                            
                            M(objects_badchans,:)=0;
                            M(:,objects_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Features'
                            
                            M(features_badchans,:)=0;
                            M(:,features_badchans)=0;
                            disp('bad_chans eliminados')
                    end
                    
                    M=make_triang_edge(M,conf.high_diff,conf.low_diff);
                    M(find(Ps(slide_w).data>conf.p))=0;
                    PrintEdgeFile(['GraphBrain/Edges/' file '_window_'  num2str(slide_w)],M);
                    outputFileNames{1}=[file '_window_diff'  num2str(slide_w) '_Coronal'];
                    outputFileNames{2}=[file '_window_diff'  num2str(slide_w) '_Sagittal'];
                    outputFileNames{3}=[file '_window_diff'  num2str(slide_w) '_Axial'];
                    Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file '_window_'  num2str(slide_w) '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
                    
                end
                
                % T
                                
                for slide_w=1:size(feat,2)
                
                    M=T(slide_w).data;
                    M(find(Ps(slide_w).data>conf.p))=0;
                   switch cell2mat(conf.test_type(k))
                        case 'Faces'
                            M(faces_badchans,:)=0;
                            M(:,faces_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Objects'
                            
                            M(objects_badchans,:)=0;
                            M(:,objects_badchans)=0;
                            disp('bad_chans eliminados')
                        case 'Features'
                            
                            M(features_badchans,:)=0;
                            M(:,features_badchans)=0;
                            disp('bad_chans eliminados')
                    end
                    M=make_triang_edge(M,conf.high_T,conf.low_T);
                    
                    PrintEdgeFile(['GraphBrain/Edges/' file '_window_'  num2str(slide_w)],M);
                    outputFileNames{1}=[file '_window_T'  num2str(slide_w) '_Coronal'];
                    outputFileNames{2}=[file '_window_T'  num2str(slide_w) '_Sagittal'];
                    outputFileNames{3}=[file '_window_T'  num2str(slide_w) '_Axial'];
                    Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,['GraphBrain/Edges/' file '_window_'  num2str(slide_w) '.edge'],conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
                    
                end
                
            end
            
        end
            
    end
    
end
