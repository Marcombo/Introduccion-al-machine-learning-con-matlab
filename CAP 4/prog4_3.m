% Ejemplo del uso del método de ecuación normal en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

%Se limpia la memoria
clear all; close all;
%Se cargan los datos
load boston
%Se asignan las variables
x = boston(1:100,13); %variable de entrada 
y = boston(1:100,14); %variable de salida
X = [ones(size(x,1),1) x]; % Se agrega la variable artificial x0 = 1
%Cálculo de parámetros con \.
w = X\y;
%Evaluación de los parametros.
y_reg = X*w;
w_GD = [30.237996;-0.744135]; %parámetros obtenidos del ejemplo 4.4.2
y_regGD=X*w_GD;
%Se calcula la función de costos J 
J=mse(y_reg,y);
%Evaluación para el 10% de la población en condición de pobreza
y_10=w(1)+w(2)*10;
y_10GD= w_GD(1)+ w_GD(2)*10;
%Cálculo del Coeficiente de determinación
R2_normal = 1-sum((y_reg-y).^2)/sum((mean(y)-y).^2);
R2_GD = 1-sum((y_regGD-y).^2)/sum((mean(y)-y).^2);
%Resultados
%Parámetros 
fprintf('Solución A): \n');fprintf('Ecuación Normal: \n');
fprintf('w0 = %f , w1 = %f \n\n',w(1),w(2));
fprintf('Gradiente descendente: \n');
fprintf('w0 = %f , w1 = %f \n\n',w_GD(1),w_GD(2));
%Función de costos 
fprintf('Solución B): \n'); fprintf('Ecuación Normal: \n');
fprintf('J= %f \n\n',J);fprintf('Gradiente descendente: \n');
y_regGD = X*w_GD;
fprintf('J= %f \n\n',mse(y_regGD,y));
%Valor estimado de vivienda dado el %10 de la población en pobreza
fprintf('Solución C): \n');fprintf('Ecuación Normal: \n');
fprintf('Valor mediano estimado= %f \n\n',y_10);
fprintf('Gradiente descendente: \n');
fprintf('Valor mediano estimado= %f \n\n',y_10GD);
%Coeficiente de determinación
fprintf('Solución D): \n');fprintf('Ecuación Normal: \n');
fprintf('R2= %f \n\n',R2_normal);
fprintf('Gradiente descendente: \n');
fprintf('R2= %f \n\n',R2_GD);
%Gráfica del modelo regresión
y_reg = w(1) + w(2)*(min(x):1:max(x)); 
y_regGD = w_GD(1) + w_GD(2)*(min(x):1:max(x)); 
plot((min(x):1:max(x)),y_reg,'r','LineWidth',1); hold on;
plot((min(x):1:max(x)),y_regGD,'g','LineWidth',1);
scatter(x,y,12,'o','b','MarkerFaceColor','b');
scatter([10 10],[y_10 y_10GD], '*');
legend('Ecuación Normal', 'Gradiente Descendente','Datos de Entrenamiento', 'Location', 'northwest');
title('Modelo de Regresión');xlabel('x = % Condición de Pobreza'); ylabel('y = Valor de Vivienda');
hold off;
