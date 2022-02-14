% Ejemplo del uso del método Naive Bayes en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

% Definimos las observaciones y sus clases

x = [-3 7; 1 5; 1 2; -2 0; 2 3; -4 0; -1 1; 1 1; -2 2; 2 7; -4 1; -2 7];
y = [3; 3; 3; 3; 4; 3; 3; 4; 3; 4; 4; 4];

% Creamos el clasificador

Mdl = fitcnb(x,y)

% Predecimos la clase de dos nuevas muestras con su ML

[cpre,ML] = predict(Mdl,[1 2;3 4]);

% Desplego clasificación

res1 = ['La Primera observación pertenece a la clase: '];
disp (res1); cpre(1)
res1 = ['La Segunda observación pertenece a la clase: '];
disp (res1); cpre(2)
