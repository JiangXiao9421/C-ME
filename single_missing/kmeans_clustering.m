clear;clc
load data2015
D=score;
[n p]=size(D);
for K=1:40 %set different cluster numbers.
for i=1:n
    for j=1:p
        D(i,j)=0;
        D(i,j)=(sum(D(:,j)))/(n-1);
        IDX=kmeans(D,K); %partitions the students into K clusters.
        idx=IDX(i); %find the cluster of the missing student.
        [x1,y1]=find(IDX==idx); %find the students in the same cluster. 
        R=D(x1,:);
        [m1,n1]=size(R);  
        predict(i,j)=sum(R(:,j))/m1;
        B(i,j)=abs(predict(i,j)-score(i,j));
        D=score;
   end
end
Kmeanserror(K)=mean(B(:));
end
%save Kmeanserrordata2015 Kmeanserror

