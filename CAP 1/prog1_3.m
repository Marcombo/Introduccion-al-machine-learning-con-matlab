% Programa 1.3 para eliminacion de valores atipicos.
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

%Se define un vector de datos
VD = [59 58 48 51 55 91 64 63 50 95];

%Se procesa el vector DS para la detección de valores atípicos
[AD] = isoutlier(VD);
VD(AD)=[]


