%ECON HW1 Xinle Pang
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
   sumX=sumX+X(i); %sum x element by element
end

%% Question 3
clear

A=[2,4,6;1,7,5;3,12,4];
b=[-2;3;10];

C=A'*b;
D=(A'*A)\b;
E=sum(A,2)'*b;
F=A([1 3], [1 2]);
x=A\b;