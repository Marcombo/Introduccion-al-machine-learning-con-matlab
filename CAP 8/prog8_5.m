%Programa que permite calcular la correlación cruzada
%normalizada entre I(x,y) y R(i,j)
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
I1=imread('patronG.jpg');
Im=rgb2gray(I1);
I2=imread('patronS.jpg');
T=rgb2gray(I2);
%Se Obtiene la dimensión de la imagen
[m n]=size(Im);

%Se convierte a double para evitar problemas numéricos
Imd=double(Im);
Td=double(T);

%Se obtiene el tamaño de la imagen de referencia
[mt nt]=size(T);
%Se inicializa la variable a cero
suma=0;
suma1=0;

%Se obtienen las matrices C(r,s) y A(r,s)de la ec. 8.4
for re=1:m-mt
    for co=1:n-nt
        indice=0;
        for re1=0:mt-1
            for co1=0:nt-1
     suma=Imd(re+re1,co+co1)*Td(re1+1,co1+1)+suma;
     suma1=Imd(re+re1,co+co1)*Imd(re+re1,co+co1)+suma1;
            end
        end
        C(re,co)=2*suma;
        A(re,co)=suma1;
        suma=0;
        suma1=0;
       end
end
sum=0;

%Se obtienen la matriz B de la ec. 8.4
for re1=0:mt-1
            for co1=0:nt-1
       sum=Td(re1+1,co1+1)*Td(re1+1,co1+1)+sum;
            end
end

%Se obtienen la correlación cruzada normalizada
%según ec. 8.7        
for re=1:m-mt
    for co=1:n-nt
 Cn(re,co)=C(re,co)/((sqrt(A(re,co)))*sqrt(sum));
    end
end
imshow(mat2gray(Cn))
