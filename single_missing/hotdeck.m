clear;clc
load data2015;
[n,p]=size(score);
t1=clock;
for i=1:n
    for j=1:p
        D=score;
        D(i,j)=0;
        D(i,j)=(sum(D(:,j)))/(n-1); %fill in the null value with the mean value.
        dist=pdist(D);
        dist=squareform(dist);
        dist(i,i)=inf;
        [nu idx]=min(dist(:,i)'); %find the nearest student.
        predict(i,j)=D(idx,j);
        E(i,j)=abs(predict(i,j)-score(i,j)); %error matrix.
    end
end
t2=clock;
etime(t2,t1)
error=mean(E(:));