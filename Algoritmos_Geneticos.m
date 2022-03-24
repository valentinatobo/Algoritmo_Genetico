clear all;
clc;
%% Carga de Variables
Variables;

%% determinar maximos valores de cada variables
for i=1:3
    ev1 = subs(Res1, {x1,x2,x3}, {arrVariables(i,1),arrVariables(i,2),arrVariables(i,3)});
    mx=solve(ev1, [arrVariables(i,i)]);
    ev2 = subs(Res2, {x1,x2,x3}, {arrVariables(i,1),arrVariables(i,2),arrVariables(i,3)});
    mx2=solve(ev2, [arrVariables(i,i)]);
    maximos(i)=min(mx,mx2);
end

%% Generar Poblacion Inicial llenando matriz de Valor por Restriccion
% y su correspondiente Valor de Funcion a maximizar y Funcion a minimizar
i=1;
while true
    poblacion(i, 1)=rand(1)*maximos(1);
    poblacion(i, 2)=rand(1)*maximos(2);
    poblacion(i, 3)=rand(1)*maximos(3);
    poblacion(i,4) = double(subs(Res1a, {x1,x2,x3}, {poblacion(i,1),poblacion(i,2),poblacion(i,3)}));
    poblacion(i,5) = double(subs(Res2a, {x1,x2,x3}, {poblacion(i,1),poblacion(i,2),poblacion(i,3)}));
    if(poblacion(i,4)<=MObra && poblacion(i,5) <=MPrima)
        %hallar los valores de la funcion objetivo MAX MIN
        poblacion(i,6)=double(subs(Ganancia, {x1,x2,x3}, {poblacion(i,1),poblacion(i,2),poblacion(i,3)}));
        poblacion(i,7)=double(subs(Contaminacion, {x1,x2,x3}, {poblacion(i,1),poblacion(i,2),poblacion(i,3)}));
        i=i+1;
    end
    if (i==Cromosomas+1)
        break;
    end
end
poblacionmutadaMax = poblacion;
poblacionmutadaMin = poblacion;
%% Inicio iterativo del algoritmo
while true
    %% Frente de Pareto
    Genetico;
    Pareto;
    %% Detencion del algoritmo
    CalculoSigma;
%     disp(sigma_problemaMin);
    if (iteracion>=iteraciones && (iteracion>=iteracionesMax || (sigma_problemaMax<sigma || sigma_problemaMin<sigma)))
        break
    end
    iteracion = iteracion +1;
end
hold on
scatter(matrizParetoOptimo(:,1),matrizParetoOptimo(:,2));
plot(matrizParetoOptimo(:,1),matrizParetoOptimo(:,2));