clear;clc;
load data2015
%load data2016
[n,p]=size(score);
D=score;
t1=clock;
for K=1:40 %set different K-values.
%tic;
for i=1:n
    for j=1:p
        D(i,j)=0;
        D(i,j)=(sum(D(:,j)))/(n-1);
        dis=pdist(D);
        dis=squareform(dis); %calculate the distances based on the other sujects.
        dis_n=dis(i,:);
        [k l]=sort(dis_n);
        neighbor=l(1:K);
        neighbor_dis=k(1:K);
        predict(i,j)= sum(D(neighbor,j))/(K);
        D=score;
     end
end
%toc;
B=abs(score(:)-predict(:));
KNNerror(K)=mean(B(:));
end
t2=clock;
etime(t2,t1)
%save KNNerrordata2016_40 KNNerror
%save KNNerrordata2016_40 KNNerror
     
  
      