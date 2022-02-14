% Ejemplo del cálculo de medidas de tendencia central en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz

% Limpiar variables
clear all;
% se cargan los datos 
X = [70,50,40,70,80,70,60,90,70,70,100,80,60,70,80,60];

% Cálculos inciso A)
x_A = mean(X);
Me_A = median(X);
Mo_A = mode(X);

% Cálculos inciso B)
X2 = [70,50,40,70,80,70,60,90,70,70,300,80,60,70,80,60];
x_B = mean(X2);
Me_B = median(X2);
Mo_B = mode(X2);

%Resultados
R = [x_A Me_A Mo_A; x_B Me_B Mo_B];
fprintf("Soluciones: \n\n");
medidas = {'Media','Mediana','Moda'};
T = array2table(R,'VariableNames',medidas,'RowNames',{'A)','B)'});
disp(T)
