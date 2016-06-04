
load('P9_electrode_loc.mat')

%%
X=P9_electrode_loc(:,1);
Y=P9_electrode_loc(:,2);
Z=P9_electrode_loc(:,3);


for i=1:size(X,1)
    for j=(i+1):size(X,1)
   
        D(i,j)=sqrt((X(j)-X(i)).^2+(Y(j)-Y(i)).^2+(Z(j)-Z(i)).^2);
        D(j,i)=sqrt((X(j)-X(i)).^2+(Y(j)-Y(i)).^2+(Z(j)-Z(i)).^2);
    end
    
end
    