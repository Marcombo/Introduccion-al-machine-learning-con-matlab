%Programa que permite reconocer patrones mediante el 
%coeficiente correlación entre I(x,y) y R(i,j)
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
%Se utiliza todo el código descrito en el Programa 8.6
%Se fija el valor del umbral
th=0.5;
%Se obtiene la matriz binaria U
U=CLN>0.5;
%Se fija el valor de la vecindad
pixel=10;
%Se obtiene el valor más grande de CLN, de una vecindad
%definida por la variable píxel
for r=1:m-mt
    for c=1:n-nt
        if(U(r,c))
        %Se define el límite izquierdo de la vecindad
            I1=[r-pixel 1];
        %Se define el límite derecho de la vecindad
            I2=[r+pixel m-mt];
        %Se define el límite superior de la vecindad
            I3=[c-pixel 1];
    %Se define el límite inferior de a de la vecindad
            I4=[c+pixel n-nt];
        %Se definen posiciones teniendo en cuenta que 
            %su valor es relativo a r y c.
            datxi=max(I1);
            datxs=min(I2);
            datyi=max(I3);
            datys=min(I4);
            %Se extrae el bloque de la matriz CLN
            Bloc=CLN(datxi:1:datxs,datyi:1:datys);
          %Se obtiene el valor máximo de la vecindad
            MaxB=max(max(Bloc));
            %Si el valor actual del píxel es el máximo
           %entonces en esa posición se coloca un 1 en
            %la matriz S.
            if(CLN(r,c)==MaxB)
                S(r,c)=1;
            end
        end            
    end
end
%Se despliegue la imagen original Im
imshow(Im)
%Se mantiene el objeto grafico para que los demás
%comandos gráficos tengan efecto sobre la imagen Im
%desplegada
hold on
%Se determina la mitad de la ventana definida
%por el patrón de Referencia.
y=round(mt/2);
x=round(nt/2);
%A cada valor de máxima correlación encontrado
%en S se le añade la  mitad de la ventana definida
%por el patrón de Referencia, para identificar exactamente
%al objeto.
for r=1:m-mt
    for c=1:n-nt
        if(S(r,c))
        Resultado(r+y,c+x)=1;
        end   
    end
end
%Se grafican sobre la imagen Im los puntos de máxima
%correlación definidos en Resultado.
for r=1:m-mt
    for c=1:n-nt
        if(Resultado(r,c))
        plot(c,r,'+g');
        end
    end
end 
