% Generación del conjunto de datos                                                                                      
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         
% Limpiar variables 
%DATOS 
%Primera parte
mu1 = [-2.1 1.28];
Sigma1 = [0.59 0; 0 0.11];
mu2 = [-1.2 -1.40];
Sigma2 = [0.49 0; 0 0.11];
mu3 = [2.64 0.19];
Sigma3 = [0.05 0; 0 0.21];
x1 = -4:.1:4; x2 = -2:.1:2;
[X1,X2] = meshgrid(x1,x2);
F1 = mvnpdf([X1(:) X2(:)],mu1,Sigma1);
F2 = mvnpdf([X1(:) X2(:)],mu2,Sigma2);
F3 = mvnpdf([X1(:) X2(:)],mu3,Sigma3);
F=F1*(1/3)+F2*(1/3)+F3*(1/3);
F = reshape(F,length(x2),length(x1));
meshc(X1,X2,F);
%Segunda parte
muD = [-2.1 1.28;-1.2 -1.40; 2.64 0.19];
sigmaD = cat(3,[0.59 0; 0 0.11],[0.49 0; 0 0.11],[0.05 0; 0 0.21]);
p = ones(1,3)/3;
gm = gmdistribution(muD,sigmaD,p);
rng('default'); 
X = random(gm,300);
figure 
plot(X(:,1),X(:,2),'o')
