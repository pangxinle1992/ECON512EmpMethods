clear;

%% load parameters
parameters;

%% Part 1 Calculate the value and price policy
%intialize value function and pricing function

p0=7*ones(L,L);
V0=zeros(L,L);

[V, p, iter] = valueiter(V0, p0);

% did not converge to the equilibrium. 

figure(1);
mesh(V);
title('Value Function');

figure(2);
mesh(p);
title('Policy Function');


%% Part 2 Calculate the state transition 
%use the information of the state transition, and the endogenous pricing
%function
%construct demand probability given price function p
[c2,c1]=meshgrid(c,c);
p1=p; p2=p';
D1=exp(nu-p)./(1+exp(nu-p2)+exp(nu-p));
D2=exp(nu-p2)./(1+exp(nu-p2)+exp(nu-p));
D0=1-D1-D2;
%reshape matrix
DD1=reshape(D1,[L*L,1]); DD1=repmat(DD1,1,L*L);
DD2=reshape(D2,[L*L,1]); DD2=repmat(DD2,1,L*L);
DD0=reshape(D0,[L*L,1]); DD0=repmat(DD0,1,L*L);

%state transition matrix from (w1,w2) to (w1',w2')
trans=DD0.*prob00+DD1.*prob10+DD2.*prob01;
checktrans=sum(sum(trans,2)); %check probability sum to 1

%distribution of states from (1,1)
T=30;
PP=zeros(L*L,L*L,T); PP(:,:,1)=trans;
for i=2:T
    PP(:,:, i)=PP(:,:,i-1)*trans;
end

dis10=PP(1,:,10);dis20=PP(1,:,20);dis30=PP(1,:,30);
histogram(dis10, 50);histogram(dis20, 50);histogram(dis30, 50);

%stationary distribution
iter=10000; tol=1e-10; SP=trans;
for i=1:iter
    SPnew=SP*trans;
%check convergence
checkconvergence=max(max(abs((SPnew-SP)./SP)));
if checkconvergence<tol
    disp('distribution converges');
    break
else
    %disp(['current dist iteration =' num2str(i) 'gap =' num2str(checkconvergence)]);
    SP=SPnew;
end
end
%start from (1,1), stationary distribution is
histogram(SP(1,:), 50);