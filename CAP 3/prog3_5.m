% Ejemplo del uso del método SVM en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

% Definimos las observaciones y sus clases

x = [2 3;4 5;6 7;15 20;10 16;31 21; 24 18; 31 18; 28 34; 26 28];
y = [-1; -1; -1; -1; -1; 1; 1; 1; 1; 1];

% Creamos el clasificador SVM

svm = fitcsvm(x,y)

% Despliego las muestras con usadas para el entrenamiento y marco los
% vector soporte para cada clase

h(1) = plot(x(6:10,1),x(6:10,2),'.','markersize',10,...
'markerfacecolor','b');
hold on
h(2) = plot(x(1:5,1),x(1:5,2),'.','markersize',10,...
'markerfacecolor','r');
hold on
h(3) = plot(x(svm.IsSupportVector,1),...
x(svm.IsSupportVector,2),'ko','MarkerSize',7); 

% Despliego el hiperplano optimo

d = 0.02; 
[x1Grid,x2Grid] = meshgrid(min(x(:,1)):d:max(x(:,1)),...
min(x(:,2)):d:max(x(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];        
[~,scores1] = predict(svm,xGrid); 

contour(x1Grid,x2Grid,reshape(scores1(:,2),size(x1Grid)),[0 0],'k');
legend({'-1','1','Support Vectors'},'Location','Best');
