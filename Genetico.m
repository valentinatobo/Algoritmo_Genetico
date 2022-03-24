%% Calculo del Fitness
for i=1:Cromosomas
    %Maximización
    penalizacion= (r*poblacionmutadaMax(i,4))+(r*poblacionmutadaMax(i,5));
    poblacionmutadaMax(i,8)= poblacionmutadaMax(i,6)-penalizacion;

    %Minimizacion
    poblacionmutadaMin(i,9)= poblacionmutadaMax(i,7)+penalizacion;
    %hallo los fitnes
    matriz_fitness(i,1)=poblacionmutadaMax(i,8);
    matriz_fitness(i,2) = 1/(1+poblacionmutadaMin(i,9));
end

sumaFitnes = sum(matriz_fitness);
%matriz de probabilidad
for i=1:Cromosomas
    %probabilidad
    matriz_probabilidadMax(i,1) = matriz_fitness(i,1)/sumaFitnes(1,1);
    matriz_probabilidadMin(i,1) =  matriz_fitness(i,2)/sumaFitnes(1,2);

    if i==1
        %probabilidadAcumulada
        matriz_probabilidadMax(i,2)= matriz_probabilidadMax(i,1);
        matriz_probabilidadMin(i,2)= matriz_probabilidadMin(i,1);
        %rango de probabilidad inferior y superior
        matriz_probabilidadMax(i,3)=0;
        matriz_probabilidadMin(i,3)=0;
        matriz_probabilidadMax(i,4)=matriz_probabilidadMax(i,2);
        matriz_probabilidadMin(i,4)=matriz_probabilidadMin(i,2);

    else
        %probabilidadAcumulada
        matriz_probabilidadMax(i,2)= matriz_probabilidadMax(i-1,2)+matriz_probabilidadMax(i,1);
        matriz_probabilidadMin(i,2)= matriz_probabilidadMin(i-1,2)+matriz_probabilidadMin(i,1);
        %rango de probabilidad inferior y superior
        matriz_probabilidadMax(i,3)=matriz_probabilidadMax(i-1,2);
        matriz_probabilidadMin(i,3)=matriz_probabilidadMin(i-1,2);
        matriz_probabilidadMax(i,4)=matriz_probabilidadMax(i,2);
        matriz_probabilidadMin(i,4)=matriz_probabilidadMin(i,2);
    end
end

%% Proceso de seleccion
for i=1: Cromosomas
    matriz_seleccionMax(i,1)=rand(1);
    matriz_seleccionMin(i,1)=rand(1);
    j=1;
    %maximizacion
    while (true)
        if (matriz_seleccionMax(i,1) >= matriz_probabilidadMax(j,3) && matriz_seleccionMax(i,1)<matriz_probabilidadMax(j,4))
            matriz_seleccionMax(i,2)=j;
            matriz_seleccionMax(i,3)=poblacionmutadaMax(j,1);
            matriz_seleccionMax(i,4)=poblacionmutadaMax(j,2);
            matriz_seleccionMax(i,5)=poblacionmutadaMax(j,3);
            break
        else
            j=j+1;
        end
    end
    j=1;
    %minimizacion
    while (true)
        if (matriz_seleccionMin(i,1)>=matriz_probabilidadMin(j,3) && matriz_seleccionMin(i,1)<matriz_probabilidadMin(j,4))
            matriz_seleccionMin(i,2)=j;
            matriz_seleccionMin(i,3)=poblacionmutadaMin(j,1);
            matriz_seleccionMin(i,4)=poblacionmutadaMin(j,2);
            matriz_seleccionMin(i,5)=poblacionmutadaMin(j,3);
            break
        else
            j=j+1;
        end
    end
end

%% Proceso de cruce
% Padres Cromosomas seleccionados para el cruce max
cromosomas_seleccionadosMax=[];
j=1;
while true
    for i=1:Cromosomas
        alt=rand(1);
        if(alt<=pc)
            cromosomas_seleccionadosMax(j)=i;
            j=j+1;
        end
    end
    if (i==10 && j>1)
        break
    end
end
% Padres Cromosomas seleccionados para el cruce min
cromosomas_seleccionadosMin=[];
j=1;
while true
    for i=1:Cromosomas
        alt=rand(1);
        if(alt<=pc)
            cromosomas_seleccionadosMin(j)=i;
            j=j+1;
        end
    end
    if (i==10 && j>1)
        break
    end
end

%% Proceso de Cruce Max
if size(cromosomas_seleccionadosMax,2)==1
%     fprintf('no cruze por solo un padre \n');
else
    cromosomas_seleccionadosMax(end+1)= cromosomas_seleccionadosMax(1);
    duplicadoMax=matriz_seleccionMax;
    %Cruce con padres
    for i=1:(size(cromosomas_seleccionadosMax,2)-1)
        matriz_seleccionMax(cromosomas_seleccionadosMax(i),4)=duplicadoMax(cromosomas_seleccionadosMax(i+1),4);
        matriz_seleccionMax(cromosomas_seleccionadosMax(i),5)=duplicadoMax(cromosomas_seleccionadosMax(i+1),5);
    end
end
%Proceso de Cruce Min
if size(cromosomas_seleccionadosMin,2)==1
    %fprintf('no cruze por solo un padre \n');
