clear;clc
load data2016
D=score;
[n p]=size(D);
B=zeros(n,p);
for th=150%1:40
tic;t1=clock;
for i=1:n
    for j=1:p
        tic;t2=clock;
    D(i,j)=0;
    Omega=find(D~=0);
    [m l]=size(Omega);
    data=D(Omega);delta=((n*p)/m)*1.2;
    tau = th*n;
    maxiter = 500;
    tol = 1e-4;
    [U,S,V,numiter] = SVT([n p],Omega,data,tau,delta,maxiter,tol); 
    predict = U*S*V';
    B(i,j)=score(i,j)-predict(i,j);
    D=score;
    end
end
error(th)=sum(sum(abs(B)))/(n*p);
end
disp(['etime:',num2str(etime(clock,t1))]);
%save lowrank2015_40 error