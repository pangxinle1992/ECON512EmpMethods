%HW 4
addpath('/study/project/ECON512EmpMethods/HW4/CEtools');
%% Question 1
clear;
n=10000; %number of draws
[h, w] = qnwequi(n, [0 0], [1, 1], 'N');
test=h(:,1).^2 + h(:,2) .^ 2 <= 1; 
pie=4*sum(test)/n;

%% Question 2
clear;
n=10000;
x=0:1/n:1; y=0:1/n:1; z=4*dart(x,y);
% I am not sute this is the right implementation of the NC
%use equal weights
w=2*ones(length(x),1);w(1)=1;w(end)=1;w=w*(1/(2*n));
pie=w'*z*w;

%% Question 3
clear;
n=10000; %number of draws
[h, w] = qnwequi(n, 0, 1, 'N');
hh=sqrt(1-h.^2);
pie=4*sum(hh)/n;

%% Question 4
clear;
n=10000;
x=0:1/n:1; z=4*sqrt(1-x.^2);
%use equal weights
w=2*ones(length(x),1);w(1)=1;w(end)=1;w=w*(1/(2*n));
pie=z*w;

%% Question 5
clear;
max=200;
number=[100;1000;10000];

%quasi-MC
MSEQ=ones(3,1);
for i=1:3
    pieq=ones(max,1);
for s=1:max
    [h, w] = qnwequi(number(i), 0, 1, 'N');
    hh=sqrt(1-h.^2);
    pieq(s)=4*sum(hh)/number(i); 
end
MSEQ(i)=sum((pieq-pi).^2)/number(i);
end

%NC
MSENC=ones(3,1);
for i=1:3
    pienc=ones(max,1);
    x=0:1/number(i):1; z=4*sqrt(1-x.^2);
    w=2*ones(length(x),1);w(1)=1;w(end)=1;w=w*(1/(2*number(i)));
    pienc=z*w;
MSENC(i)=sum((pienc-pi).^2)/number(i);
end

%pseudo-MC integration
MSEPC=ones(3,1);
seed = 1234567;
rng(seed); 
for i=1:3
    piepc=ones(max,1);
for s=1:max
    h=rand(number(i),1);
    hh=sqrt(1-h.^2);
    piepc(s)=4*sum(hh)/number(i); 
end
MSEPC(i)=sum((piepc-pi).^2)/number(i);
end
