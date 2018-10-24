function [feval]=dart(x,y)

m=length(x);
feval=zeros(m,m);

for i=1:m
for j=1:m
    if x(i)^2+y(j)^2>1
        feval(i,j)=0;
    else
        feval(i,j)=1;
    end
    
end
end


end