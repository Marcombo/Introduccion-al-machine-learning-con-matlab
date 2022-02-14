% Ejemplo del uso del método de intervalos de confianza en la distribuión 
% normal en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz   

%Se limpia la memoria
clear all; close all;

%datos del problema
nc = [90 95 99]./100; %vector de los 3 niveles de confianza
n=45;
mu = 178;
s = 16;
%cálculo de z
az = 1 - ((1-nc)./2); %el operador ./ divide cada elemento del vector
z = norminv(az);
%cálculo de limites
Li = mu - z.*(16/sqrt(n));
Lu = mu + z.*(16/sqrt(n));

%Resultado numérico
fprintf('Intervalos de confianza: \n');
variables = {'Li', 'Lu'};
filas = {'90%','95%','99%'};
T = array2table([Li',Lu'],'VariableNames',variables,'RowNames',filas);
disp(T);