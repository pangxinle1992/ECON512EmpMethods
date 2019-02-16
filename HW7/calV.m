function Vnew=calV(pnew,p,W0,W1,W2)

global nu beta c;

p2=p'; %L*L matrix that's the given p(-n)(w1,w2);
p1=pnew;

[c2,c1]=meshgrid(c,c);

D1=exp(nu-p1)./(1+exp(nu-p2)+exp(nu-p1));
D2=exp(nu-p2)./(1+exp(nu-p2)+exp(nu-p1));
D0=1-D1-D2;

%update the value function
Vnew=D1.*(p1-c1)+beta.*(D0.*W0+D1.*W1+D2.*W2);


end