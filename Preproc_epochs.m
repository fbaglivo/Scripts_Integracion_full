%  El objetivo del preprocesamiento es: detectar canales defectuosos,
%  eliminarlos y realizar la re referenciacion a la media de los canales
%  El algoritmo asume que el registro ya fué segmentado por una etapa
%  previa
%  Los criterios utilizados para eliminar canales son los siguiente:
%
%  1. Canales que tengan valores de la varianza 5 veces por encima  o 5     
%     veces por debajo de la mediana de la varianza
%     Este método devuelve aquellos canales que hay
%     que agregar a la estructura de la info del sujeto
%
%  2. Canales con artefactos. Devuelve un gráfico con la cantidad de
%  artefactos por canal. En tal caso hay que o descartar directo o plotear
%  el canal
%
%
% Baglivo 2014 - Version 1.0  
%%

close all
clear all
clc

file='Paciente9_TMaze_epochs.mat'

load(file)
%%


for i=1%:size(epochs,2)
   
    data = epochs(i).data;


% Verifico que no haya epochs con artefactos

    for y=1:size(data,1) % Canales

        for z=1:size(data,3) %Epochs

            artif=find(abs(squeeze(data(y,:,z)))>500);
            cant_artifact(y,z)=size(artif,2);
            
            a=var(data(y,:,z));
            b=find(a>(5*median(a)));
            c=find(a<(median(a)/5));
            
            if ~isempty([b c cant_artifact])

                disp(['Epoch con artefacto: Canal ' num2str(y) ' Epochs:' num2str(z) ])
           
            end

           
            
            clear artif;
            
        end
        
    end
    
end
%%