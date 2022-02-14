% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Programa 1.6 Ejemplo del uso de la función plot en MatLAB.
% Se carga el conjunto de observaciones
load fisheriris.mat
% Se grafica el histograma de la característica 1
% del conjunto de datos de todas las observaciones
h=histogram(meas(:,1))
