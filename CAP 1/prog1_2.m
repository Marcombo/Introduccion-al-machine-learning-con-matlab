% Programa 1.2 para la Definición de una tabla en MatLAB
% Autores: Erik Cuevas, Omar Avalos, Arturo Valdivia y Primitivo Díaz         

%Vector de observaciones de tipo entero
IntVar = [NaN;2;4;8;9;12;18;27];

%Vector Observaciones de tipo real
RealVar = single([1.1;NaN;5.2;7.3;9.4;11.5;16.6;21.7]);

%Vector Observaciones de tipo Celda con cadenas
celdcadVar = {'uno';'tres';'nueve';'siete';'diez';'doce';'veinte';'treinta'};

%Vector Observaciones de tipo caracter
caractVar = ['A';'B';'C';' ';'E';'F';'G';'H'];

%Vector Observaciones de tipo categóricas
categoVar =categorical({'rojo';'amarillo';'azul';'violeta';'';'morado';...
'naranja';'blanco'});

%Vector Observaciones de tipo fecha
fechaVar = [datetime(2014:1:2018,7,20) NaT datetime(2017,8,26) datetime(2017,10,8) ]';

%Vector Observaciones de tipo cadena
cadVar = ["a";"b";"c";"d";"e";"f";missing;"i"];

%Se crea una tabla usando los vectores como columnas mediante table
D1 = table(IntVar,RealVar,celdcadVar,caractVar,categoVar,fechaVar,cadVar)
