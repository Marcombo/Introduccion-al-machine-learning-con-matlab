% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Se carga el conjunto de observaciones
% Programa 1.5 Ejemplo del uso de la función filloutliers en MatLAB.

load fisheriris.mat
% Se define cuantas observaciones tiene el conjunto de datos
N=size(meas,1);
% Se define el vector en el eje x
t=1:N
% Se grafican las observaciones en sus diferentes características 
plot(t,meas)
legend('Long. sépalo','Ancho sépalo','Long. pétalo','Ancho pétalo')
