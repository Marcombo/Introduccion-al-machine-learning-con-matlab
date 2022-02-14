% Ejemplo del uso de la distribución normal y teorema de límite central en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz   

%Se limpia la memoria
clear all; close all

%Se guardan en variables los datos del problema
mu = 21; %media de la población
sigma = 2.5; %desviación estándar
n = 9; %tamaño de la muestra.

%Solución a inciso A)
Z_A = (23 - mu)/(sigma/3);
P = normcdf(Z_A);
P_X1 = 1 - P;

%Solución a inciso B)
Z_B = (20 - mu)/(sigma/3);
P = normcdf(Z_B);
P_X2 = P;

%Solución a inciso C)
Z_Cu = (21.5 - mu)/(sigma/3);
Z_Ci = (20.5 - mu)/(sigma/3);
P_s = normcdf(Z_Cu);
P_i = normcdf(Z_Ci);
P_X3 = P_s - P_i;
%Solución a inciso D)
Z_D = norminv(0.75);
X_barra = Z_D*(sigma/3)+mu; 

%Resultados Numéricos
fprintf(" A) P(X_barra > 23 horas) = %f.\n",P_X1);
fprintf(" B) P(X_barra < 20 horas) = %f.\n",P_X2);
fprintf(" C) P(20.5 < X_barra < 21.5 horas) = %f.\n",P_X3);
fprintf(" D) Valor de X_barra donde, P(X_barra > 0.25) = %f.\n",X_barra);

%Resultados Gráficos
normspec([Z_A,Inf]);
normspec([-Inf,Z_B]);
normspec([Z_Ci,Z_Cu]);
normspec([Z_D,Inf]);

