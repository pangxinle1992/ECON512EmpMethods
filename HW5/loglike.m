function lv = loglike(gamma, X, Y, Z, beta, u, weight)

%This function calculates the log-likelihood given gamma, data, and
%different ways of numerical integration
%X, Y, Z are from the data
%randv contains random variables drawn for integration (beta and u), and weight give
%different weights for integration


[T, N]=size(Y);
nbeta = length(beta); nu = length(u);
l=ones(N,1); %each individual's log-likelihood


for i=1:N
    %fix each invidiual
    ll=ones(nbeta, nu);
        for m=1:nbeta
           for n=1:nu
               for j=1:T
              ll(m,n)= ll(m,n)*exp(Y(j, i) * (beta(m) * X(j, i) + gamma * Z(j, i)+ u(n)))/(1 + exp(beta(m) * X(j, i) + gamma * Z (j, i) + u(n)));   
               end
           end
        end 
     l(i)=sum(sum(ll.*weight)); %numerical integration   

end
    
    lv=sum(log(l));
   
end


   