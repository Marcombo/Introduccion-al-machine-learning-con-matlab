% Ejemplo del uso del método de prueba de hipótesis en distribución 
% normal en MatLAB                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz   

%Se limpia la memoria
clear all; close all

%datos del problema
mu = 4;
x = 5.5;
s = 3;
n = 45;
alfa = 0.05;
%nivel crítico usando distribución normal
nivelC = norminv(0.95);
%cálculo de z
z = (x-mu)/(s/sqrt(n));
%cálculo de p prueba de una cola
P = 1 - normcdf(z);
%Resultados
variables = {'Z', 'NivelCritico','ValorP','NivelConfianza'};
T = array2table([z,nivelC,P,alfa],'VariableNames',variables);
display(T);
