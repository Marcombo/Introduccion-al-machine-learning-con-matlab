% Ejemplo del uso del método de gráfico de cajas en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

%Se limpia la memoria
clear all; close all     

%Cargan los datos
load iris.dat
etiquetas = {'Largo Sépalo','Ancho Sépalo','Largo Pétalo','Ancho Pétalo'};
%Gráfico de caja
boxplot(iris(:,1:4),etiquetas);
%valores numéricos para los boxplot
D = zeros(4,8);
for i=1:4
    datos = iris(:,i);
    Y = quantile(datos,[0.25 0.75]); %Q1 y Q3
    D(i,2)= Y(1); D(i,4)=Y(2);%Q1 y Q3
    D(i,3) = median(datos); %Mediana
    D(i,6) = D(i,4) - D(i,2); % IQR
    D(i,1) = D(i,2) - D(i,6)*1.5; %mínimo
    D(i,5) = D(i,4) + D(i,6)*1.5; %máximo
    D(i,7) = min(datos);%Dato mínimo
    D(i,8) = max(datos); %Dato máximo
end

%Resultados
fprintf("Cálculos numéricos: \n\n");
calculos = {'Minimo','Q1','Media','Q3','Maximo','IQR','Min','Max'};
T = array2table(D,'VariableNames',calculos,'RowNames',etiquetas);
disp(T)