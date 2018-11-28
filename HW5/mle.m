function lv = mle(gamma, beta0, sigma0, method, X,Y,Z)

if method == 0
[beta, weight] = qnwnorm(20, beta0, sigma0);
u=0;
lv= -loglike(gamma, X,Y,Z,beta,u,weight);
    
else
rng(1234567);  
beta = normrnd(beta0, sigma0, [100, 1]);
weight = 1 / 100 *ones(100,1);
u=0;
lv = - loglike(gamma, X,Y,Z,beta,u,weight);
    
end

end