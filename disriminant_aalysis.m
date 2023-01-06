clear
%Synthetic data scatter plot
data1 = randn(60,2);
data1(:,1) = 3.4 + 1.2*data1(:,1);
data1(:,2) = 1.7 + 0.4*data1(:,2);

data2 = randn(60,2);
data2(:,1) = 5.5 + 1.8*data2(:,1);
data2(:,2) = 2.9 + 0.6*data2(:,2);

data3 = randn(60,2);
data3(:,1) = 3+ 1.8*data2(:,1);
data3(:,2) = 0.3 + 1.2*data2(:,2);

classes(1:60,1:9) = repmat('Granite_1',60,1);
classes(61:120,1:9) = repmat('Granite_2',60,1);
classes(121:180,1:9) = repmat('Granite_3',60,1);

data = [data1(:,1:2);data2(:,1:2);data3(:,1:2)];
save granite.mat

%extract the parameters of the classification boundaries
cls = ClassificationDiscriminant.fit(data,classes);
K1 = cls.Coeffs(2,3).Const;
L1 = cls.Coeffs(2,3).Linear;
K2 = cls.Coeffs(1,2).Const;
L2 = cls.Coeffs(1,2).Linear;
%store the bivariate means
Mu1 = cls.Mu(1,:);
Mu2 = cls.Mu(2,:);
Mu3 = cls.Mu(3,:);

%display the result in a graphic ( scatter plot of data)
h1 = axes('Box','On');
hold on
line(data1(:,1),data1(:,2),...
    'Marker','.','MarkerSize',8,...
    'LineStyle','None','MarkerEdgeColor','r')
line(data2(:,1),data2(:,2),...
 'Marker','.','MarkerSize',8,...
 'LineStyle','None','MarkerEdgeColor','b')
line(data3(:,1),data3(:,2),...
 'Marker','.','MarkerSize',8,...
 'LineStyle','None','MarkerEdgeColor','m')

plot(Mu1(:,1),Mu1(:,2),...
 'Marker','o','MarkerEdgeColor','k',...
 'MarkerSize',8,'MarkerFaceColor','k')
plot(Mu2(:,1),Mu2(:,2),...
 'Marker','o','MarkerEdgeColor','k',...
 'MarkerSize',8,'MarkerFaceColor','k')
line(Mu3(:,1),Mu3(:,2),...
 'Marker','o','MarkerEdgeColor','k',...
 'MarkerSize',8,'MarkerFaceColor','k')

%Legend making and inserting
h2 = legend('Granite 1','Granite 2','Granite 3',...
 'Location','SouthEast');
set(h2,'Box','on')

%Putting the clasiffiers on the graph
f1 = @(x1,x2) K1 + L1(1)*x1 + L1(2)*x2;
h3 = ezplot(f1,[-5 12 0 5]);
set(h3,'Color','k')
f2 = @(x1,x2) K2 + L2(1)*x1 +L2(2)*x2;
h4 = ezplot(f2,[-5 12 0 5]);
set(h4,'color','k')
text(0,2,'Granite 1','Color','r')
text(0,4,'Granite 2','Color','b')
text(10,4.5,'Granite 3','Color','m')
title('Discriminant Analysis')
hold off