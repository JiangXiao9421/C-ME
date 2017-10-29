clear;clc;
load data2015;
[n p]=size(score);
t1=clock;
for i=1:n
    for j=1:p
        D=score;
        D(i,j)=0; %set the null value to 0.
        predict(i,j)=(sum(D(:,j)))/(n-1);   
    end
end
t2=clock;
etime(t2,t1)
E=abs(predict(:)-score(:)); 
error=mean(E(:));