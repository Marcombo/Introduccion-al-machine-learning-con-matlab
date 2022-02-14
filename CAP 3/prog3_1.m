% Ejemplo del uso del método K-NN en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

%%% Definimos nuestras clases con sus debidas etiquetas

x = [2 3;4 5;6 7;15 20;10 16;31 21; 24 18; 31 18; 28 34; 26 28];
y = ['Roja';'Roja';'Roja';'Roja';'Roja';'Azul';'Azul';'Azul';'Azul';'Azul'];

%%% Definimos el número de vecinos y damos una nueva muestra

k = 3;
p = [16 17];


%Determinamos la distancia(Euclidiana) de la nueva muestra con respecto 
%de cada elemento de las clases

for i =1:length(x(:,1))
 d(i)=norm(p-x(i,:)); 
end

% Se reordena de menos a mayor las distancias con sus respectivos índices
[td,pos]=sort(d);
 
% Utilizando el reacomodo de las distancias, creo dos elementos          
% auxiliares donde reordeno los elementos según la distancia con respecto 
% a la nueva observación y tomo los k vecinos cercanos

auxx = x(pos,:);   auxx = auxx(1:k,:);
auxy = y(pos,:);   auxy = auxy(1:k,:);
repet = zeros (1,k); %% declaro un auxiliar con ceros

% Hago el conteo de los vecinos cercanos

for i = 1:k
    for j = 1:k
        if auxy(j) == auxy(i)
           repet(i) = repet(i)+1;
        end
    end
end

% Determino el mayor número de vecinos y desplego el resultado

[rep, posrep] = max(repet);
res = ['La nueva observación pertenece a la clase: ', auxy(posrep,:)];
disp (res)

% Visualizar los resultados

plot(x(6:10,1), x(6:10,2),'.','markersize',10,'markerfacecolor','b');
hold on
plot(x(1:5,1), x(1:5,2),'.','markersize',10,'markerfacecolor','r');
hold on
plot(p(1), p(2),'*','markersize',10,'markerfacecolor','g');
