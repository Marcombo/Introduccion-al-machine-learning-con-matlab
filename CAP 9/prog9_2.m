% Ejemplo del uso del método del teorema del límite central en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz   

%Se limpia la memoria
clear all; close all

%Se guardan en variables los datos del problema
mu = 14; %media de la población.
S = 3; %desviación estándar de la muestra.
n = 10; %tamaño de la muestra.
v = n-1; %grados de libertad.

%Solución a inciso A)
T_A = (15.5 - mu)/(S/sqrt(10));
P = tcdf(T_A,v);
P_X1 = 1 - P;

%Solución a inciso B)
T_B = (15 - mu)/(S/sqrt(10));
P = tcdf(T_B,v);
P_X2 = P;

%Solución a inciso C)
T_Cs = (14.5 - mu)/(S/sqrt(10));
T_Ci = (12.5 - mu)/(S/sqrt(10));
P_s = tcdf(T_Cs,v);
P_i = tcdf(T_Ci,v);
P_X3 = P_s - P_i;

%Solución a inciso D)
T_D = tinv(0.025,v);
T_D2 = -1*T_D;

%Resultados Numéricos
fprintf(" A) P(X_barra > 15.5 Psi) = %f.\n",P_X1);
fprintf(" B) P(X_barra < 15 Psi) = %f.\n",P_X2);
fprintf(" C) P(12.5 < X_barra < 14.5 Psi) = %f.\n",P_X3);
fprintf(" D) Valores extremos de T donde, P(T<=0.025) = %f, %f. \n",T_D,T_D2);

%Resultados Gráficos
x = -5:0.1:5;
y = tpdf(x,v);
subplot(2,2,1); plot(x,y); axis([-5 5 0 0.4]); hold on;...
    area(x(min(find(x>=T_A)):end),y(min(find(x>=T_A)):end),'FaceColor',[0 0.4471 0.7412]);
subplot(2,2,2); plot(x,y); axis([-5 5 0 0.4]); hold on;...
    area(x(1:max(find(x<=T_B))),y(1:max(find(x<=T_B))),'FaceColor',[0 0.4471 0.7412]);
subplot(2,2,3); plot(x,y); axis([-5 5 0 0.4]); hold on;...
    area(x(1,min(find(x>=T_Ci)):min(find(x>=T_Cs))),y(1,min(find(x>=T_Ci)):min(find(x>=T_Cs))),'FaceColor',[0 0.4471 0.7412]);   
subplot(2,2,4); plot(x,y); axis([-5 5 0 0.4]); hold on;...
    area(x(1:max(find(x<=T_D))),y(1:max(find(x<=T_D))),'FaceColor',[0 0.4471 0.7412]);...
    area(x(min(find(x>=T_D2)):end),y(min(find(x>=T_D2)):end),'FaceColor',[0 0.4471 0.7412]);
    

