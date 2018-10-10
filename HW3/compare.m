function [t, fval]=compare(b,X,y)


yhat=factorial(y);
f=@(beta) sum(exp(X*beta)-y.*(X*beta)+log(yhat));
fun=@(beta) y-exp(X*beta);
fun2=@(beta) (y-exp(X*beta))'*(y-exp(X*beta));

t = zeros(4,1);
beta=zeros(4,6);
fval=zeros(4,1);


tic
[beta1, fval1]=fminsearch(f,b,optimset('Display','final','TolFun',1e-16,'TolX',1e-16));
t(1) = toc;
beta(1,:)=beta1;
fval(1)=fval1;


tic
options = optimoptions('fminunc','Algorithm','quasi-newton',...
          'SpecifyObjectiveGradient',false, 'Display','iter');
[beta2, fval2]= fminunc(f, b, options);
t(2) = toc;
beta(2,:)=beta2;
fval(2)=fval2;


tic
beta3=lsqnonlin(fun,b);
t(3)=toc;
beta(3,:)=beta3;
fval(3)=fun2(beta3);


tic
[beta4, fval4]=fminsearch(fun2,b,optimset('Display','final','TolFun',1e-16,'TolX',1e-16));
t(4)=toc;
beta(4,:)=beta4;
fval(4)=fval4;


end