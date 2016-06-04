%%V2 8-5-2016 just to recover t values

function [tt pp]=Main_multi_function_tvals(fase,tipo,freq,w_size,offset, brain_sag,brain_cor,brain_saginv)


%RT
% 

switch fase
    case 'PostRetention_Objects'

        fsampling=200/2; %Hz
        
    case 'Retention'
        
        fsampling=200/1.4; %Hz
        
    case 'PostRetention'

        fsampling=200/2; %Hz
        
    case 'Retention_Objects'
        
        fsampling=200/1.4; %Hz

        
    case 'Decision'
        
        fsampling=200/1.4; %Hz
        
        
    case 'Decision_Objects'
        
        fsampling=200/1.4; %Hz
end

nperm=1000;
alfa=0.01;
l_inf=-200/1000; %s
delta=50/1000;

%

%RT

% fsampling=100; %Hz
% nperm=1000;
% alfa=0.005;
% l_inf=-200/1000; %s
% l_sup=1200/1000; 
% w_size=300/1000; %s
% offset=500/1000; %s 500 1000 (es la ventana real -200)
% delta=20/1000;


%%

Paciente(1).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente12ERPSOutputs__' fase '_' tipo '_' freq '.mat'];
Paciente(2).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente9ERPSOutputs__' fase '_' tipo '_' freq '.mat'];

MM=[];
pp=[];
tt=[];

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

                    pvect(u).values=pvals(i).p(range(i).data(u).start:range(i).data(u).end);
                    tvect(u).values=tvals(i).t(range(i).data(u).start:range(i).data(u).end);
                    
                    ptemp(u)=mean(pvect(u).values);
                    ttemp(u)=mean(tvect(u).values);
                    
                    
                else

                    Mtemp(u)=0;
                    p(i)=0;
                    t(i)=0;
                end
                                
            end %for
        
            [M(i) pos]=max(Mtemp);
            p(i)=ptemp(pos);
            t(i)=ttemp(pos);
        else
            
            M(i)=0;
            p(i)=0;
            t(i)=0;
        end
        
   
        
    end

        MM=cat(2,MM,M);
        pp=cat(2,pp,p);
        tt=cat(2,tt,t);
        clear M
end
%%

NN=zeros(1,size(MM,2));

for k=1:size(MM,2)
  
    
     if pp(k)<0.0001
            
                NN(k)=6;
            
            elseif pp(k)<0.0005
                
                NN(k)=5;
                
            elseif pp(k)<0.001
            
                NN(k)=4;
                
            elseif pp(k)<0.005
            
                NN(k)=3;
            elseif pp(k)<0.01

                NN(k)=2;
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
        NN(k)=0;
        MM(k)=0;
    end
end

MM=MM';
NN=NN';

%%
% 
% cd Brain_files
% 
% %% Make node file
% 
% ifile='P12_P9_modelo.node';
% ofile=['nodes/P12_P9_' num2str(offset*1000) 'ms_' fase '_' tipo '.node'];
% 
% nodefile(ifile,ofile,MM',NN');
% 
% %%
% 
% addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')
% 
% conf.test_type={tipo};
% conf.stim_type={fase};
% 
% conf.surfaceFile='BrainMesh_ICBM152.nv';
% conf.nodeFile=['nodes/P12_P9_' num2str(offset*1000) 'ms_' fase '_' tipo '.node']
% conf.configurationMat(1).config=brain_cor;%'CorP9_P12.mat'
% conf.configurationMat(2).config=brain_sag;%'SagP9_P12.mat'
% conf.configurationMat(3).config=brain_saginv;%'AxiP9_P12.mat';
% conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\FFS_Pow\Figs\'
% conf.imageExt='eps'
% conf.edgeFile='P9_P12_modelo.edge'
% 
% %% Plot Brainimages
% 
% outputFileNames{1}=['P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq '_Coronal_'];
% outputFileNames{2}=['P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq '_Sagittal_'];
% outputFileNames{3}=['P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo  '_' freq '_Axial_'];
% Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,conf.edgeFile,conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);
% 
% %% Make PDF
% % 
% % cd ..
% % close all
% % figure
% % 
% % im=imread(['Figs\P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq '_Coronal_.jpg']);
% % subplot(1,2,1)
% % image(im)
% % set(gca,'xtick',[])
% % set(gca,'xticklabel',[])
% % set(gca,'ytick',[])
% % set(gca,'yticklabel',[])
% % axis off
% % 
% % im=imread(['Figs\P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq '_Sagittal_.jpg']);
% % subplot(1,2,2)
% % image(im)
% % set(gca,'xtick',[])
% % set(gca,'xticklabel',[])
% % set(gca,'ytick',[])
% % set(gca,'yticklabel',[])
% % axis off;
% % 
% % 
% % 
% % im=imread(['Figs\P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq '_Axial_.jpg']);
% % subplot(2,2,3)
% % image(im)
% % set(gca,'xtick',[])
% % set(gca,'xticklabel',[])
% % set(gca,'ytick',[])
% % set(gca,'yticklabel',[])
% % set(gca,'fontsize',36)
% % 
% % text(1500,-2300,['P12-P9 ' num2str((offset+l_inf)*1000) 'ms ' fase ' ' tipo ]);
% % 
% % %%+l_inf
% % 
% % h=gcf;
% % 
% % set(h,'PaperPositionMode', 'auto')
% % set(h,'PaperOrientation','landscape');
% % set(h,'Position',[0 0 1200 800]);
% % print(gcf, '-dpdf', ['Pdf/new/P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq 'w=' num2str(w_size) '.pdf'])
