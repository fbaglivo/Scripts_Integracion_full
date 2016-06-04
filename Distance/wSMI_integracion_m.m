%% wSMI para Intero

%% Parámetros
clear,clc,close all


tau=1;
comp1 = 3;
comp2 = 4;
tipo='Decision';


salvar=1; % 0-No salvar / 1-Si salvar los gráficos
direc = 'D:\_INECO\Pacientes_Integracion\Results\';
cd(direc)


%% Levanta los Datos >> 
 
disp(['Tau Número: ', num2str(tau)])
%disp(['Condición: ', num2str(condicion)])
disp(['Save: ', num2str(salvar)])

color1 = [1 0 0]; %Rojo, T Negativos
color2 = [0 0 1]; %Azul, T Positivos

%cd I:\Eze\AnalisisEEG\Alzheimer_colombia


% Define Grupos y Condiciones
%grupo = {'MP_ALZ_C','MP_ALZ_P'};
%G = {'c','p'};

conds1 = {'1OBA_m','2OFA_m','3FBA_m', '4FFA_m'};
%cd(fullfile(direc,'data','dat'))

for pp = 1 % Grupos: 1-Control 2-Paciente

          for cond = 1:4 % Elegir Condiciones
  
              fileout= fullfile(direc,'SMIN', [tipo '_'  conds1{cond} '_CSD.mat']);
              
              load(fileout); aux = wSMI.Trials{tau};
              
              aux2 = nan(126);
              
              C1 = [];C2 =[];C3 = [];C4 =[];
              
              
              
              for tr =1:size(aux,2)
                  
                  TEMP = aux(:,tr);
                  n = 0;
                  for i = 1:126
                      for j = (i+1):126
                          n = n + 1;
                          aux2(i,j) = TEMP(n);
                          aux2(j,i) = TEMP(n);
                      end
                  end
                  
                  MM(tr,cond).data=aux2;
                                    
              end
              
              
              
    end
    
end


%% Separa por Condición

C_1 = [];
C_2 = [];
C_3 = [];
C_4 = [];

for suj=1:size(MM,1)
    
        temp = MM(suj,1).data;    % controles cond 1   
        C_1 = [C_1,reshape(temp,size(temp,1)*size(temp,1),size(temp,3))];
        
        temp = MM(suj,2).data;    % controles cond 2   
        C_2 = [C_2,reshape(temp,size(temp,1)*size(temp,1),size(temp,3))];

        temp = MM(suj,3).data;    %    
        C_3 = [C_3,reshape(temp,size(temp,1)*size(temp,1),size(temp,3))];

        temp = MM(suj,4).data;    %    
        C_4 = [C_4,reshape(temp,size(temp,1)*size(temp,1),size(temp,3))];




end

C_1(isnan(C_1)) =0;
C_2(isnan(C_2)) =0;
C_3(isnan(C_3)) =0;
C_4(isnan(C_4)) =0;


%% Prepara las Comparaciones >> Elegir Condición  

close all
cd(direc) 

c = eval(['C_' num2str(comp1)]); % Primer bloque a comparar
p = eval(['C_' num2str(comp2)]); % Segundo bloque a comparar


%% T Test  

% cd(direc) 
cd D:\_INECO\Procesamiento\EEG\Distance\
% p_value=0.05; %Valor de la p

[H,P,CI,STATS] = ttest(c',p'); % Variables a comparar
T = reshape(STATS.tstat,126,126);
P = reshape(P,126,126);

Tor=T;

wSMI_Distance_fabri