clear;

global L l rho eta kappa nu delta beta c prob00 prob10 prob01

L=30; l=15;
rho=0.85; eta=log(rho)/log(2);
kappa=10;
nu=10;
delta=0.03;
beta=1/1.05;

%%cost function
c=ones(L,1);
c(1:l)=kappa*[1:l]'.^eta;
c(l+1: L)=kappa*ones(L-l,1)*l.^eta;

%%probability transition
prob0=zeros(L,L);
prob0(1,1)=1;
for i=2:L
    prob0(i,i-1)=1-(1-delta)^i; prob0(i,i)=(1-delta)^i;
end


prob1=zeros(L,L);
prob1(L,L)=1;
for i=1:L-1
    prob1(i,i)=1-(1-delta)^i; prob1(i,i+1)=(1-delta)^i;
end

prob00=kron(prob0, prob0);
prob10=kron(prob0, prob1);
prob01=kron(prob1, prob0);


