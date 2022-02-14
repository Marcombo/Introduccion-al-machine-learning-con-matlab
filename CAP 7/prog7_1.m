% Generación de datos para el ejemplo de clasificación con arboles                                  
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 
clear all
X(1:50,1) = unifrnd(0,1,50,1);
X(1:50,2) = unifrnd(0.5,1,50,1);
plot(X(1:50,1),X(1:50,2),'o');
hold on
y(1:50) = 2;
X(51:100,1) = unifrnd(-1,0,50,1);
X(51:100,2) = unifrnd(-0.5,1,50,1);
plot(X(51:100,1),X(51:100,2),'+');
y(51:100) = 3;
X(101:150,1) = unifrnd(-1,0,50,1);
X(101:150,2) = unifrnd(-1,-0.5,50,1);
plot(X(101:150,1),X(101:150,2),'*');
y(101:150) = 10;
X(151:200,1) = unifrnd(0,1,50,1);
X(151:200,2) = unifrnd(-1,0.5,50,1);
y(151:200) = -10;
plot(X(151:200,1),X(151:200,2),'.');
