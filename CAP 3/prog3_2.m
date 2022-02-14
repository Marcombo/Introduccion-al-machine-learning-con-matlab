% Ejemplo del uso del método Regresión Logistica en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

% Definimos las características con sus etiquetas

x = [2 2.5 3 4 4.5 5 6 6.5 7 8 6.1 6.6 6.8 7.2 8.3 8.5 9 10 11 12];
y = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1];

% Selecciono los elementos no repetidos y reasigno su etiqueta

x1 = unique(x);
for i = 1:length(x1)
    ind = find(x1(i)== x);
    y1(i) = sum(y(ind));
    n(i) = length(ind);
end

% Determino los pesos w “mnrfit” y determino el discrimiante “mnrval”

w = mnrfit(x1(:),[y1(:), n(:)-y1(:)]);
flog = mnrval(w,x1(:));

% Despliego los resultados

prop = y1./n;
xlim = linspace(min(x1), max(x1), 30);
propfitp = mnrval(w,xlim(:));
plot(x1,prop,'ob',xlim(:),propfitp(:,1),':r');
axis([1.99 12.01 -0.01 1.01])
