% Ejemplo del uso del método de mínimos cuadrados en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

%Se limpia la memoria
clear all; close all
%Generación de la variable independiente x
x = linspace(0,2,100)';
%Evaluación de la función real
y = 1./(1+x);
%Agregar error aleatorio a la función real.
y_error = y + (0.16*rand(100,1) - 0.08);
%Se extraen 25 datos de entrenamiento.
x_training = x(1:4:100,1);
y_training = y_error(1:4:100,1);
%Cálculo de parámetros del modelo, con ecuaciones 4.6 y 4.7. 
theta_1 = cov(x_training,y_training)./var(x_training);
theta_1 = theta_1(1,2);
theta_0 = mean(y_training)-theta_1*mean(x_training);
%Cálculo del modelo de regresión.
y_estimada = theta_0 + theta_1.*x;
%Función de costos
J = mse(y_estimada,y);
%Resultados
fprintf('Solución A): \n');
fprintf('Theta 0 = %f , Theta 1 = %f \n\n',theta_0,theta_1);
%Función de costos 
fprintf('Solución B): \n'); 
fprintf('J= %f \n\n',J);
%Gráfica función real, función de regresión y datos de entrenamiento 
plot(x,y,'g','LineWidth',1); hold on;
plot(x,y_estimada,'r','LineWidth',1);
scatter(x_training,y_training,'b','MarkerFaceColor','b');
legend('Modelo Real', 'Modelo Estimado','Datos de Entrenamiento')
title('Modelo de Regresion por Mínimos Cuadrados');xlabel('x'); ylabel('y');
