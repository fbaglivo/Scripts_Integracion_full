
function [cond epoch_window base_window]=configuracion(tipo)  

switch tipo

    
    case 'Retention'
        
        cond(1).type={'32Acc1' '32Acc0'}
        cond(1).name='Binding'
        cond(2).type={'38Acc1' '38Acc0'}
        cond(2).name='Features'
        %epoch_window=[-1  0];
        %base_window=[-1000 -800];
        epoch_window=[-1.4 0.2];
        base_window=[-1400 -1200];

        
    case 'PostRetention'
        
        cond(1).type={'32Acc1' '32Acc0'}
        cond(1).name='Binding'
        cond(2).type={'38Acc1' '38Acc0'}
        cond(2).name='Features'
        epoch_window=[-0.4 1.8];
        base_window=[-400 -200];

case 'PostRetentionRT'
        
        cond(1).type={'32Acc1' '32Acc0'}
        cond(1).name='Binding'
        cond(2).type={'38Acc1' '38Acc0'}
        cond(2).name='Features'
        epoch_window=[-0.4 8];
        base_window=[-400 -200];

    
    
    
    case 'Decision'
        
        cond(1).type={'R32Acc1' 'R32Acc0'}
        cond(1).name='Binding'
        cond(2).type={'R38Acc1' 'R38Acc0'}
        cond(2).name='Features'
        epoch_window=[-0.4 1];
        base_window=[-400 -200];
        
        
    case 'Retention_Objects'
        
        cond(1).type={'5Acc1' '5Acc0' }
        cond(1).name='Binding'
        cond(2).type={'11Acc1' '11Acc0'}
        cond(2).name='Features'
