% Ejemplo del uso del método K-means en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 
clear all
% Se leen los datos mediante la funcion auxiliar arffparser
% Usa el archivo de datos 
% Ambos archivos se encuentran en el directorio tambien
C=arffparser('read', 'shapes.arff');
% Se asignan los datos
x=C.x.values;
y=C.y.values;
%Se grafican los datos originales
plot(x,y,'o')
% Se abre otra ventana para presentar los resultados
figure
D(:,1)=x;
D(:,2)=y;
%Se ejecuta el método K-means para 4 grupos
idx = kmeans(D,4);
%Se obtienen los índices para cada grupo
D1 = find(idx==1);
D2 = find(idx==2);
D3 = find(idx==3);
D4 = find(idx==4);
%Se grafican los resultados
plot(D(D1,1),D(D1,2),'o');
hold on
plot(D(D2,1),D(D2,2),'or');
plot(D(D3,1),D(D3,2),'ok');
plot(D(D4,1),D(D4,2),'oy');
