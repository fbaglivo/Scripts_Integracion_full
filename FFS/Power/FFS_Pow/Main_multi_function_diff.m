function Main_multi_function_diff(tipo,freq)


brain_cor='cor2patDIFF_size.mat';
brain_sag='sag2patDIFF_size.mat';
brain_saginv='saginv2patDIFF_size2.mat';
                        
fsampling=200/1.4; %Hz
nperm=1000;
alfa=0.01;
l_inf=-200/1000; %s
w_size=500/1000; %s
offset=1000/1000; %s
delta=50/1000;

Paciente(1).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente12ERPSOutputs__Retention_' tipo '_' freq '.mat'];
Paciente(2).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente9ERPSOutputs__Retention_' tipo '_' freq '.mat'];

MM=[];
MMR=[];

for pac=1:2
    
    Pac=load(Paciente(pac).path);
    
    tam=size(Pac.cond(1).data,2);
    tiempo=1:1:tam;
    tiempo=tiempo-20;
    
    
    init=ceil(((offset-w_size/2))*fsampling);
    endi=ceil(((offset+w_size/2))*fsampling);
    
    for i=1:size(Pac.cond(1).data)
        
        DATA={squeeze(Pac.cond(1).data(i,init:endi,:)),squeeze(Pac.cond(2).data(i,init:endi,:))};
        [tf dff pvalsf] = statcond(DATA,'mode','boot','paired','on','naccu', nperm);
        if ~isempty(find(pvalsf<alfa))
        
            range(i).data=p_finder(pvalsf,alfa,delta*fsampling);
            pvals(i).p=pvalsf;
            tvals(i).t=tf;
        
        else
        
            range(i).data=[];
            pvals(i).p=pvalsf;
            tvals(i).t=tf;
        
        end
        
        if ~isempty(range(i).data)
            
            for u=1:max(size(range(i).data))
               
                
                if range(i).data(u).detect==1

                    selecc_bind=mean(mean(squeeze(Pac.cond(1).data(i,init+range(i).data(1).start:init+range(i).data(1).end,:)),2));
                    selecc_feat=mean(mean(squeeze(Pac.cond(2).data(i,init+range(i).data(1).start:init+range(i).data(1).end,:)),2));

                    Mtemp(u)=abs(selecc_bind)-abs(selecc_feat);

                else

                    Mtemp(u)=0;

                end
                                
            end %for
        
            M(i)=max(Mtemp);
                
        else
            
            M(i)=0;
            
        end
        
   
        
    end

        MMR=cat(2,MMR,M);
        clear M
end

%%

fsampling=200/2; %Hz

w_size=500/1000; %s
offset=500/1000; %s

Paciente(1).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente12ERPSOutputs__PostRetention_' tipo '_' freq '.mat'];
Paciente(2).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente9ERPSOutputs__PostRetention_' tipo '_' freq '.mat'];

MM=[];
MMPR=[];

for pac=1:2
    
    Pac=load(Paciente(pac).path);
    
    tam=size(Pac.cond(1).data,2);
    tiempo=1:1:tam;
    tiempo=tiempo-20;
    
    
    init=ceil(((offset-w_size/2))*fsampling);
    endi=ceil(((offset+w_size/2))*fsampling);
    
    for i=1:size(Pac.cond(1).data)
        
        DATA={squeeze(Pac.cond(1).data(i,init:endi,:)),squeeze(Pac.cond(2).data(i,init:endi,:))};
        [tf dff pvalsf] = statcond(DATA,'mode','boot','paired','on','naccu', nperm);
        range(i).data=p_finder(pvalsf,alfa,delta*fsampling);
        pvals(i).p=pvalsf;
        tvals(i).t=tf;

        
        if ~isempty(range(i).data)
            
            for u=1:max(size(range(i).data))
               
                
                if range(i).data(u).detect==1

                    selecc_bind=mean(mean(squeeze(Pac.cond(1).data(i,init+range(i).data(1).start:init+range(i).data(1).end,:)),2));
                    selecc_feat=mean(mean(squeeze(Pac.cond(2).data(i,init+range(i).data(1).start:init+range(i).data(1).end,:)),2));

                    Mtemp(u)=abs(selecc_bind)-abs(selecc_feat);

                else

                    Mtemp(u)=0;

                end
                                
            end %for
        
            M(i)=max(Mtemp);
                
        else
            
            M(i)=0;
            
        end
        
   
        
    end

        MMPR=cat(2,MMPR,M);
        clear M
end

%%


for l=1:size(MMR,2)

    if (abs(MMR(l))+abs(MMPR(l)))>0
    
        MM(l)=(abs(MMR(l))-abs(MMPR(l)))/(abs(MMR(l))+abs(MMPR(l))); %Bordó Retention - Verde PostRetention

    else
    
        MM(l)=0;
    end
    
end
%%

NN=zeros(1,size(MM,2));


for k=1:size(MM,2)
   
            if abs(MM(k))<0.25 && abs(MM(k))>0
                
                NN(k)=2;
            
            elseif abs(MM(k))<0.5
                
                NN(k)=3;
                
            elseif abs(MM(k))<0.75
            
                NN(k)=4;
                
            elseif abs(MM(k))<=1
            
                NN(k)=5;
                
            
            else
            
                NN(k)=0;
    
            end
    
            
    if MM(k)>0
        
        if k>67
      
            
            MM(k)=10;  %Binding
           
            
        else
            
            
            MM(k)=7;  %Binding
            
            
        end
        
    elseif MM(k)<0  
        
        
        if k>67
        
            
            MM(k)=1;  %Feature
            
            
        else
            
            
            MM(k)=3;  %Feature
            
            
        end                   
        
    else
        
        MM(k)=0;
        NN(k)=0;
    end
end

MM=MM';
NN=NN';

%%

cd Brain_files

%% Make node file

ifile='P12_P9_modelo.node';
ofile=['nodes/P12_P9_' num2str(offset*1000) 'ms_' tipo '.node'];

nodefile(ifile,ofile,MM',NN');

%%

addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')

conf.test_type={tipo};
% conf.stim_type={fase};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile=['nodes/P12_P9_' num2str(offset*1000) 'ms_' tipo '.node']
conf.configurationMat(1).config=brain_cor;%'CorP9_P12.mat'
conf.configurationMat(2).config=brain_sag;%'SagP9_P12.mat'
conf.configurationMat(3).config=brain_saginv;%'AxiP9_P12.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\FFS_Pow\Figs\'
conf.imageExt='eps'
conf.edgeFile='P9_P12_modelo.edge'

%% Plot Brainimages

outputFileNames{1}=['P12_P9_diff' num2str((offset+l_inf)*1000) 'ms_' tipo '_' freq '_Coronal_'];
outputFileNames{2}=['P12_P9_diff' num2str((offset+l_inf)*1000) 'ms_' tipo '_' freq '_Sagittal_'];
outputFileNames{3}=['P12_P9_diff' num2str((offset+l_inf)*1000) 'ms_' tipo  '_' freq '_Axial_'];
Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,conf.edgeFile,conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
