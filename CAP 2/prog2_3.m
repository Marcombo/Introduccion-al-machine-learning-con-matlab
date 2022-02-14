% Ejemplo del uso del método de gráfico de barras en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

%Se limpia la memoria
clear all; close all

%Vector de 6x1 datos aleatorios
datos = randi(50,6,1);

%Gráfica 2.8(a)
subplot(2,2,1);
bar(datos,0.5);
%Manejador de ejes
ax = gca;
ax.XTick=1:6;
ax.XTickLabels={'Enero','Febrero','Marzo','Abril','Mayo','Junio'};
ax.XTickLabelRotation = 45;

%Gráfica 2.8(b)
subplot(2,2,2);
barh(datos,0.5);
%Manejador de ejes
ay = gca;
ay.YTick=1:6;
ay.YTickLabels={'Enero','Febrero','Marzo','Abril','Mayo','Junio'};
ay.YTickLabelRotation = 45;

%Vector de 6x3 datos aleatorios
datos2 = randi(50,6,3);

%Gráfica 2.8(c)
subplot(2,2,3);
bar(datos2,0.5);
%Manejador de ejes
ax = gca;
ax.XTick=1:6;
ax.XTickLabels={'Enero','Febrero','Marzo','Abril','Mayo','Junio'};
ax.XTickLabelRotation = 45;
legend('P1','P2','P3');

%Gráfica 2.8(d)
subplot(2,2,4);
bar(datos2,0.5,'stacked');
%Manejador de ejes
ax = gca;
ax.XTick=1:6;
ax.XTickLabels={'Enero','Febrero','Marzo','Abril','Mayo','Junio'};
ax.XTickLabelRotation = 45;
legend('P1','P2','P3');









