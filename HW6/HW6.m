%Stochastic Tree Cutting Problem


clear

%parameters
delta=0.95;
c1=0.2;c2=1.5;
p0=0.5;rho=0.5;sigma=0.1;


%state space
%discretize the productivity space
np=21;
[pi,p]=tauchen(np,p0,rho,sigma); %prob is for each row current state
%state space for the remaining tree
wlow=0; whigh=100; N=100;
step=(whigh-wlow)/N;
w=wlow:step:whigh;
nw=length(w);



%value function iteration 
%for each w today, create a matrix, choose w' under different p, profit
%matrix u(w',p,w)
u=ones(nw,np,nw); c=zeros(nw,np);
for i=1:nw
    wd=w(i)-repmat(w',1,np); neg=find(wd<0); wd(neg)=0;
    c=c1*wd.^c2; c(neg)=1e6;
   u(:,:,i)=repmat(p,nw,1).*repmat(-w'+w(i),1,np)-c;    
end

%value function iteration
v=zeros(nw,np); V=zeros(nw,np);%used to update
dec=zeros(nw,np);wt=zeros(nw,np);

iter=500; tol=1e-10;

for j=1:iter
        Ev=v*pi'; %calculate expected value
    for i=1:nw
        [V(i,:), dec(i,:)]=max(u(:,:,i)+delta*Ev);
    end
    if max(abs(V-v))<tol
      disp('convergence achieved'); 
      break 
    else
      v=V;
    end
end
%policy
wt=w(dec);


%% Question 3 plot the value function
p1=find(p<=0.9, 1, 'last');p2=find(p<=1, 1, 'last');p3=find(p<=1.1, 1,'last')+1;
figure(1)
plot(1:nw, v(:,p1), 'b', 1:nw, v(:,p2), 'r', 1:nw, v(:,p3), 'g');
ylabel('Value function'); xlabel('Initial endowment');
legend('p=0.8961','p=1','p=1.1039');

%% Question 4 plot the policy function
w1=find(w<=10, 1, 'last');w2=find(w<=40, 1, 'last');w3=find(w<=80, 1,'last');
figure(2)
plot(1:np, wt(w1,:), 'b', 1:np, wt(w2,:), 'r', 1:np, wt(w3,:), 'g');
ylabel('Policy function'); xlabel('Prices');
legend('w=10','w=40','w=80');

%% Question 5 given w=100, p=1
%transition matrix (w,p) to (w',p')

P=zeros(np*nw,np*nw);
for i=1:np
    for j=1:np
        P((i-1)*nw+1:i*nw,(j-1)*nw+1:j*nw)=pi(i,j)*(repmat(wt(:,i),1,nw)==repmat(w,nw,1));      
    end
end

%calculate expected capital
T=20;
expw=zeros(T,1); expw(1)=100; fivw=zeros(T,1); fivw(1)=100; ninfivw=zeros(T,1); ninfivw(1)=100;
pinit=zeros(1,np*nw); pinit(1,nw*p2)=1;
for t=2:T
   p=pinit*P; 
   probw=zeros(nw,np);
   for i=1:np
     probw(:,i)=p((i-1)*nw+1:i*nw)';
   end
   distw=sum(probw');
   expw(t)=w*distw'; %%mean
   
   cumw=cumsum(distw); 
   fivper=find(cumw<=0.05, 1, 'last'); ninfivper=find(cumw<=0.95, 1, 'last');
   fivw(t)=w(fivper); ninfivw(t)=w(ninfivper);
   pinit=p;
end


figure(3)
plot(1:T, expw, 'b', 1:T, fivw, 'r', 1:T, ninfivw, 'g');
ylabel('Expected capital, 90 percent CI'); xlabel('Time');


%% Question 6 redo 2-4 for coarse grid of 5 points

np=5;
[pi,p]=tauchen(np,p0,rho,sigma); 

u=ones(nw,np,nw); c=zeros(nw,np);
for i=1:nw
    wd=w(i)-repmat(w',1,np); neg=find(wd<0); wd(neg)=0;
    c=c1*wd.^c2; c(neg)=1e6;
   u(:,:,i)=repmat(p,nw,1).*repmat(-w'+w(i),1,np)-c;    
end

v=zeros(nw,np); V=zeros(nw,np);
dec=zeros(nw,np);wt=zeros(nw,np);

iter=500; tol=1e-10;

for j=1:iter
        Ev=v*pi'; 
    for i=1:nw
        [V(i,:), dec(i,:)]=max(u(:,:,i)+delta*Ev);
    end
    if max(abs(V-v))<tol
      disp('convergence achieved'); 
      break 
    else
      v=V;
    end
end
wt=w(dec);


p1=find(p<=0.9, 1, 'last');p2=find(p<=1, 1, 'last');p3=find(p<=1.1, 1,'last')+1;
figure(4)
plot(1:nw, v(:,p1), 'b', 1:nw, v(:,p2), 'r', 1:nw, v(:,p3), 'g');
ylabel('Value function'); xlabel('Initial endowment');
legend('p=0.8268','p=1','p=1.1732');

w1=find(w<=10, 1, 'last');w2=find(w<=40, 1, 'last');w3=find(w<=80, 1,'last');
figure(5)
plot(1:np, wt(w1,:), 'b', 1:np, wt(w2,:), 'r', 1:np, wt(w3,:), 'g');
ylabel('Policy function'); xlabel('Prices');
legend('w=10','w=40','w=80');



