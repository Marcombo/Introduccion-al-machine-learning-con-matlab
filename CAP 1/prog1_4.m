% Programa 1.4 Ejemplo de uso de la función filloutliers en MatLAB.
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

% Vector de observaciones
D = [59 58 48 51 55 101 64 63 50 20];

% Se contabilizan cuantos elementos tiene el vector D
N=numel(D);

% Se define el vector del eje x
x = 1:N;

%Se rellenan los avalores atípicas del vector D
[F,TF,Ui,Us,C] = filloutliers(D,'linear');

%Se grafica de forma comparativa los datos originales contra los
%datos generados por filloutliers del vector D
plot(x,D,x,F,'o',x,Ui*ones(1,N),x,Us*ones(1,N),x,C*ones(1,N))
legend('Datos originales','Datos transformados','Umbral... inferior','Umbral superior','Centro de los datos')
