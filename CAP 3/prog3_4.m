% Ejemplo del uso del método Discriminante de Fisher en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

% Definimos las clases

g1 = [4 1; 2 4; 2 3; 3 6; 4 4];
g2 = [9 10; 6 8; 9 5; 8 7; 10 8];

% Calculamos las medias de cada grupo y la de todas las muestras

m1 = mean(g1);
m2 = mean(g2);
M = mean([g1; g2]);

% Calculamos las dispersiones entre grupos y dentro de los grupos

da1 = (g1 - m1)'*(g1 - m1);
da2 = (g2 - m2)'*(g2 - m2);
dd = da1 +da2;

de1 = length (g1)*(m1 - M)' * (m1 - M);
de2 = length (g1)*(m2 - M)' * (m2 - M);
de = de1 + de2;

% Resolvemos los eigenvalores para obtener el vector de pesos

[w, l]= eig(de,dd);
l=diag(l);
[~, lord]=sort(l,'descend');
w=w(:,lord)

% Obtenemos las nuevas características proyectadas en w

ng1 = g1 * w;
ng2 = g2 * w;

% Desplegamos los datos originales y los proyectados

plot(g1(1:5,1),g1(1:5,2),'.','markersize',10,'markerfacecolor','b');
hold on
plot(g2(1:5,1),g2(1:5,2),'.','markersize',10,'markerfacecolor','b');
xlim([1 9]); ylim([0 11]); title ('Características originales');
 
figure
plot(ng1(1:5,1),ng1(1:5,2),'.','markersize',10,'markerfacecolor','b');
hold on
plot(ng2(1:5,1),ng2(1:5,2),'.','markersize',10,'markerfacecolor','b');
title ('Características proyectadas sobre w');
