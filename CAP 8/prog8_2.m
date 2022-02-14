%Programa que permite calcular la distancia del
%maximo de diferencias entre I(x,y) y R(i,j)
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
I1=imread('patronG.jpg');
Im=rgb2gray(I1);
I2=imread('patronS.jpg');
T=rgb2gray(I2)
%Se Obtiene la dimensión de la imagen
[m n]=size(Im);
%Se convierte a double para evitar problemas numéricos
Imd=double(Im);
Td=double(T);
%Se obtiene el tamaño de la imagen de referencia
[mt nt]=size(T);
%Se define una matriz que recoge los resultados de las
%diferencias
Itemp=zeros(size(T));
%Se obtienen las distancias entre la imagen I(x,y) y
%R(i,j) según la ecuación 8.2
for re=1:m-mt
    for co=1:n-nt
        indice=0;
        for re1=0:mt-1
            for co1=0:nt-1
 Itemp(re1+1,co1+1)=abs(Imd(re+re1,co+co1)-Td(re1+1,co1+1));
            end
        end
        dm(re,co)=max(max(Itemp));
        
    end
end 
imshow(mat2gray(dm))