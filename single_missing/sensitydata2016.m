clear;clc;
load KNN2016;load ourdata2016;load Kmeanserrordata2016;load lowrank2016_40

meanx1=[1,40];
hotdeckx2=[1,40]; %operation times
regressx3=[1,40];
lowrankx4=1:40;
kmeansx5=1:40;
knnx6=1:40;
ourx7=0.025:0.025:1;

meany1=[7.5571,7.5571];
hotdecky2=[7.0516,7.0516]; %the error of hotdeck 
regressy3=[6.0084,6.0084];
lowranky4=error';
kmeansy5=Kmeanserror';
knny6=KNNerror';
oury7=Ourerror';



subplot(1,4,1)
h1=plot(lowrankx4,lowranky4,'-rs','markersize',4, 'MarkerFaceColor','r');
hold on
plot(meanx1,meany1,'m','LineWidth',2);
plot(hotdeckx2,hotdecky2,'k');
plot(regressx3,regressy3,'b')
set(gca,'xtick',[0 20 40])
set(gca,'xticklabel',{'0','20n','40n'})
set(gca,'FontSize',8,'FontName','Times New Roman');
ylim([5 8])
xlabel('Parameter ¦Ó','fontsize',7);
ylabel('Mean Absolute Error','fontsize',7)
title('a.','position',[0,8]);
set(gca,'ytick',[5:0.5:8]);
%h3=legend('lowrank in data2015','location','NorthEast');
set(gca,'ygrid','on');
%set(h3,'Box','off');
box off 
legend('Low-rank','Mean imputation','Hot-deck','Regression',...
'Location','best')

subplot(1,4,2)
h2=plot(kmeansx5,kmeansy5,'<-g','markersize',4, 'MarkerFaceColor','g');
hold on
plot(meanx1,meany1,'m','LineWidth',2);
plot(hotdeckx2,hotdecky2,'k','markersize',2);
plot(regressx3,regressy3,'b','markersize',2)
set(gca,'FontSize',8,'FontName','Times New Roman');
ylim([5 8])
xlabel('Cluster Number K','fontsize',7);
title('b.','position',[0,8]);
set(gca,'ytick',[5:0.5:8]);
%h4=legend('Kmeans in data2015','location','NorthEast');
set(gca,'ygrid','on');
%set(h4,'Box','off');
box off  
legend('Kmeans','Mean imputation','Hot-deck','Regression',...
'Location','best')

subplot(1,4,3)
h3=plot(knnx6,knny6,'-co','markersize',4, 'MarkerFaceColor','c');
hold on
plot(meanx1,meany1,'m','LineWidth',2);
plot(hotdeckx2,hotdecky2,'k','markersize',2);
plot(regressx3,regressy3,'b','markersize',2)
set(gca,'FontSize',8,'FontName','Times New Roman');
ylim([5 8])
xlabel('Neighborhood Size K','fontsize',7);
title('c.','position',[0,8]);
set(gca,'ytick',[5:0.5:8]);
%h5=legend('KNN in data2015','location','NorthEast');
set(gca,'ygrid','on');
%set(h5,'Box','off');
box off  
legend('KNN','Mean imputation','Hot-deck','Regression',...
'Location','best')

subplot(1,4,4)
meanx1=[0.025,1];
hotdeckx2=[0.025,1]; %operation times
regressx3=[0.025,1];

h7=plot(ourx7,oury7,'-rp','markersize',4, 'MarkerFaceColor','r');
hold on
h4=plot(meanx1,meany1,'m','LineWidth',2);
h5=plot(hotdeckx2,hotdecky2,'k');
h6=plot(regressx3,regressy3,'b');
set(gca,'FontSize',8,'FontName','Times New Roman');
ylim([5 8])
xlabel('Threshold ¦Å','fontsize',7);
title('d.','Position',[0 8]);
set(gca,'ytick',[5:0.5:8]);
%h6=legend('our method in data2015','location','NorthEast');
set(gca,'ygrid','on');
%set(h6,'Box','off');
box off  
legend([h7,h4,h5,h6],'Our method','Mean imputation','Hot-deck','Regression',...
'Location','best')


%legend([h1,h2,h3,h4,h5,h6,h7],'Low-rank','Kmeans','KNN','Mean imputation',...
 %   'Hot-deck','Regression','Our method','Location','southoutside')
set(gca,'FontSize',5,'FontName','Times New Roman')
%set(get(get(h1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');  
