% Ejemplo del uso del método PCA en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

% Definimos nuestras características x=física, y=química

x = [10 9.4 9.2 6 7.5 6];
y = [9.3 8.9 8 5.5 6.9 6.9];

% Los agrupo en forma de matriz

Caract = [x;y]';

% Calculo los elementos necesarios con PCA

[coef,nd,latent,tsd,vari]=pca(Caract);

% Despliego los porcentajes de las componentes y ploteo los datos originales y los rotados

plot(x,y,'g*')
grid on
figure
plot(nd(:,1),nd(:,2),'r*')
grid on
disp ('Porcentaje de variación en el primer componente:');
disp(vari(1));
disp ('Porcentaje de variación en la segunda componente:');
disp(vari(2));
