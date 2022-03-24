    %sigma MAX
    Fo=0;
    PromedioFoMax=sum(poblacionmutadaMax(:,6))/Cromosomas;

    sigma_problemaMax=0;
    for i=1:Cromosomas
        sigma_problemaMax=  sigma_problemaMax + ((poblacionmutadaMax(i,6)-PromedioFoMax)^2);
    end
    sigma_problemaMax=sqrt(sigma_problemaMax/Cromosomas);

    %Sigma Min

    Fo=0;
    for i=1:Cromosomas
        Fo=Fo+poblacionmutadaMin(i,7);
    end
    PromedioFoMin=Fo/Cromosomas;
    sigma_problemaMin=0;
    for i=1:Cromosomas
        sigma_problemaMin=  sigma_problemaMin + ((poblacionmutadaMin(i,7)-PromedioFoMin)^2);
    end
    sigma_problemaMin=sqrt(sigma_problemaMin/Cromosomas);