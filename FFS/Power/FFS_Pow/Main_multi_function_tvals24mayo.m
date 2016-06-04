%%V2 24-5-2016 


function [tt pp]=Main_multi_function_tvals24mayo(fase,tipo,freq,w_size,offset, brain_sag,brain_cor,brain_saginv)



c_p9=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente9\canales_p9.mat');
c_p12=load('D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\Paciente12\canales_p12.mat');
canales=[c_p12.canal c_p9.canal];


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
alfa=0.05;
l_inf=-200/1000-125/1000; % (125 is for FFT method correction)
delta=10/1000;

%%

Paciente(1).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente12ERPSOutputs__' fase '_' tipo '_' freq '.mat'];
Paciente(2).path=['D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\Mats\Paciente9ERPSOutputs__' fase '_' tipo '_' freq '.mat'];

MM=[];
pp=[];
tt=[];

for pac=1:2
    
    Pac=load(Paciente(pac).path);
      
    
    init=l_inf*fsampling+ceil(((offset-w_size/2))*fsampling);
    endi=l_inf*fsampling+ceil(((offset+w_size/2))*fsampling);
    
    tam=size(Pac.cond(1).data,2);
    tiempo=1:1:tam;
%     tiempo=tiempo-40;

    
    for i=1:size(Pac.cond(1).data)
        
        DATA={squeeze(Pac.cond(1).data(i,init:endi,:)),squeeze(Pac.cond(2).data(i,init:endi,:))};
        [tf dff pvalsf] = statcond(DATA,'mode','boot','paired','on','naccu', nperm);
        range(i).data=p_finder(pvalsf,alfa,delta*fsampling);
        pvals(i).p=pvalsf;
        tvals(i).t=tf;
       
       
        if ~isempty(range(i).data)
            
            for u=1:max(size(range(i).data))
               
                
                if range(i).data(u).detect==1

                    pvect(u).values=pvals(i).p(range(i).data(u).start:range(i).data(u).end);
                    ptemp(u)=mean(pvect(u).values);
                   
                    tvect(u).values=tvals(i).t(range(i).data(u).start:range(i).data(u).end);
                    ttemp(u)=mean(tvect(u).values);
        
%                     
%         if pac==2
%             tiempo2=1:1:size(mean(squeeze(Pac.cond(1).data(i,init:endi,:)),2),1);
%             figure
%             plot(tiempo2,mean(squeeze(Pac.cond(1).data(i,init:endi,:)),2))
%             hold on
%             plot(tiempo2,mean(squeeze(Pac.cond(2).data(i,init:endi,:)),2),'r')
%             ylim([0 5])
%             
%             figure
%             plot(tiempo,mean(squeeze(Pac.cond(1).data(i,:,:)),2))
%             hold on
%             plot(tiempo,mean(squeeze(Pac.cond(2).data(i,:,:)),2),'r')
%             hold on
%             line([((offset-w_size/2)+l_inf)*fsampling ((offset+w_size/2)+l_inf)*fsampling],[4 4])
%             ylim([0 5])
%             
%          end
%                     
                    Mtemp(u)=sign(ttemp(u));
                
                else

                    Mtemp(u)=NaN;
                    ptemp(u)=NaN;
                    ttemp(u)=NaN;
                
                end
                                                
            end %for
        
           if ~isempty(find(isnan(Mtemp)))
            
               ptemp(find(isnan(Mtemp)))=[];
               ttemp(find(isnan(Mtemp)))=[];
               Mtemp(find(isnan(Mtemp)))=[];
             
           end
           
           if ~isempty(Mtemp)
           
               [p(i) pos]=min(ptemp);
               t(i)=max(ttemp);
               M(i)=Mtemp(pos);
           
           else
               
               M(i)=0;
               p(i)=1000;
               t(i)=0;
               
           end
                      
        else
            
            M(i)=0;
            p(i)=1000;
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

maximum=max(MM);
minimum=min(MM);

indice=1;

for k=1:size(MM,2)
   
            if pp(k)<0.0001
            
                NN(k)=12;
                table(indice).name=canales(k);
                table(indice).t=tt(k);
                table(indice).p=pp(k);
                indice=indice+1;
                
            elseif pp(k)<0.0005
                
                NN(k)=10;
                table(indice).name=canales(k);
                table(indice).t=tt(k);
                table(indice).p=pp(k);
                indice=indice+1;

            elseif pp(k)<0.001
            
                NN(k)=8;
                table(indice).name=canales(k);
                table(indice).t=tt(k);
                table(indice).p=pp(k);
                indice=indice+1;
                
            elseif pp(k)<0.005
            
                NN(k)=6;
                table(indice).name=canales(k);
                table(indice).t=tt(k);
                table(indice).p=pp(k);
                indice=indice+1;
                
            elseif pp(k)<0.01

                NN(k)=4;
                table(indice).name=canales(k);
                table(indice).t=tt(k);
                table(indice).p=pp(k);
                indice=indice+1;
                
             elseif pp(k)<0.05

                NN(k)=2;
                table(indice).name=canales(k);
                table(indice).t=tt(k);
                table(indice).p=pp(k);
                indice=indice+1;

            else
                NN(k)=0;
                
    end
    
    if MM(k)>0
        
        if k>67
      
            
            MM(k)=10;  %Faces
           
            
        else
            
            
            MM(k)=7;  %Faces
            
            
        end
        
    elseif MM(k)<0  
        
        
        if k>67
        
            
            MM(k)=1;  %Objects
            
            
        else
            
            
            MM(k)=3;  %Objects
            
            
        end                   
        
    else
        
        MM(k)=5;
        NN(k)=1;
    end
end

MM=MM';
NN=NN';

%%

cd Brain_files

%% Make node file

ifile='P12_P9_modelo.node';
ofile=['nodes/P12_P9_' num2str(offset*1000) 'ms_' fase '_' tipo '.node'];

nodefile(ifile,ofile,MM',NN');

%%

addpath('D:\_INECO\Procesamiento\Toolbox\BrainNetViewer_20150206\')

conf.test_type={tipo};
conf.stim_type={fase};

conf.surfaceFile='BrainMesh_ICBM152.nv';
conf.nodeFile=['nodes/P12_P9_' num2str(offset*1000) 'ms_' fase '_' tipo '.node']
conf.configurationMat(1).config=brain_cor;%'CorP9_P12.mat'
conf.configurationMat(2).config=brain_sag;%'SagP9_P12.mat'
conf.configurationMat(3).config=brain_saginv;%'AxiP9_P12.mat';
conf.baseFileName='D:\_INECO\Procesamiento\iEEG_Toolbox\Produccion\Scripts_pre-analisis\Integracion\FFS\Power\FFS_Pow\Figs\'
conf.imageExt='eps'
conf.edgeFile='P9_P12_modelo.edge'

%% Plot Brainimages

outputFileNames{1}=['debugP12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq '_Coronal_' date];
outputFileNames{2}=['debugP12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo '_' freq '_Sagittal_' date];
outputFileNames{3}=['debugP12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase '_' tipo  '_' freq '_Axial_' date];
Plot3DBrainNetViewer(conf.surfaceFile,conf.nodeFile,conf.edgeFile,conf.configurationMat,conf.baseFileName,outputFileNames,conf.imageExt);




%%

fid=fopen(['P12_P9_' num2str((offset+l_inf)*1000) 'ms_' fase  '_' tipo '_' freq '.txt'],'w')


for h=1:size(table,2)
    
    a=table(h).name.nombre;
    b=table(h).p;
    c=table(h).t;

    fprintf(fid,'%s %f  %f\n',a,b,c);

end

fclose(fid);






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
