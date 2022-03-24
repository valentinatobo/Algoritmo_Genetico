    banderaPareto=0;
    %verificacion
    for i=1:Cromosomas
        if(poblacionmutadaMax(i,4)<=MObra && poblacionmutadaMax(i,5) <=MPrima && poblacionmutadaMin(i,4)<=MObra && poblacionmutadaMin(i,5) <=MPrima)
            banderaPareto = banderaPareto+1;
        else
            break
        end
    end
    if banderaPareto == 10
        for i=1: Cromosomas
            matrizPareto(i,1)=double(subs(Ganancia, {x1,x2,x3}, {poblacionmutadaMax(i,1),poblacionmutadaMax(i,2),poblacionmutadaMax(i,3)}));
            matrizPareto(i,2)=double(subs(Contaminacion, {x1,x2,x3}, {poblacionmutadaMax(i,1),poblacionmutadaMax(i,2),poblacionmutadaMax(i,3)}));
        end
        for i=11: Cromosomas*2
            matrizPareto(i,1)=double(subs(Ganancia, {x1,x2,x3}, {poblacionmutadaMin(i-Cromosomas,1),poblacionmutadaMin(i-Cromosomas,2),poblacionmutadaMin(i-Cromosomas,3)}));
            matrizPareto(i,2)=double(subs(Contaminacion, {x1,x2,x3}, {poblacionmutadaMin(i-Cromosomas,1),poblacionmutadaMin(i-Cromosomas,2),poblacionmutadaMin(i-Cromosomas,3)}));
        end

        for i=1:Cromosomas*2
            for j=i:Cromosomas*2
                if (matrizPareto(i,1) <= matrizPareto(j,1))
                    if (matrizPareto(i,2) > matrizPareto(j,2))
                        matrizPareto(i,3)=0;
                        break;
                    else
                        matrizPareto(i,3)=1;
                    end
                else
                    matrizPareto(i,3)=1;
                end
            end
        end
    end
    for i=1:Cromosomas
        if (matrizPareto(i,3)==1)
            matrizParetoOptimoMax(end+1) = matrizPareto(i,1);
            matrizParetoOptimoMin(end+1) = matrizPareto(i,2);
        end
    end

    matrizParetoOptimo=[matrizParetoOptimoMax' matrizParetoOptimoMin'];
    matrizParetoOptimo = unique(matrizParetoOptimo, 'rows');

    for i=1:length(matrizParetoOptimo)
        for j=i:length(matrizParetoOptimo)
            if (matrizParetoOptimo(i,1) <= matrizParetoOptimo(j,1))
                if (matrizParetoOptimo(i,2) > matrizParetoOptimo(j,2))
                    matrizParetoOptimo(i,3)=0;
                    break;
                else
                    matrizParetoOptimo(i,3)=1;
                end
            else
                matrizParetoOptimo(i,3)=1;
            end
        end
    end

