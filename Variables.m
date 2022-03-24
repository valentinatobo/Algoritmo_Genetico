%% Defincion de Productos x1 producto1, x2 producto2, x3 producto3
syms x1 x2 x3
%% Definicion de Variables
MObra=1300;
MPrima=1000;
%% Maximizar
Ganancia=x1*10+x2*9+x3*8;
%% Minimizar
Contaminacion=x1*10+x2*6+x3*3;
%% Valores algoritmo Iniciales
pc=0.3;
pm=0.1;
Genes=10;
Cromosomas=10;
iteraciones = 20; % minimo
iteracionesMax=10000;
iteracion = 1;
sigma=0.01;
r=5;
%% Poblacion [x1, x2, x3, r1, r2, f1, f2, f1p,f2p] [x1, x2, x3, r1, r2, f1, f2, f1p,f2p]
poblacion = zeros(Cromosomas, 9);
%Matriz de fitness [fitneesf1, fitnessf2]
matriz_fitness=zeros(Cromosomas,2);
%matriz de probabilidad [probabilidadC, probabilidadAcumulada,rangoinferior, rangoSuperior]
matriz_probabilidadMax = zeros(Cromosomas,4);
matriz_probabilidadMin = zeros(Cromosomas,4);
%matriz de seleccion [aleatorio, #cromosoma, x1, x2, x3]
matriz_seleccionMax=zeros(Cromosomas,5);
matriz_seleccionMin=zeros(Cromosomas,5);
%arreglo de cromosomas seleccionados
cromosomas_seleccionadosMax = zeros(1,1);
cromosomas_seleccionadosMin = zeros(1,1);
matrizPareto=zeros(Cromosomas,3);
matrizParetoOptimoMax=[];
matrizParetoOptimoMin=[];
%% Restricciones
Res1a=x1*4+x2*3+x3*3;
Res1=x1*4+x2*3+x3*3-MObra==0;%Mano de Obra
Res2=x1*3+x2*2+x3*2-MPrima==0;%materia Prima
Res2a=x1*3+x2*2+x3*2;
% x1>=0; x2>=0; x3 >=0;

maximos=zeros(3,1);
arrVariables=[x1 0 0;0 x2 0;0 0 x3];