%%this function calculate update pricing strategy given last iteration's
%%price strategy

function pnew=calP(p, W0, W1, W2)

global kappa L

%solve the new p1 given old p1=p
f=@(pnew) Pfoc(pnew,p,W0,W1,W2);

pini=kappa*ones(L,L);

pnew=fsolve(f,pini);


end
