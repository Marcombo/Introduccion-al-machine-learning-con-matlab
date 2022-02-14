% Ejemplo del uso de gradiente descendente múltiple en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz   

function prog4_4
%Se limpia la memoria
close all;
%Se cargan los datos
load boston
%Se asignan las variables 
x1 = boston(1:100,13); %indice de pobreza
x2 = boston(1:100,10); %impuesto de la vivienda
y = boston(1:100,14); %variable de salida
N = size(y,1); % Número de datos
X = [ones(N,1) x1 x2 x1.^2 x2.^2 x1.*x2]; % Se agrega la variable artificial x0 = 1 
%Solución
opciones = optimset('GradObj','on','MaxIter',300);%opciones del gradiente
w_inicial = 0*ones(size(X,2),1); %parametros iniciales
[w,J]=fminunc(@(w)(fun_costo(w,X,y,0)),w_inicial,opciones); %ejecución del gradiente
R2 =1- sum(((X*w)-y).^2)/sum((mean(y)-y).^2); %cálculo de coeficiente de determinación  
y_est = [1 10 300 100 90000 3000]*w;
%Resultados
%Parámetros Estimados
fprintf('Solución A): \n')
fprintf('Vector W: \n\t%f\n\t%f\n\t%f\n\t%f\n\t%f\n\t%f\n\n',w);
%Función de costos 
fprintf('Solución B): \n')
fprintf('\tJ= %f \n\n',mse(X*w,y));
%Coefiiciente de determinación 
fprintf('Solución C): \n')
fprintf('\tR2= %f \n\n',R2);
%Predicción 
fprintf('Solución D): \n')
fprintf('\tPredicción=  %f \n\n',y_est);
%Gráfica del modelo regresión
scatter3(X(:,2),X(:,3),y,'MarkerEdgeColor',[0 0.2667 0.6667],...
              'MarkerFaceColor',[0 0.2667 0.6667]);
x1G = linspace(min(x1),max(x1),30);
x2G = linspace(min(x2),max(x2),30);
[x1M,x2M] = meshgrid(x1G,x2G);
YFIT = w(1) + w(2)*x1M + w(3)*x2M + w(4)*x1M.*x1M + w(5)*x2M.*x2M + w(6)*x1M.*x2M;
hold on
mesh(x1M,x2M,YFIT);xlabel('% Condición Pobreza');ylabel('Impuesto');zlabel('Valor Medio')
end 
%función de costos
function [J, gradiente] = fun_costo(w,X,y,L) 
N = length(y);
temp = [];
temp(1,1)=(1/N)*sum((X*w-y));
for i=2:size(w,1)
    temp(i,1)=(1/N)*sum((X*w-y).*X(:,i)) + (L/N)*w(i);        
end
gradiente = temp;
r = (L/(2*N))*sum(w(2:end).^2);
J = mse(X*w,y)+r;
end







