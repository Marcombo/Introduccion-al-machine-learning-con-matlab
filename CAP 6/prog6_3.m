% Ejemplo del uso del método FA en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

% Se carga la base de datos

load examgrades

% Se utiliza el comando de análisis de factor

[Loadings,specVar,T,stats] = factoran(grades,2 ,'rotate','none');

% Se despliegan los resultados del análisis de factor (Sin rotar)

biplot(Loadings, 'varlabels',num2str((1:5)'));
title('Solutiones sin rotar');
xlabel('Factor 1'); ylabel('Factor 2');

% Se despliegan los resultados del análisis de factor rotados

figure();

[Loadings,specVar,T,stats] = factoran(grades,2,'rotate','promax');

biplot(Loadings, 'varlabels',num2str((1:5)'));
title('Solutiones rotadas');
xlabel('Factor 1'); ylabel('Factor 2');