%         epoch_window=[-9.4 1];
%         base_window=[-9400 -9200];
        epoch_window=[-1.4 0.2];
        base_window=[-1400 -1200];



    case 'PostRetention_Objects'
        
        cond(1).type={'5Acc1' '5Acc0'}
        cond(1).name='Binding'
        cond(2).type={'11Acc1' '11Acc0'}
        cond(2).name='Features'
        epoch_window=[-0.4 1.8];
        base_window=[-400 -200];

    case 'PostRetentionRT_Objects'
        
        cond(1).type={'5Acc1' '5Acc0'}
        cond(1).name='Binding'
        cond(2).type={'11Acc1' '11Acc0'}
        cond(2).name='Features'
        epoch_window=[-0.4 8];
        base_window=[-400 -200];

        
    case 'Decision_Objects'
        
        cond(1).type={'R5Acc1' 'R5Acc0'}
        cond(1).name='Binding'
        cond(2).type={'R11Acc1' 'R11Acc0'}
        cond(2).name='Features'
        epoch_window=[-0.4 1];
        base_window=[-400 -200];


    case 'Retention_Features'
        
        cond(1).type={'19Acc1'}
        cond(1).name='Spatial'
        cond(2).type={'26Acc1'}
        cond(2).name='NonSpatial'
        epoch_window=[-9.4 1];
        base_window=[-9400 -9200];

    case 'PostRetention_Features'
        
        cond(1).type={'19Acc1'}
        cond(1).name='Spatial'
        cond(2).type={'26Acc1'}
        cond(2).name='NonSpatial'
        epoch_window=[-0.4 1];
        base_window=[-400 -200];
        
    case 'Decision_Features'
        
        cond(1).type={'R19Acc1'}
        cond(1).name='Spatial'
        cond(2).type={'R26Acc1'}
        cond(2).name='NonSpatial'
        epoch_window=[-0.4 1];
        base_window=[-400 -200];
        
        
        % ACC 0
        
        
    case 'Retention_acc0'
        
        cond(1).type={'32Acc0'}
        cond(1).name='Binding'
        cond(2).type={'38Acc0'}
        cond(2).name='Features'
        epoch_window=[-1  0];
        base_window=[-1000 -800];

    case 'PostRetention_acc0'
        
        cond(1).type={'32Acc0'}
        cond(1).name='Binding'
        cond(2).type={'38Acc1'}
        cond(2).name='Features'
        epoch_window=[-0.2 1.8];
        base_window=[-200 0];

    case 'Decision_acc0'
        
        cond(1).type={'R32Acc0'}
        cond(1).name='Binding'
        cond(2).type={'R38Acc1'}
        cond(2).name='Features'
        epoch_window=[-0.2 1];
        base_window=[-200 0];

        
    case 'Retention_Objects_acc0'
        
        cond(1).type={'5Acc0'}
        cond(1).name='Binding'
        cond(2).type={'11Acc1'}
        cond(2).name='Features'
        epoch_window=[-1  0];
        base_window=[-1000 -800];

    case 'PostRetention_Objects_acc0'
        
        cond(1).type={'5Acc0'}
        cond(1).name='Binding'
        cond(2).type={'11Acc1'}
        cond(2).name='Features'
        epoch_window=[-0.2 1.8];
        base_window=[-200 0];

    case 'Decision_Objects_acc0'
        
        cond(1).type={'R5Acc0'}
        cond(1).name='Binding'
        cond(2).type={'R11Acc1'}
        cond(2).name='Features'
        epoch_window=[-0.2 1];
        base_window=[-200 0];

        

        
    case 'Retention_vs'
        
        cond(1).type={'32Acc1'}
        cond(1).name='Binding-acc1'
        cond(2).type={'38Acc1'}
        cond(2).name='Features-acc1'
        
        cond(3).type={'32Acc0'}
        cond(3).name='Binding-acc0'
        cond(4).type={'38Acc0'}
        cond(4).name='Features-acc0'
        epoch_window=[-1  0];
        base_window=[-1000 -800];

        
    case 'PostRetention_vs'
        
        cond(1).type={'32Acc1'}
        cond(1).name='Binding-acc1'
        cond(2).type={'38Acc1'}
        cond(2).name='Features-acc1'
        
        cond(3).type={'32Acc0'}
        cond(3).name='Binding-acc0'
        cond(4).type={'38Acc0'}
        cond(4).name='Features-acc0'
        
        epoch_window=[-0.2 1.8];
        base_window=[-200 0];

        
    case 'Decision_vs'
        
        cond(1).type={'R32Acc1'}
        cond(1).name='Binding-acc1'
        cond(2).type={'R38Acc1'}
        cond(2).name='Features-acc1'
        
        cond(3).type={'R32Acc0'}
        cond(3).name='Binding-acc0'
        cond(4).type={'R38Acc0'}
        cond(4).name='Features-acc0'
        epoch_window=[-0.2 1];
        base_window=[-200 0];
        
        
        
    case 'Retention_vs_objects'
        
        cond(1).type={'5Acc1'}
        cond(1).name='Binding-acc1'
        cond(2).type={'11Acc1'}
        cond(2).name='Features-acc1'
        
        cond(3).type={'5Acc0'}
        cond(3).name='Binding-acc0'
        cond(4).type={'11Acc0'}
        cond(4).name='Features-acc0'
        epoch_window=[-1  0];
        base_window=[-1000 -800];

    case 'PostRetention_vs_objects'
        
        cond(1).type={'5Acc1'}
        cond(1).name='Binding-acc1'
        cond(2).type={'11Acc1'}
        cond(2).name='Features-acc1'
        
        cond(3).type={'5Acc0'}
        cond(3).name='Binding-acc0'
        cond(4).type={'11Acc0'}
        cond(4).name='Features-acc0'
        epoch_window=[-0.2 1];
        base_window=[-200 0];
        
        
    case 'Decision_vs_objects'
        
        cond(1).type={'R5Acc1'}
        cond(1).name='Binding-acc1'
        cond(2).type={'R11Acc1'}
        cond(2).name='Features-acc1'
        
        cond(3).type={'R5Acc0'}
        cond(3).name='Binding-acc0'
        cond(4).type={'R11Acc0'}
        cond(4).name='Features-acc0'
        epoch_window=[-0.2 1];
        base_window=[-200 0];
        

    case 'Decision_vs_Features'
        
        cond(1).type={'R19Acc1'}
        cond(1).name='Spatial-acc1'
        cond(2).type={'R26Acc1'}
        cond(2).name='NonSpatial-acc1'
        
        cond(3).type={'R19Acc0'}
        cond(3).name='Spatial-acc0'
        cond(4).type={'R26Acc0'}
        cond(4).name='NonSpatial-acc0'
        epoch_window=[-0.2 1];
        base_window=[-200 0];

    case 'Retention_vs_features'
        

        cond(1).type={'19Acc1'}
        cond(1).name='Spatial-acc1'
        cond(2).type={'26Acc1'}
        cond(2).name='NonSpatial-acc1'
        
        cond(3).type={'19Acc0'}
        cond(3).name='Spatial-acc0'
        cond(4).type={'26Acc0'}
        cond(4).name='NonSpatial-acc0'
        
        epoch_window=[-1  0];
        base_window=[-1000 -800];
        
    case 'PostRetention_vs_features'
        

        cond(1).type={'19Acc1'}
        cond(1).name='Spatial-acc1'
        cond(2).type={'26Acc1'}
        cond(2).name='NonSpatial-acc1'
        
        cond(3).type={'19Acc0'}
        cond(3).name='Spatial-acc0'
        cond(4).type={'26Acc0'}
        cond(4).name='NonSpatial-acc0'
        
        epoch_window=[-0.2 1];
        base_window=[-200 0];
  
    
    case 'FacePre_vs'
        
        cond(1).type={'29Acc1'}
        cond(1).name='Face_binding_Acc1'
        cond(2).type={'29Acc0'}
        cond(2).name='Face_binding_Acc0'
        cond(3).type={'35Acc1' }
        cond(3).name='Face_Feature_Acc1'
        cond(4).type={'35Acc0' }
        cond(4).name='Face_feature_Acc0'
  
        epoch_window=[-0.6 1];
        base_window=[-600 -400];
  
        
    case 'ObjectsPre_vs'
        
        cond(1).type={'1Acc1'}
        cond(1).name='Objects_binding_Acc1'
        cond(2).type={'1Acc0'}
        cond(2).name='Objects_binding_Acc0'
        
        cond(3).type={'8Acc1'}
        cond(3).name='Objects_feature_Acc1'
        cond(4).type={'8Acc0'}
        cond(4).name='Objects_feature_Acc0'

        epoch_window=[-0.6 1];
        base_window=[-600 -400];
    
        
    case 'Facebind_vs_Faceint_S1'
        cond(1).type={'29Acc0' '29Acc1'}
        cond(1).name='Face_binding'
        cond(2).type={'35Acc0' '35Acc1'}
        cond(2).name='Face_feature'
        
    case 'Faces_vs_objects_S1'
        
        cond(1).type={'29Acc1' '35Acc1' '29Acc0' '35Acc0'}
        cond(1).name='Faces'
        cond(2).type={'1Acc1'   '8Acc1' '1Acc0'   '8Acc0'}
        cond(2).name='Objects'
%         cond(3).type={'3'}
%         cond(3).name='Neutral'
    
end
