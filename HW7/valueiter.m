function [V,p,iter] = valueiter(V0, p0)

global L
V = V0;
p = p0;


check = 1;
iter = 0;
tol=1e-10;
lambda=1;


while check > tol
    
   [W0,W1,W2]=calW(V);
   
   pnew=calP(p, W0, W1, W2);
   
   positive=L*L-sum(sum(pnew>0));
   
   if positive==0
   
   Vnew=calV(pnew,p,W0,W1,W2);
   check = max( max(max(abs((Vnew-V)./(1+Vnew)))),  max(max(abs((pnew-p)./(1+pnew)))));
   
        V = lambda * Vnew + (1-lambda)*V;
        
        p = lambda * pnew + (1-lambda)*p;
        disp(['current iteration is =' num2str(iter) 'the gap is =' num2str(check)]);
        iter = iter+1;
        
   else
       disp('negative prices');
   break

  end
   
end