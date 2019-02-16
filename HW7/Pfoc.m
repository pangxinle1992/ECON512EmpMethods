function z=Pfoc(pnew,p,W0,W1,W2)

global nu beta c;

%%pnew is the updated pricing stragegy for firm 1; while p is the one from

%%last iteration
 
p2=p'; %L*L matrix that's the given p(-n)(w1,w2);

[c2,c1]=meshgrid(c,c);

D1=exp(nu-pnew)./(1+exp(nu-p2)+exp(nu-pnew));
D2=exp(nu-p2)./(1+exp(nu-p2)+exp(nu-pnew));
D0=1-D1-D2;

%residuals of FOC
z=1-(1-D1).*(pnew-c1)-beta.*W1+beta.*(D0.*W0+D1.*W1+D2.*W2);



end