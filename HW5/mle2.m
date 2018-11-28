function lv = mle2(gamma, beta0, u0, sigb0, sigu0, sigbu0, X,Y,Z)


rng(1234567);
sigma0=[sigb0, sigbu0; sigbu0, sigu0];
U=chol(sigma0);
mu0=[beta0;u0];

randv=randn(2,100);
biNorm=repmat(mu0,1,100)+U'*randv;
beta=biNorm(1,:); u=biNorm(2,:);
weight=1/100*ones(100,1);

lv=-loglike(gamma,X,Y,Z,beta,u,weight);

end