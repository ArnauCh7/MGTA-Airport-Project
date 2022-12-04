function ParameterChangesPlots_GDP_continuous(ETA, ETD, Distances, International, Hstart, Hend, HNoReg, StartSlotIndex, EndSlotIndex, PAAR, AAR)

    slots  = computeSlots(Hstart, Hend, HNoReg, PAAR, AAR);
    
    %We change the radius of exemption with our original Hfile = 7:00 h
    Hfile = 420;

    %Radius = 0 km
    i = 600;
    RadiusVector = zeros(1901,1);
    GroundVector = zeros (1901,1);
    AirVector = zeros (1901,1);
    UnrecVector = zeros (1901,1);

    while i <= 2500
        radius = i;

        [NotAffectedGDP, ExemptRadius, ExemptInternational, ExemptFlying, Exempt, ControlledGDP] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
        slotsGDP = assignSlotsGDP(slots, ControlledGDP, Exempt, ETA);
        [CTA_GDP, GroundDelayGDP, AirDelayGDP, TotalGroundDelayGDP, TotalAirDelayGDP] = computeCTA_GDP(ETA, ETD, slotsGDP, StartSlotIndex, EndSlotIndex, Hfile);
        CTD_GDP = computeCTD_GDP(ETD, GroundDelayGDP, CTA_GDP);
        UnrecDelay = ComputeUnrecoverableDelay(CTD_GDP, ETD, Hfile, Hstart, GroundDelayGDP);
        
        RadiusVector(i-599) = i;
        GroundVector(i-599) = TotalGroundDelayGDP;
        AirVector(i-599) = TotalAirDelayGDP;
        UnrecVector(i-599) = UnrecDelay;

        i = i + 1;
    end
    
    x = [600 1000 1400 1800 2200];
    y = [AirVector(1) GroundVector(1) UnrecVector(1); AirVector(401) GroundVector(401) UnrecVector(401); AirVector(801) GroundVector(801) UnrecVector(801); AirVector(1201) GroundVector(1201) UnrecVector(1201); AirVector(1601) GroundVector(1601) UnrecVector(1601)]; 
    b1 = bar(x,y);

    hold on

    plot(RadiusVector,AirVector, LineWidth=3), ;
    hold on
    plot(RadiusVector,GroundVector, LineWidth=3);
    hold on
    plot(RadiusVector,UnrecVector, LineWidth=3);
    hold on
    xlabel("Radius [km]")
    ylabel("Delay [min]")
    ylim([600 2500])
    ylim([0 15000])

%     xtips1 = b(1).XEndPoints;
%     ytips1 = b(1).YEndPoints;
%     labels1 = string(b(1).YData);
%     text(xtips1, ytips1, labels1, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')
%     xtips2 = b(2).XEndPoints;
%     ytips2 = b(2).YEndPoints;
%     labels2 = string(b(2).YData);
%     text(xtips2, ytips2, labels2, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')
%     xtips3 = b(3).XEndPoints;
%     ytips3 = b(3).YEndPoints;
%     labels3 = string(b(3).YData);
%     text(xtips3, ytips3, labels3, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')

    legend("Air", "Ground", "Unrecoverable")
     
end