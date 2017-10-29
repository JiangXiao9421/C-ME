clear;clc
load data2016;
%load data2016;
D=score;
[n,p]=size(D);
t1=clock;
for sigma=0.025:0.025:1 %set different thresholds.
  for i=1:n
   for j=1:p
       D=score;
       D(i,j)=0;
       D(i,j)=(sum(D(:,j)))/(n-1);
       C=corrcoef(D);
       C_l=C(j,:); 
       idx=find(C_l<sigma);
       C_l(idx)=0; %select the subjects whose correlation coefficients
                   %are greater than the threshold.
       for i1=1:n
           A(i1)=sum((D(i1,:).*C_l)/sum(C_l));%obtain the weighted scores
       end                                    %of the related subjects.
       [B,Iw]=sort(-A);
       [c,Iw]=sort(Iw); %sort the weighted scores.
       Is=-sort(-(D(:,j))); %sort the scores of the missing suject.
       S=Iw(i); %determine the rank of the missing student.
       predict(i,j)= Is(S);
   end
  end
B=abs(score(:)-predict(:));
ind=round(sigma./0.025);
Ourerror(ind)=mean(B);
end
t2=clock;
etime(t2,t1)
%save Ourerrordata2015 Ourerror
%save Ourerrordata2016 Ourerror
