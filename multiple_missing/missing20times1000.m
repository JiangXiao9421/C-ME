clear;clc;
load data2015;
[n,p]=size(score);
for j=1:1000
    D=score;
    vec=randperm(n*p);
    s=vec(1:20);
    D(s)=0; %select 20 empty value at random and set them as 0.
    [t,k]=find(D==0); 
%===============================================
%low-rank
    Omega=find(D~=0);
    data=D(Omega);
    [m l]=size(Omega);
    %sigma = 0;
    %sigma = .05*std(data);
    %data = data + sigma*randn(size(data));
    delta=((n*p)/m)*1.2;
    tau =40*n;
    maxiter = 500;
    tol = 1e-4;
    [U,S,V,numiter] = SVT([n p],Omega,data,tau,delta,maxiter,tol);
    prelow = U*S*V';
    [row,column]=find(D==0);
    for i1=1:length(k)
        dif(i1)=abs(score(row(i1),column(i1))-prelow(row(i1),column(i1)));
    end
    maelow(j)=sum(dif(:)/length(k));
%===================================
%mean imputation
    for i2=1:length(t)
        g=find(D(:,k(i2))==0);
        number=length(g);
        D(t(i2),k(i2))=sum(D(:,k(i2)))/(n-number);
        Eaver(i2)=abs(D(t(i2),k(i2))-score(t(i2),k(i2))); 
    end
    maemean(j)= mean(Eaver(:));
%===============================================
%our method
C=corrcoef(D);
for i3=1:length(t)
        C_l=C(k(i3),:);
        ouridx=find(C_l<0.35); %the optimal threshold is produced by the experiments with missing single value.
        C_l(ouridx)=0;
        for i4=1:n
            new(i4)=sum((D(i4,:).*C_l)/sum(C_l));
        end
      [B,Iw]=sort(-new);
        [c,Iw]=sort(Iw);
        Is=-sort(-(D(:,k(i3))));
                                  
       
       S=Iw(t(i3)); %determine the rank of the missing student. 
     preour(t(i3),k(i3))=Is(S);
        Eour(i3)=abs(score(t(i3),k(i3))-preour(t(i3),k(i3)));
    end
    maeour(j)=mean(Eour(:));
%==========================================
%hotdeck
    hotdist=pdist(D);
    hotdist=squareform(hotdist);
    hotdist(logical(eye(n)))=inf;
    for i6=1:length(t)
        [hotnum, hotidx]=min(hotdist(:,t(i6))'); %find the nearest student.
        prehot(t(i6),k(i6))=D(hotidx,k(i6));
        Ehot(i6)=abs(prehot(t(i6),k(i6))-score(t(i6),k(i6))); %error matrix.
    end
    maehot(j)=mean(Ehot(:));
%===========================================
%regression
    for i7=1:length(t);
        regidx=setdiff(1:p,k(i7));
        Ddiff=D(:,regidx);  
        Y=D(:,k(i7));
        X=[ones(length(Y),1),Ddiff];
        [b,bint,r,rint,stats]=regress(Y,X);
        b0=b(1,1); %constant term.
        b=b(2:end,1); %coefficient.
        prereg(t(i7),k(i7))=sum(b'.*Ddiff(t(i7),:))+b0;
        Ereg(i7)=abs(prereg(t(i7),k(i7))-score(t(i7),k(i7)));
    end
    maeregress(j)=mean(Ereg(:));
%===========================================
%kmeans
    [IDX,Cluster]=kmeans(D,5); %the optimal cluster is produced by the experiments with missing single value.
    for i8=1:length(t)
        clear miss
        id=IDX(t(i8));
        [x8,y8]=find(IDX==id);
        R=D(x8,:);
        [m8,n8]=size(R);
        prekmeans(t(i8),k(i8))=sum(R(:,k(i8)))/m8;
        Ekmeans(i8)=abs(prekmeans(t(i8),k(i8))-score(t(i8),k(i8)));
    end
    maeclustering(j)=mean(Ekmeans(:));
%==================================================
%knn 

   K=17;%:40 %set different K-values.
%tic;
    knndist=pdist(D);
    knndist=squareform(knndist); %calculate the distances based on the other sujects.
    for i9=1:length(t)
        dis_n=knndist(t(i9),:);
        [kk ll]=sort(dis_n);
        neighbor=ll(1:K);
        neighbor_dis=kk(1:K);
       
        preknn(t(i9),k(i9))= sum(D(neighbor,k(i9)))/K;
        Eknn(i9)=sum(abs(preknn(t(i9),k(i9))-score(t(i9),k(i9))));
    end
    maeknn(j)=mean(Eknn(:));
    
%========================================================
end
errormaeour=mean(maeour(:));
errormaelow=mean(maelow(:));
errormaemean=mean(maemean(:));
errormaehot=mean(maehot(:));
errormaeclus=mean(maeclustering(:));
errormaeknn=mean(maeknn(:));
errormaeregress=mean(maeregress(:));
