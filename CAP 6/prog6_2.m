% Ejemplo del uso del método ICA en MatLAB                                 
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 

clear all

% Determinamos el número de muestras y el periodo para cada señal

s   = 100;              
T   = [2, 3, 4];        

% Generamos tres señales de diferente naturaleza y desplegamos 

t = @(s,T) linspace(0,1,s) * 2 * pi * T;
S_in(1,:) = cos(t(s,T(1)));            
S_in(2,:) = sign(sin(t(s,T(2))));      
S_in(3,:) = sawtooth(t(s,T(3))); %S_in = S_in';       

cm = hsv(3);
figure();

for i = 1:3
    subplot(3,1,i);
    plot(S_in(i,:),'-','Color',cm(i,:)); 
end

% Combinación de señales

Fil_norm = @(X) bsxfun(@rdivide,X,sum(X,2));
Esc = Fil_norm (rand(3,3));
S_mezcl = Esc * S_in; %S_mezcl=S_mezcl';

figure();

for i = 1:3
    subplot(3,1,i);
    plot(S_mezcl (i,:),'-','Color',cm(i,:)); 
end

% Se aplica la funcion de ICA (Archivos incluidos, fastICA, centerRows y whitenRows)

S_ica = fastICA(S_mezcl,3,'negentropy');

figure();

for i = 1:3
    subplot(3,1,i);
    plot(S_ica (i,:),'-','Color',cm(i,:)); 
end

