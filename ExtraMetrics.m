function [CostperPaxRBS,CostperPaxGDP, CostperPaxGHP, maxCostpaxRBS, maxCostpaxGDP,maxCostpaxGHP,refundsRBS, refundsGDP, refundsGHP, avgempaxRBS, avgempaxGDP, avgempaxGHP, avgemflightRBS, avgemflightGDP, avgemflightGHP ] = ExtraMetrics(TotalCostRBS,TotalCostGDP, TotalCostGHP, ControlledGHP, Seats, GroundCostRBS, AirCostRBS, GroundCostGDP, AirCostGDP,costvectorGHP, GroundDelayRBS, GroundDelayGDP, GroundDelayGHP, DelayEmissionsRBS, DelayEmissionsGDP, DelayEmissionsGHP )

    lf = 0.823;
    totalPax = 0;
    for i = ControlledGHP
        totalPax = totalPax + Seats(i)*lf;
    end
    CostperPaxRBS = TotalCostRBS/totalPax;
    CostperPaxGDP = TotalCostGDP/totalPax;
    CostperPaxGHP = TotalCostGHP/totalPax;

    %Maximum cost per passenger on RBS
    i = 1;
    while i <= length(GroundCostRBS)
        if i == 1
            maxCostpaxGRBS = GroundCostRBS(i, 2)/(Seats(GroundCostRBS(i, 1)));
        end
        if (GroundCostRBS(i, 2)/(Seats(GroundCostRBS(i, 1)))) > maxCostpaxGRBS
            maxCostpaxGRBS = (GroundCostRBS(i, 2)/(Seats(GroundCostRBS(i, 1))));
        end
        i=i+1;
    end

    i = 1;
    while i <= length(AirCostRBS)
        if i == 1
            maxCostpaxARBS = AirCostRBS(i, 2)/(Seats(AirCostRBS(i, 1)));
        end
        if (AirCostRBS(i, 2)/(Seats(AirCostRBS(i, 1)))) > maxCostpaxARBS
            maxCostpaxARBS = (AirCostRBS(i, 2)/(Seats(AirCostRBS(i, 1))));
        end
        i = i+1;
    end

    m = [maxCostpaxARBS, maxCostpaxGRBS];
    maxCostpaxRBS = max(m);
    
    %Maximum Cost per passenger on GDP

    i = 1;
    while i <= length(GroundCostGDP)
        if i == 1
            maxCostpaxGGDP = GroundCostGDP(i, 2)/(Seats(GroundCostGDP(i, 1)));
        end
        if (GroundCostGDP(i, 2)/(Seats(GroundCostGDP(i, 1)))) > maxCostpaxGGDP
            maxCostpaxGGDP = (GroundCostGDP(i, 2)/(Seats(GroundCostGDP(i, 1))));
        end
        i=i+1;
    end

    i = 1;
    while i <= length(AirCostGDP)
        if i == 1
            maxCostpaxAGDP = AirCostGDP(i, 2)/(Seats(AirCostGDP(i, 1)));
        end
        if (AirCostGDP(i, 2)/(Seats(AirCostGDP(i, 1)))) > maxCostpaxAGDP
            maxCostpaxAGDP = (AirCostGDP(i, 2)/(Seats(AirCostGDP(i, 1))));
        end
        i = i+1;
    end

    m = [maxCostpaxAGDP, maxCostpaxGGDP];
    maxCostpaxGDP = max(m);

    %Max cost per pax GHP

    i = 1;
    while i<= length(costvectorGHP)
        if i == 1
            maxCostpaxGHP = (costvectorGHP(i, 2)/(Seats(costvectorGHP(i, 1))));
        end
        if (costvectorGHP(i, 2)/(Seats(costvectorGHP(i, 1)))) > maxCostpaxGHP
            maxCostpaxGHP = (costvectorGHP(i, 2)/(Seats(costvectorGHP(i, 1))));
        end
        i= i+1;
    end
        
    refundsRBS = 0;
    refundsGDP = 0;
    refundsGHP = 0;
    
    %Number of flights with more than 180 minutes of delay un RBS
    i = 1;
    while i <= length(GroundDelayRBS)
        if GroundDelayRBS(i, 2) > 180
            refundsRBS = refundsRBS + 1;
        end
        i = i+1;
    end

    %Number of flights with more than 180 minutes of delay un GDP
    i = 1;
    while i <= length(GroundDelayGDP)
        if GroundDelayGDP(i, 2) > 180
            refundsGDP = refundsGDP + 1;
        end
        i = i+1;
    end

    %Number of flights with more than 180 minutes of delay un GHP
    i = 1;
    while i <= length(GroundDelayGHP)
        if GroundDelayGHP(i, 2) > 180
            refundsGHP = refundsGHP + 1;
        end
        i = i+1;
    end

    %Average kg of CO2 per pax in RBS
    avgempaxRBS = DelayEmissionsRBS/totalPax;
    %Average kg of CO2 per pax in GDP
    avgempaxGDP = DelayEmissionsGDP/totalPax;
    %Average kg of CO2 per pax in GHP
    avgempaxGHP = DelayEmissionsGHP/totalPax;

    %Average kg of CO2 emited per Flight on each solution
    avgemflightRBS = DelayEmissionsRBS / length(ControlledGHP);
    avgemflightGDP = DelayEmissionsGDP / length(ControlledGHP);
    avgemflightGHP = DelayEmissionsGHP / length(ControlledGHP);
    
end