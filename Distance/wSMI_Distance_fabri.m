
%%Make wSMI Matrix

colorPvalue=[0.2 0.2 0.2]
color={'b' 'r' 'c' 'k'}
figure
index=0;

for comp=[comp1 comp2] 
    
    index=index+1;
    
    DATA = eval(['C_' num2str(comp)]);
    

    
    for j=1:size(DATA,2)
        
        DATA_S=reshape(squeeze(DATA(:,j)),126,126);
%         DATA_S(find(P>0.01)) = 0;
        S(j,:,:)=DATA_S;
        
    end
    
    Smean_t=squeeze(mean(S,1));
    
    load('ElectrodeDistanceEGIs126matoids.mat')
    C=triu(D);
    Smean=triu(Smean_t);
    max_d=ceil(max(max(C)));
    
    for i=1:max_d
        
        [z(i).a]=find(D<i&D>i-1);
        Vect(i).data=Smean(z(i).a);
        Vect(i).data(find(Vect(i).data==0))=[];
        vect(i)=mean(Vect(i).data);
%         maxx(index)=max(vect(i));
%         minn(index)=min(vect(i));
        mat(i).cond(index).data=Vect(i).data;
    end
    
    timesout=1:1:size(mat,2);
    maxx(index)=max(vect);
    minn(index)=min(vect);

    h=plot(timesout,vect,cell2mat(color(comp)));
    hold on;

end

for ti=1:size(mat,2)
%    
    Permut{1}=mat(ti).cond(1).data;                         % transforma las variables en cellarray
    Permut{2}=mat(ti).cond(2).data;
% 
%     [H,Pv(ti),CI,STATS] = ttest(Permut{1},Permut{2}); % Variables a comparar

    [t df pvals(ti)] = statcond(Permut, 'mode', 'perm','paired','off','tail','both','naccu',500);   %calcula permutaciones
    
end

% pvals=Pv;
p_value=0.01;

[y i_ind]=find(pvals<p_value);
timesout=1:1:size(mat,2);

if ~isempty(i_ind)
   
    max_cond = max(maxx);
    plot(timesout(i_ind),max_cond*1.1,'*', 'Color',colorPvalue, 'MarkerSize', 3)

    min_cond=min(minn);
    ylim([min_cond*1.5 max_cond*1.2])
    xlim([1 size(mat,2)])

end

title(['wSMI vs distance -  Stage ' tipo ' - Conditions: ' cell2mat(conds1(comp1)) 'vs' cell2mat(conds1(comp2)) ' Tau ' num2str(tau)])
saveas(gcf, ['Figs/' tipo '' cell2mat(conds1(comp1)) 'vs' cell2mat(conds1(comp2)) ' Tau ' num2str(tau)],'png') 