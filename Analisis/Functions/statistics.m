

tam=size(cond,2);

switch tam

    
    case 3

    DATA={gcond(1).data,gcond(2).data,gcond(3).data};
    [t df pvals] = statcond(DATA,'mode','perm','paired','on','naccu', 500);
    
    case 2
        
        DATA={gcond(1).data,gcond(2).data};
        [t df pvals] = statcond(DATA,'mode','perm','paired','on','naccu', 1000);
    
    
    case 4
        
        DATA={gcond(1).data,gcond(2).data,gcond(3).data,gcond(4).data};
        [t df pvals] = statcond(DATA,'mode','perm','paired','on','naccu', 100);
    
end