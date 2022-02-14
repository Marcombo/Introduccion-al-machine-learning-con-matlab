% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Ejemplo 1.8 del uso de la función boxplot en MatLAB.
% Se carga el conjunto de observaciones
load fisheriris.mat
% Se genera y despliega el diagrama de dispersión entre las
% característica 1 y 2 contemplando
% las observaciones de la 1-40
scatter(meas(1:40,1),meas(1:40,2))
%se mantiene la gráfica anterior para encimar el siguiente grafico
hold on
% Se genera y despliega el diagrama de dispersión entre las
% característica 1 y 2 contemplando
% las observaciones de la 41-80
scatter(meas(41:80,1),meas(41:80,2))
