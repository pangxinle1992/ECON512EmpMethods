%ECON HW1 Xinle Pang

%Add new

diary hw1d.out
%% Question 1

X=[1,1.5,3,4,5,7,9,10];
Y1=-2+0.5*X;
Y2=-2+0.5*X.^2;

figure
plot(X, Y1, 'b', X, Y2, 'r');
title('Y1=-2+0,5*X, Y2=-2+0,5*X^2');
xlabel('X'); ylabel('Y1, Y2');
legend('Y1', 'Y2');

%% Question 2
clear 

X=linspace(-10, 20, 200);
sumX=0;

for i=1:200
   sumX=sumX+X(i); 
end

display(sumX);
%% Question 3
clear

A=[2,4,6;1,7,5;3,12,4];
b=[-2;3;10];

C=A'*b;
D=(A'*A)\b;
E=sum(A,2)'*b;
F=A([1 3], [1 2]);
x=A\b;

display(C); display(D); display(E); display(F); display(x);
%% Question 4
clear

A=[2,4,6;1,7,5;3,12,4];
B=kron(eye(5), A);

display(B);
%% Question 5
clear

m=5;n=3;
A=normrnd(10,5,[m,n]);
AA=zeros(m,n);
for i=1:m
   for j=1:n
       if A(i,j)>=10
           AA(i,j)=1;
       end
   end
end

display(A); display(AA);
%% Question 6
clear
% csvread replaces NaN with zeros, making estimates of coefficients a
% little off
Data=csvread('datahw1.csv');
tb=table(Data(:,3),Data(:,4),Data(:,5),Data(:,6),'VariableNames', {'Export','RD','prod','cap'});
OLS=fitlm(tb,'prod~Export+RD+cap');
display(OLS);

diary off