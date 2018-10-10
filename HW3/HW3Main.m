clear;
load('hw3.mat');

%Formulate likelihood function
yhat=factorial(y);
f=@(beta) sum(exp(X*beta)-y.*(X*beta)+log(yhat));
%Formulate NLS
fun=@(beta) y-exp(X*beta);
fun2=@(beta) (y-exp(X*beta))'*(y-exp(X*beta));

beta0=[1;0;0;0;0;0];
t = zeros(4,1);
beta=zeros(4 ,6);
fval=zeros(4,1);

%% Question 1
tic
[beta1, fval1]=fminsearch(f,beta0,optimset('Display','final','TolFun',1e-16,'TolX',1e-16));
t(1) = toc;
beta(1,:)=beta1;
fval(1)=fval1;


%% Question 2
tic
options = optimoptions('fminunc','Algorithm','quasi-newton',...
          'SpecifyObjectiveGradient',false, 'Display','iter');
[beta2, fval2]= fminunc(f, beta0, options);
t(2) = toc;
beta(2,:)=beta2;
fval(2)=fval2;


%% Question 3
tic
beta3=lsqnonlin(fun,beta0);
t(3)=toc;
beta(3,:)=beta3;
fval(3)=fun2(beta3);

%% Question 4
tic
[beta4, fval4]=fminsearch(fun2,beta0,optimset('Display','final','TolFun',1e-16,'TolX',1e-16));
t(4)=toc;
beta(4,:)=beta4;
fval(4)=fval4;


%% Question 5
% consider the following possible initial values, start with [0;0;0;0;0;0],
% change one of those, for example, [0;0;d;0;0;0], where d ranges from [-1,1]
d=[-1:0.5:1]; 
m=length(d)*length(beta0);
tt=zeros(4, length(beta0), length(d)); ff=zeros(4, length(beta0), length(d));

for i=1:length(beta0)
   for j=1:length(d) 
    b=zeros(length(beta0),1);
    b(i)=d(j);
    [t, fval]=compare(b,X,y); 
    tt(:,i,j)=t; ff(:,i,j)=fval;
   end
end
 
ttt=[tt(:,:,1),tt(:,:,2),tt(:,:,3),tt(:,:,4),tt(:,:,5)];
fff=[ff(:,:,1),ff(:,:,2),ff(:,:,3),ff(:,:,4),ff(:,:,5)];

figure
plot(1:m, ttt(1,:), 1:m, ttt(2,:), 1:m, ttt(3,:), 1:m, ttt(4,:));
xlabel('Initial Value');
ylabel('Time'); 
legend('MLE NM', 'MLE QN', 'NLS', 'NLS NM');

figure
plot(1:m, fff(1,:), 1:m, fff(2,:), 1:m, fff(3,:), 1:m, fff(4,:));
xlabel('Initial Value');
ylabel('Objective'); 
legend('MLE NM', 'MLE QN', 'NLS', 'NLS NM');

