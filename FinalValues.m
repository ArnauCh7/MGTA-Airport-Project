function FinalValues(TotalGroundDelayRBS,GroundDelayRBS, TotalAirDelayRBS, AirDelayRBS, TotalDelayRBS, TotalCostRBS, TotalAirCostRBS, TotalGroundCostRBS, TotalGroundDelayGDP, GroundDelayGDP, TotalAirDelayGDP, AirDelayGDP, TotalDelayGDP,TotalCostGDP, TotalAirCostGDP, TotalGroundCostGDP, TotalGroundDelayGHP, GroundDelayGHP, TotalAirDelayGHP, AirDelayGHP, TotalDelayGHP, TotalCostGHP, TotalAirCostGHP, TotalGroundCostGHP,  TravelEmissions, TotalEmissionsRBS, TotalEmissionsGDP, TotalEmissionsGHP, DelayEmissionsRBS, DelayEmissionsGDP, DelayEmissionsGHP, AirEmissionsRBS, GroundEmissionsRBS, AirEmissionsGDP, GroundEmissionsGDP, AirEmissionsGHP, GroundEmissionsGHP, CostperPaxRBS,CostperPaxGDP, CostperPaxGHP, maxCostpaxRBS, maxCostpaxGDP, maxCostpaxGHP,refundsRBS, refundsGDP, refundsGHP, avgempaxRBS, avgempaxGDP, avgempaxGHP, avgemflightRBS, avgemflightGDP, avgemflightGHP )

    
    %RBS
    fprintf("\n\n========= RBS =========\n");
    fprintf("Total Delay  %g min\n", TotalDelayRBS);
    fprintf("Total Cost %g €\n", TotalCostRBS);
    fprintf("Total Emissions %g kg of CO2\n", TotalEmissionsRBS);
    fprintf("Average Cost per passenger %g €\n", CostperPaxRBS);
    fprintf("Max Cost per passenger %g €\n", maxCostpaxRBS);
    fprintf("Number of flights with compensations %g\n", refundsRBS);
    fprintf("Average emissions per passenger %g kg of CO2\n", avgempaxRBS);
    fprintf("Average emissions per flight %g kg of CO2\n", avgemflightRBS);

    %Ground delay
    MaxGD = max(GroundDelayRBS(:,2));
    AverageGD = TotalGroundDelayRBS/length(GroundDelayRBS);
    NumberGD = length(GroundDelayRBS);
    StdGD = std(GroundDelayRBS(:,2))*sqrt((NumberGD-1)/NumberGD);
    fprintf("===== Ground Delay =====\n");
    fprintf("Total ground delay %g min\n", TotalGroundDelayRBS);
    fprintf("Max Ground Delay %g min\n", MaxGD);
    fprintf("Average Ground Delay %g min\n", AverageGD);
    fprintf("Standard Deviation of the Ground Delay %g\n", StdGD);
    fprintf("Number of flights affected %g \n", NumberGD);

    i=1;
    larger15GRBS = 0;
    while i <= length(GroundDelayRBS)
        if GroundDelayRBS(i, 2) > 15
            larger15GRBS = larger15GRBS + 1;
        end
        i = i+1;
    end
    fprintf("Number of flights with delay larger than 15: %g\n", larger15GRBS);
    fprintf("Total cost of Ground delay %g €\n", TotalGroundCostRBS);
    fprintf("Ground Delay Emissions %g kg of CO2\n", GroundEmissionsRBS);


    %Air delay
    MaxAD = max(AirDelayRBS(:,2));
    AverageAD = TotalAirDelayRBS/length(AirDelayRBS);
    NumberAD = length(AirDelayRBS);
    StdAD = std(AirDelayRBS(:,2))*sqrt((NumberAD-1)/NumberAD);

    fprintf("===== Air Delay =====\n");
    fprintf("Total air delay %g min\n", TotalAirDelayRBS);
    fprintf("Max Air Delay %g min\n", MaxAD);
    fprintf("Average Air Delay %g min\n", AverageAD);
    fprintf("Standard Deviation of the Air Delay %g\n", StdAD);
    fprintf("Number of flights affected %g\n", NumberAD);

    i=1;
    larger15ARBS = 0;
    while i <= length(AirDelayRBS)
        if AirDelayRBS(i, 2) > 15
            larger15ARBS = larger15ARBS + 1;
        end
        i = i+1;
    end
    fprintf("Number of flights with delay larger than 15: %g \n", larger15ARBS);
    fprintf("Total cost of Air delay %g €\n", TotalAirCostRBS);
    fprintf("Air Delay Emissions %g kg of CO2\n", AirEmissionsRBS);
    


    %GDP
    fprintf("\n\n========= GDP =========\n");
    fprintf("Total Delay %g min \n", TotalDelayGDP);
    fprintf("Total Cost %g €\n", TotalCostGDP);
    fprintf("Total Emissions %g kg of CO2\n", TotalEmissionsGDP);
    fprintf("Average Cost per passenger %g €\n", CostperPaxGDP);
    fprintf("Max Cost per passenger %g €\n", maxCostpaxGDP);
    fprintf("Number of flights with compensations %g\n", refundsGDP);
    fprintf("Average emissions per passenger %g kg of CO2\n", avgempaxGDP);
    fprintf("Average emissions per flight %g kg of CO2\n", avgemflightGDP);

    %Ground delay
    MaxGD_GDP = max(GroundDelayGDP(:, 2));
    AverageGD_GDP = TotalGroundDelayGDP/length(GroundDelayGDP);
    NumberGD_GDP = length(GroundDelayGDP);
    StdGD_GDP = std(GroundDelayGDP(:,2))*sqrt((NumberGD_GDP-1)/NumberGD_GDP);

    fprintf("===== Ground Delay =====\n");
    fprintf("Total ground delay %g min\n", TotalGroundDelayGDP);
    fprintf("Max Ground Delay %g min\n", MaxGD_GDP);
    fprintf("Average Ground Delay %g min\n", AverageGD_GDP);
    fprintf("Standard Deviation of the Ground Delay %g\n", StdGD_GDP);
    fprintf("Number of flights affected %g \n", NumberGD_GDP);

    i=1;
    larger15GGDP = 0;
    while i <= length(GroundDelayGDP)
        if GroundDelayGDP(i, 2) > 15
            larger15GGDP = larger15GGDP + 1;
        end
        i = i+1;
    end

    fprintf("Number of flights with delay larger than 15: %g \n", larger15GGDP);
    fprintf("Total cost of Ground delay %g €\n", TotalGroundCostGDP);
    fprintf("Ground Delay Emissions %g kg of CO2\n", GroundEmissionsGDP);

    %Air delay
    MaxAD_GDP = max(AirDelayGDP(:,2));
    AverageAD_GDP = TotalAirDelayGDP/length(AirDelayGDP);
    NumberAD_GDP = length(AirDelayGDP);
    StdAD_GDP = std(AirDelayGDP(:,2))*sqrt((NumberAD_GDP-1)/NumberAD_GDP);

    fprintf("===== Air Delay =====\n");
    fprintf("Total air delay %g min\n", TotalAirDelayGDP);
    fprintf("Max Air Delay %g min\n", MaxAD_GDP);
    fprintf("Average Air Delay %g min\n", AverageAD_GDP);
    fprintf("Standard Deviation of the Air Delay %g\n", StdAD_GDP);
    fprintf("Number of flights affected %g\n", NumberAD_GDP);

    i=1;
    larger15AGDP = 0;
    while i <= length(AirDelayGDP)
        if AirDelayGDP(i, 2) > 15
            larger15AGDP = larger15AGDP + 1;
        end
        i = i+1;
    end
    fprintf("Number of flights with delay larger than 15: %g \n", larger15AGDP);
    fprintf("Total cost of Air delay %g €\n", TotalAirCostGDP);
    fprintf("Air Delay Emissions %g kg of CO2\n", AirEmissionsGDP);

    %GHP
    fprintf("\n\n========= GHP =========\n");
    fprintf("Total Delay  %g min\n", TotalDelayGHP);
    fprintf("Total Cost %g €\n", TotalCostGHP);
    fprintf("Total Emissions %g kg of CO2\n", TotalEmissionsGHP);
    fprintf("Average Cost per passenger %g €\n", CostperPaxGHP);
    fprintf("Max Cost per passenger %g €\n", maxCostpaxGHP);
    fprintf("Number of flights with compensations %g\n", refundsGHP);
    fprintf("Average emissions per passenger %g kg of CO2\n", avgempaxGHP);
    fprintf("Average emissions per flight %g kg of CO2\n", avgemflightGHP);

    %Ground delay
    MaxGD_GHP = max(GroundDelayGHP(:, 2));
    AverageGD_GHP = TotalGroundDelayGHP/length(GroundDelayGHP);
    NumberGD_GHP = length(GroundDelayGHP);
    StdGD_GHP = std(GroundDelayGHP(:,2))*sqrt((NumberGD_GHP-1)/NumberGD_GHP);

    fprintf("===== Ground Delay =====\n");
    fprintf("Total ground delay %g min\n", TotalGroundDelayGHP);
    fprintf("Max Ground Delay %g min\n", MaxGD_GHP);
    fprintf("Average Ground Delay %g min\n", AverageGD_GHP);
    fprintf("Standard Deviation of the Ground Delay %g\n", StdGD_GHP);
    fprintf("Number of flights affected %g \n", NumberGD_GHP);

    i=1;
    larger15GGHP = 0;
    while i <= length(GroundDelayGHP)
        if GroundDelayGHP(i, 2) > 15
            larger15GGHP = larger15GGHP + 1;
        end
        i = i+1;
    end
    fprintf("Number of flights with delay larger than 15: %g \n", larger15GGHP);
    fprintf("Total cost of Ground delay %g €\n", TotalGroundCostGHP);
    fprintf("Ground Delay Emissions %g kg of CO2\n", GroundEmissionsGHP);

    %Air delay
    MaxAD_GHP = max(AirDelayGHP(:,2));
    AverageAD_GHP = TotalAirDelayGHP/length(AirDelayGHP);
    NumberAD_GHP = length(AirDelayGHP);
    StdAD_GHP = std(AirDelayGHP(:,2))*sqrt((NumberAD_GHP-1)/NumberAD_GHP);

    fprintf("===== Air Delay =====\n");
    fprintf("Total air delay %g min\n", TotalAirDelayGHP);
    fprintf("Max Air Delay %g min\n", MaxAD_GHP);
    fprintf("Average Air Delay %g min\n", AverageAD_GHP);
    fprintf("Standard Deviation of the Air Delay %g\n", StdAD_GHP);
    fprintf("Number of flights affected %g\n", NumberAD_GHP);

    i=1;
    larger15AGHP = 0;
    while i <= length(AirDelayGHP)
        if AirDelayGHP(i, 2) > 15
            larger15AGHP = larger15AGHP + 1;
        end
        i = i+1;
    end
    fprintf("Number of flights with delay larger than 15: %g \n", larger15AGHP);
    fprintf("Total cost of Air delay %g €\n", TotalAirCostGHP);
    fprintf("Air Delay Emissions %g kg of CO2\n", AirEmissionsGHP);

    fprintf("\n\n========= Travel =========\n");
    fprintf("Travel Emissions %g kg of CO2\n", TravelEmissions);

end