function HfileDependentPlot(T,radius, slots, StartSlotIndex, EndSlotIndex, HNoReg, Hstart)
    x= 1:Hstart;
    yg = [];
    ya = [];
    yu = [];

    i = 0;
    while i < Hstart
        Hfile = i;
        [NotAffectedGDP, ExemptRadius, ExemptInternational, ExemptFlying, Exempt, ControlledGDP] = computeAircraftStatusGDP(T.ETA,T.ETD,T.Distance_km_,T.ECACAREA,Hfile,Hstart,HNoReg,radius);

        slotsGDP = assignSlotsGDP(slots, ControlledGDP, Exempt, T.ETA, StartSlotIndex, EndSlotIndex);
        [CTA_GDP, GroundDelayGDP, AirDelayGDP, TotalGroundDelayGDP, TotalAirDelayGDP] = computeCTA_GDP(T.ETA, T.ETD, slotsGDP, Hfile);
        CTD_GDP = computeCTD_GDP(T.ETD, GroundDelayGDP, CTA_GDP);
        
        UnrecDelay = ComputeUnrecoverableDelay(CTD_GDP, T.ETD, Hfile, Hstart, GroundDelayGDP);

        yg(end+1) = TotalGroundDelayGDP;
        ya(end+1) = TotalAirDelayGDP;
        yu(end+1) = UnrecDelay;

        i=i+1;
    end
    
    figure
    yyaxis left
    plot(x, yg);
    xlabel("Hfile [min]")
    ylabel("Delay [min]")

    yyaxis right
    plot(x, ya);
    hold on
    plot(x, yu);
    legend("Ground delay", "Air delay", "Unrecoverable delay");
    title("Delay Variation with Hfile");

end