else
    cromosomas_seleccionadosMin(end+1)= cromosomas_seleccionadosMin(1);
    duplicadoMin=matriz_seleccionMin;
    %Cruce Con padres
    for i=1:(size(cromosomas_seleccionadosMin,2)-1)
        matriz_seleccionMin(cromosomas_seleccionadosMin(i),4)=duplicadoMin(cromosomas_seleccionadosMin(i+1),4);
        matriz_seleccionMin(cromosomas_seleccionadosMin(i),5)=duplicadoMin(cromosomas_seleccionadosMin(i+1),5);
    end
end
%% Mutacion
%valor de genes a cambiar
% Nmutaciones=Cromosomas*3*pc;
Nmutaciones=5;
% Nmutaciones=3;
GenesaMutarMax=0;
GenesaMutarMin=0;
%Generamos los genes a cambiar para MAX
i=1;
while true
    r = randi([1 (Cromosomas*3)]);
    if(find(GenesaMutarMax==r))

    else
        GenesaMutarMax(i)=r;
        i=i+1;
    end
    if size(GenesaMutarMax,2)==Nmutaciones
        break;
    end
end
i=1;
while true
    r = randi([1 (Cromosomas*3)]);
    if(find(GenesaMutarMin==r))

    else
        GenesaMutarMin(i)=r;
        i=i+1;
    end
    if size(GenesaMutarMin,2)==Nmutaciones
        break;
    end
end
%end
d1=matriz_seleccionMax;
d2=matriz_seleccionMin;
%Generar los valores de la mutación para max
for i=1:Nmutaciones
    columnaMax=mod(GenesaMutarMax(i) ,3);
    filaMax=ceil(GenesaMutarMax(i)/3);
    %valores si es x1
    if(columnaMax==1)
        matriz_seleccionMax(filaMax,columnaMax+2)=rand(1)*maximos(1);
        %valores si es x2
    else if columnaMax==2
            matriz_seleccionMax(filaMax,columnaMax+2)=rand(1)*maximos(2);

            %valores si es x3
    else
        matriz_seleccionMax(filaMax,5)=rand(1)*maximos(3);
    end
    end
end
%Generar los valores de la mutación para MIN
for i=1:Nmutaciones
    columnaMin=mod(GenesaMutarMin(i) ,3);
    filaMin=ceil(GenesaMutarMin(i)/3);
    %valores si es x1
    if(columnaMin==1)
        matriz_seleccionMin(filaMin,columnaMin+2)=rand(1)*maximos(1);
        %valores si es x2
    else if columnaMin==2
            matriz_seleccionMin(filaMin,columnaMin+2)=rand(1)*maximos(2);
            %valores si es x3
    else
        matriz_seleccionMin(filaMin,5)=rand(1)*maximos(3);
    end
    end
end

%% Proceso de cambio de la matriz de poblacion mutada

%Maximizacion

for i=1: Cromosomas
    A=double(subs(Res1a, {x1,x2,x3}, {matriz_seleccionMax(i,3),matriz_seleccionMax(i,4),matriz_seleccionMax(i,5)}));
    B=double(subs(Res2a, {x1,x2,x3}, {matriz_seleccionMax(i,3),matriz_seleccionMax(i,4),matriz_seleccionMax(i,5)}));
    if(A<=MObra && B<=MPrima)
        poblacionmutadaMax(i,1) = matriz_seleccionMax(i,3);
        poblacionmutadaMax(i,2) = matriz_seleccionMax(i,4);
        poblacionmutadaMax(i,3) = matriz_seleccionMax(i,5);
        poblacionmutadaMax(i,4) = double(subs(Res1a, {x1,x2,x3}, {poblacionmutadaMax(i,1),poblacionmutadaMax(i,2),poblacionmutadaMax(i,3)}));
        poblacionmutadaMax(i,5) = double(subs(Res2a, {x1,x2,x3}, {poblacionmutadaMax(i,1),poblacionmutadaMax(i,2),poblacionmutadaMax(i,3)}));
        poblacionmutadaMax(i,6) = double(subs(Ganancia, {x1,x2,x3}, {poblacionmutadaMax(i,1),poblacionmutadaMax(i,2),poblacionmutadaMax(i,3)}));
        poblacionmutadaMax(i,7) = 0;
    end
end

%Minimizacion
for i=1: Cromosomas
    A=double(subs(Res1a, {x1,x2,x3}, {matriz_seleccionMin(i,3),matriz_seleccionMin(i,4),matriz_seleccionMin(i,5)}));
    B=double(subs(Res2a, {x1,x2,x3}, {matriz_seleccionMin(i,3),matriz_seleccionMin(i,4),matriz_seleccionMin(i,5)}));
    if(A<=MObra && B<=MPrima)
        poblacionmutadaMin(i,1)=matriz_seleccionMin(i,3);
        poblacionmutadaMin(i,2)=matriz_seleccionMin(i,4);
        poblacionmutadaMin(i,3)=matriz_seleccionMin(i,5);
        poblacionmutadaMin(i,4) = double(subs(Res1a, {x1,x2,x3}, {poblacionmutadaMin(i,1),poblacionmutadaMin(i,2),poblacionmutadaMin(i,3)}));
        poblacionmutadaMin(i,5) = double(subs(Res2a, {x1,x2,x3}, {poblacionmutadaMin(i,1),poblacionmutadaMin(i,2),poblacionmutadaMin(i,3)}));
        poblacionmutadaMin(i,6)=0;
        poblacionmutadaMin(i,7)=double(subs(Contaminacion, {x1,x2,x3}, {poblacionmutadaMin(i,1),poblacionmutadaMin(i,2),poblacionmutadaMin(i,3)}));
    end
end
