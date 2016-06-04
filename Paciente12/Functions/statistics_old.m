


DATA={cond(1).data,cond(2).data,cond(1).data};
[t df pvals] = statcond(DATA,'mode','perm','paired','off','naccu', 100);