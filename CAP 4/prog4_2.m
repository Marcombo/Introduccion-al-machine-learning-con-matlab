% Ejemplo del uso del método de gradiente descendente en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

% Limpiar variables
clear all;

%Se asignan las variables
x = boston(1:100,13); %variable de entrada 
y = boston(1:100,14); %variable de salida
N = size(y,1); % Número de datos
X = [ones(N,1) x]; % Se agrega la variable artificial x0 = 1
%Inicialización de parámetros.
w = [0;0]; alfa = 0.01; maxIter = 2000; k=1;
w_num = size(w,1); %Número de parámetros de estimación
%Se define condición de paro y se inicia las iteraciones.
while k<= maxIter
%Se calculan los parámetros w con ecuación 4.9
for j=1:w_num
temp(j,1)=w(j)-(alfa/N)* sum((X*w - y).*X(:,j));
end 
%Se actualiza el valor de los parámetros w
w = temp;
%Se calcula la función de costos J con ecuación 4.3
J(k,1)= mse(X*w,y);
k = k + 1;
end %finaliza iteración
%Estimación para 10% de la población en condición de pobreza
y_10=w(1)+w(2)*10;
%Resultados
%Parámetros Estimados
fprintf('Solución A): \n')
fprintf('w0 = %f , w1 = %f \n\n',w(1),w(2));
%Función de costos 
fprintf('Solución B): \n')
fprintf('J= %f \n\n',J(maxIter));
%Gráfica del modelo regresión
y_reg = w(1) + w(2)*(min(x):1:max(x)); 
plot((min(x):1:max(x)),y_reg,'r','LineWidth',1); hold on;
scatter(x,y,12,'o','b','MarkerFaceColor','b');
scatter(10,y_10,'*','k');
legend('Modelo Estimado','Datos de Entrenamiento', 'Location', 'northwest');
title('Modelo de Regresión');xlabel('x = % condición de pobreza'); ylabel('y = Precio');
hold off;
%Se grafica la evolución de la función de costos
figure; plot(1:1:maxIter,J,'r','LineWidth',1);
legend(num2str(alfa))
title('Convergencia J');xlabel('Iteraciones');ylabel('J');
