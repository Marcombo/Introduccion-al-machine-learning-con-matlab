% Expectación – Maximización (EM)                                                                                      
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
%PROGRAMA 
[n d]=size(X);
c=3;
%Inicialización
pi=ones(1,3)/3;
M = [-3.59 0.25;-1.09 -0.46; 0.75 1.07];
W=zeros(c,n);
P=zeros(size(W));
V=zeros(d,d,c);
V(:,:,1)=[1 0;0 1];
V(:,:,2)=[1 0;0 1];
V(:,:,3)=[1 0;0 1];

for k=1:1:100
 %Expectación
    for da=1:n
   for cu=1:3
%Ecuación 5.16   
P(cu,da)= mvnpdf([X(da,1) X(da,2)],M(cu,:),V(:,:,cu))*pi(cu);   
   end
   Tot=sum(P(:,da));
   W(:,da)=P(:,da)/Tot;
    end
  %Maximización
 T=zeros(c,d);
 for cu=1:3
   for da=1:n
  %Ecuación 5.21 
  T(cu,:)=T(cu,:)+W(cu,da)*X(da,:);   
   end
   M(cu,:)=T(cu,:)/(sum(W(cu,:)));
   end
  B=zeros(size(V));
  for cu=1:3
   for da=1:n
   dxm=X(da,:)-M(cu,:);  
   %Ecuación 5.22 
   B(:,:,cu)=B(:,:,cu)+W(cu,da)*dxm'*dxm;
   end
    V(:,:,cu)=B(:,:,cu)/(sum(W(cu,:)));
   end
  for cu=1:3
   %Ecuación 5.23
   pi(cu)=sum(W(cu,:))/n;
   end
   end
figure
G1 = mvnpdf([X1(:) X2(:)],M(1,:),V(:,:,1));
G2 = mvnpdf([X1(:) X2(:)],M(2,:),V(:,:,2));
G3 = mvnpdf([X1(:) X2(:)],M(3,:),V(:,:,3));
G=G1*pi(1)+G2*pi(2)+G3*pi(3);
GT = reshape(G,length(x2),length(x1));
 meshc(X1,X2,GT)
%Clasificación y despliegue
[d1,Id]=max(W);
Indice1=find(Id==1);
Indice2=find(Id==2);
Indice3=find(Id==3);
figure
plot(X(Indice1,1),X(Indice1,2),'o')
hold on
plot(X(Indice2,1),X(Indice2,2),'x')
plot(X(Indice3,1),X(Indice3,2),'D')
