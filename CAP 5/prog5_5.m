% Fuzzy C-means                                                                                                                                     
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
%PROGRAMA 
%Inicialización de los clústers entre [-2 2] y [-4 4]
muD = [-2.1 1.28;-1.2 -1.40; 2.64 0.19];
sigmaD = cat(3,[0.59 0; 0 0.11],[0.49 0; 0 0.11],[0.05 0; 0 0.21]);
p = ones(1,3)/3;
gm = gmdistribution(muD,sigmaD,p);

X = random(gm,40);
c(1,1)=(2*rand-1)*4;
c(1,2)=(2*rand-1)*2;
c(2,1)=(2*rand-1)*4;
c(2,2)=(2*rand-1)*2;
c(3,1)=(2*rand-1)*4;
c(3,2)=(2*rand-1)*2; 
M=zeros(40,3);
for k=1:10
for j=1:40
%Cálculo de los grados de pertenencia
     dif=X(j,:)-c(1,:);
     d1=sqrt(dif * dif');
     dif=X(j,:)-c(2,:);
     d2=sqrt(dif * dif');
     dif=X(j,:)-c(3,:);
     d3=sqrt(dif * dif');
     R1=(d1/d1)+(d1/d2)+(d1/d3);
     R2=(d2/d1)+(d2/d2)+(d2/d3);
     R3=(d3/d1)+(d3/d2)+(d3/d3);
     M(j,1)=1/R1;
     M(j,2)=1/R2;
     M(j,3)=1/R3;
end
%Actualización de los centroides
for i=1:3
     suma=zeros(1,2);
  for j=1:40
      suma=suma+M(j,i)*M(j,i)*X(j,:);
  end
     c(i,:)=suma/(sum(M(:,i).^2));
 end
 end
%División y despliegue de los datos
[d Ind]=max(M,[],2);
Indice1=find(Ind==1);
Indice2=find(Ind==2);
Indice3=find(Ind==3);
figure
plot(X(Indice1,1),X(Indice1,2),'o')
hold on
plot(X(Indice2,1),X(Indice2,2),'x')
plot(X(Indice3,1),X(Indice3,2),'D')
