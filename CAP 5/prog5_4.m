% Agrupación jerárquica por aglomeración                                                                                                                                     
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
%PROGRAMA 
X = random(gm,40);
Y=pdist(X);
Z=linkage(Y);
dendrogram(Z)
T=cluster(Z,'maxclust',3);
%Despliegue
Indice1=find(T==1);
Indice2=find(T==2);
Indice3=find(T==3);
figure
plot(X(Indice1,1),X(Indice1,2),'o')
hold on
plot(X(Indice2,1),X(Indice2,2),'x')
plot(X(Indice3,1),X(Indice3,2),'D')
