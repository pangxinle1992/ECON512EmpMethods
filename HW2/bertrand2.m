%This function takes as given v and p, and output FOC and D

function [fval, D]=bertrand2(v,p)

%Get D for any number of products
sum=1; D=ones(length(p),1);
 for i=1:length(p)
     sum=sum+exp(v(i)-p(i));     
 end
 for i=1:length(p)
    D(i)=exp(v(i)-p(i))/sum; 
 end
 
 
 %Evaluate function: 
 ee=ones(length(p),1);
 fval=D-D.*(ee-D).*p;

end
