addpath('/study/project/ECON512EmpMethods/HW5/CEtools');
load('hw5.mat')
X=data.X;Y=data.Y;Z=data.Z;

%% Question 1
[beta, weight] = qnwnorm(20, 0.1, 1); 
u=0; 
gamma=0;
l1=loglike(gamma,X,Y,Z,beta,u,weight);

%% Question 2
rng(1234567);
beta = normrnd(0.1,1,[100,1]);
u=0;
gamma=0;
weight=1/100*ones(100,1);
l2=loglike(gamma,X,Y,Z,beta,u,weight);

%% Question 3

fGQ = @(para) mle(para(1), para(2), para(3), 0, X,Y,Z);
para0 = [1, 1, 1];
[paraGQ, loglikeGQ] = fminsearch(fGQ, para0);
% you have been told to use fmincon, it allows to use only one function
% with constraint impoised to your liking

fMC = @(para) mle(para(1), para(2), para(3), 1, X,Y,Z);
para0 = [1, 1, 1];
[paraMC, loglikeMC] = fminsearch(fMC, para0);


%% Question 4

fMC2 = @(para) mle2(para(1), para(2), para(3),para(4), para(5), para(6),X,Y,Z);
para0 = [1, 1, 1,1,1,0];
[paraMC2, loglikeMC2] = fminsearch(fMC2, para0);
% again, you should have used fmincon
% also, something takes very nolg time in this function calculation. did
% you try to profile it?