% Ejemplo del uso del método de cálculo del histograma en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

%Se limpia la memoria
clear all; close all         

%Cargar los datos Iris
load iris.dat
%Histograma del ancho del Sepalo 
h = histogram(iris(:,2));
%Número de Intervalos
fprintf('Número de Intervalos: %i \n',h.NumBins);
%Media
fprintf('Media: %.2f \n',mean(iris(:,2)));