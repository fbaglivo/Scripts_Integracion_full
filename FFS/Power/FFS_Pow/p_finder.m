function range=p_finder(pvect,pval,delta)


 %% Debug
% pvect=ones(1,100)';
% pvect(2:3)=0.005;
% pvect(7:10)=0.005;
% pvect(50:70)=0.005;
% % pvect(50:70)=0.005;
% 
% delta=2;
% pval=0.01;

%%
ind=[];
ind=find(pvect<pval);
diff=ind(2:end)-ind(1:end-1);


if ~isempty(ind) && max(size(diff))>1

    start=1;
    dindex=1;
    rindex=1;
    found=0;
    iindex=1;


    while start == 1
        
        if iindex>max(size(ind))
            break;
        end

        range(rindex).start=ind(iindex)
        range(rindex).detect=0;
        
        while diff(dindex)==1   

            dindex=dindex+1;
            iindex=iindex+1;
            found=1;    

            if dindex>max(size(diff)) || iindex>max(size(ind))
                iindex=max(size(ind));
                break;
            end

        end

        if found ==1

            if ind(iindex)-range(rindex).start>delta

                range(rindex).end=ind(dindex);
                range(rindex).detect=1;
                rindex=rindex+1;
                iindex=iindex+1;
                
            
            else

                dindex=dindex+1;
                iindex=iindex+1;
            
            end
            
            found=0;

        else

            dindex=dindex+1;
            iindex=iindex+1;

        end

        if dindex>= max(size(diff)) 
            
            start=0;

        end

    end
    
else
    
    range=[];
end

l=1;

while l<=max(size(range)) && max(size(range))>1 
   
    if range(l).detect==0
       
        range(l)=[];
    
    else
        
        l=l+1;
    
    end
   
    
end