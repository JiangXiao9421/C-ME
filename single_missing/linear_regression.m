clear;clc;
load data2015
[n,p]=size(score);
t1=clock;
for i=1:n
    for j=1:p
        D=score;         
        D(i,j)=0;
        D(i,j)=(sum(score(:,j)))/(n-1);
        Ddiff=D(:,setdiff(1:p,j)); %remove the missing subject.
        Y=D(:,j);
        X=[ones(length(Y),1),Ddiff];
        [b,bint,r,rint,stats]=regress(Y,X); %least square method.
        b0=b(1,1); %constant term.
        b=b(2:end,1); %coefficient.
        predict(i,j)=sum(b'.*Ddiff(i,:))+b0;
        E(i,j)=abs(predict(i,j)-score(i,j));
    end
end
t2=clock;
etime(t2,t1)
error=mean(E(:));