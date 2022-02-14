%Programa que permite calcular el coeficiente de
%correlación entre I(x,y) y R(i,j)
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
%Se inicializa las variables de acumulación a cero
suma1=0;
suma2=0;
suma3=0;

%Se calcula la media de la imagen de referencia
MT=mean(mean(Td));
 
for re=1:m-mt
    for co=1:n-nt
        
        for re1=0:mt-1
            for co1=0:nt-1
%Se obtiene la matriz correspondiente de la imagen de referencia
              Itemp(re1+1,co1+1)=Imd(re+re1,co+co1);
            end
        end
        %Se calcula la media de la imagen correspondiente
        MI=mean(mean(Itemp));
       for re1=0:mt-1
            for co1=0:nt-1
   suma1=(Itemp(re1+1,co1+1)-MI)*(Td(re1+1,co1+1)-MT)+suma1;
              suma2=((Itemp(re1+1,co1+1)-MI)^2)+suma2;
              suma3=((Td(re1+1,co1+1)-MT)^2)+suma3;
            end
       end
        %Se calcula el coeficiente de correlación según 8.8
      CL(re,co)=suma1/((sqrt(suma2)*sqrt(suma3))+eps);
        %Se resetean las variables de acumulación
        suma1=0;
        suma2=0;
        suma3=0;
    end
end
%Se transforma linealmente el contenido de a [0,1]
CLN=mat2gray(CL);
imshow(CLN)
