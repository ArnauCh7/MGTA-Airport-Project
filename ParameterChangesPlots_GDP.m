function ParameterChangesPlots_GDP(ETA, ETD, Distances, International, Hstart, Hend, HNoReg, StartSlotIndex, EndSlotIndex, PAAR, AAR)

    slots  = computeSlots(Hstart, Hend, HNoReg, PAAR, AAR);
    
    %We change the radius of exemption with our original Hfile = 7:00 h
    Hfile = 420;

    %Radius = 0 km
    radius = 0;
    [NotAffectedGDP0, ExemptRadius0, ExemptInternational0, ExemptFlying0, Exempt0, ControlledGDP0] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP0 = assignSlotsGDP(slots, ControlledGDP0, Exempt0, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP0, GroundDelayGDP0, AirDelayGDP0, TotalGroundDelayGDP0, TotalAirDelayGDP0] = computeCTA_GDP(ETA, ETD, slotsGDP0, Hfile);
    CTD_GDP0 = computeCTD_GDP(ETD, GroundDelayGDP0, CTA_GDP0);
    UnrecDelay0 = ComputeUnrecoverableDelay(CTD_GDP0, ETD, Hfile, Hstart, GroundDelayGDP0);

    %Radius = 1000 km
    radius = 1000;
    [NotAffectedGDP1000, ExemptRadius1000, ExemptInternational1000, ExemptFlying1000, Exempt1000, ControlledGDP1000] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP1000 = assignSlotsGDP(slots, ControlledGDP1000, Exempt1000, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP1000, GroundDelayGDP1000, AirDelayGDP1000, TotalGroundDelayGDP1000, TotalAirDelayGDP1000] = computeCTA_GDP(ETA, ETD, slotsGDP1000, Hfile);
    CTD_GDP1000 = computeCTD_GDP(ETD, GroundDelayGDP1000, CTA_GDP1000);
    UnrecDelay1000 = ComputeUnrecoverableDelay(CTD_GDP1000, ETD, Hfile, Hstart, GroundDelayGDP1000);

    %Radius = 2000 km (Ours)
    radius = 2000;
    [NotAffectedGDP2000, ExemptRadius2000, ExemptInternational2000, ExemptFlying2000, Exempt2000, ControlledGDP2000] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP2000 = assignSlotsGDP(slots, ControlledGDP2000, Exempt2000, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP2000, GroundDelayGDP2000, AirDelayGDP2000, TotalGroundDelayGDP2000, TotalAirDelayGDP2000] = computeCTA_GDP(ETA, ETD, slotsGDP2000, Hfile);
    CTD_GDP2000 = computeCTD_GDP(ETD, GroundDelayGDP2000, CTA_GDP2000);
    UnrecDelay2000 = ComputeUnrecoverableDelay(CTD_GDP2000, ETD, Hfile, Hstart, GroundDelayGDP2000);

    %Radius = 4000 km
    radius = 4000;
    [NotAffectedGDP4000, ExemptRadius4000, ExemptInternational4000, ExemptFlying4000, Exempt4000, ControlledGDP4000] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP4000 = assignSlotsGDP(slots, ControlledGDP4000, Exempt4000, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP4000, GroundDelayGDP4000, AirDelayGDP4000, TotalGroundDelayGDP4000, TotalAirDelayGDP4000] = computeCTA_GDP(ETA, ETD, slotsGDP4000, Hfile);
    CTD_GDP4000 = computeCTD_GDP(ETD, GroundDelayGDP4000, CTA_GDP4000);
    UnrecDelay4000 = ComputeUnrecoverableDelay(CTD_GDP4000, ETD, Hfile, Hstart, GroundDelayGDP4000);

    %Radius = 8000 km
    radius = 8000;
    [NotAffectedGDP8000, ExemptRadius8000, ExemptInternational8000, ExemptFlying8000, Exempt8000, ControlledGDP8000] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP8000 = assignSlotsGDP(slots, ControlledGDP8000, Exempt8000, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP8000, GroundDelayGDP8000, AirDelayGDP8000, TotalGroundDelayGDP8000, TotalAirDelayGDP8000] = computeCTA_GDP(ETA, ETD, slotsGDP8000, Hfile);
    CTD_GDP8000 = computeCTD_GDP(ETD, GroundDelayGDP8000, CTA_GDP8000);
    UnrecDelay8000 = ComputeUnrecoverableDelay(CTD_GDP8000, ETD, Hfile, Hstart, GroundDelayGDP8000);

    %We plot all the computed results
    figure
    x = categorical({'0','1000','2000','4000', '8000'});
    y = [TotalAirDelayGDP0 TotalGroundDelayGDP0 UnrecDelay0; TotalAirDelayGDP1000 TotalGroundDelayGDP1000 UnrecDelay1000; TotalAirDelayGDP2000 TotalGroundDelayGDP2000 UnrecDelay2000; TotalAirDelayGDP4000 TotalGroundDelayGDP4000 UnrecDelay4000; TotalAirDelayGDP8000 TotalGroundDelayGDP8000 UnrecDelay8000];
    b = bar(x, y);
    ylabel("Number of planes")
    xlabel("Radius [km]")
    ylim([0 15000])
    legend("Air delay", "Ground delay", "Unrecoverable delay");
    hold on

    xtips1 = b(1).XEndPoints;
    ytips1 = b(1).YEndPoints;
    labels1 = string(b(1).YData);
    text(xtips1, ytips1, labels1, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')
    xtips2 = b(2).XEndPoints;
    ytips2 = b(2).YEndPoints;
    labels2 = string(b(2).YData);
    text(xtips2, ytips2, labels2, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')
    xtips3 = b(3).XEndPoints;
    ytips3 = b(3).YEndPoints;
    labels3 = string(b(3).YData);
    text(xtips3, ytips3, labels3, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')



    %We change the Hfile with our original radius = 2000 km
    radius = 2000;

    %Hfile = 5:00 (4 h before Hstart)
    Hfile = 300;
    [NotAffectedGDP300, ExemptRadius300, ExemptInternational300, ExemptFlying300, Exempt300, ControlledGDP300] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP300 = assignSlotsGDP(slots, ControlledGDP300, Exempt300, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP300, GroundDelayGDP300, AirDelayGDP300, TotalGroundDelayGDP300, TotalAirDelayGDP300] = computeCTA_GDP(ETA, ETD, slotsGDP300, Hfile);
    CTD_GDP300 = computeCTD_GDP(ETD, GroundDelayGDP300, CTA_GDP300);
    UnrecDelay300 = ComputeUnrecoverableDelay(CTD_GDP300, ETD, Hfile, Hstart, GroundDelayGDP300);

    %Hfile = 6:00 (3 h before Hstart)
    Hfile = 360;
    [NotAffectedGDP360, ExemptRadius360, ExemptInternational360, ExemptFlying360, Exempt360, ControlledGDP360] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP360 = assignSlotsGDP(slots, ControlledGDP360, Exempt360, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP360, GroundDelayGDP360, AirDelayGDP360, TotalGroundDelayGDP360, TotalAirDelayGDP360] = computeCTA_GDP(ETA, ETD, slotsGDP360, Hfile);
    CTD_GDP360 = computeCTD_GDP(ETD, GroundDelayGDP360, CTA_GDP360);
    UnrecDelay360 = ComputeUnrecoverableDelay(CTD_GDP360, ETD, Hfile, Hstart, GroundDelayGDP360);

    %Hfile = 7:00 (2 h before Hstart) (Ours)
    Hfile = 420;
    [NotAffectedGDP420, ExemptRadius420, ExemptInternational420, ExemptFlying420, Exempt420, ControlledGDP420] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP420 = assignSlotsGDP(slots, ControlledGDP420, Exempt420, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP420, GroundDelayGDP420, AirDelayGDP420, TotalGroundDelayGDP420, TotalAirDelayGDP420] = computeCTA_GDP(ETA, ETD, slotsGDP420, Hfile);
    CTD_GDP420 = computeCTD_GDP(ETD, GroundDelayGDP420, CTA_GDP420);
    UnrecDelay420 = ComputeUnrecoverableDelay(CTD_GDP420, ETD, Hfile, Hstart, GroundDelayGDP420);

    %Hfile = 8:00 (1 h before Hstart)
    Hfile = 480;
    [NotAffectedGDP480, ExemptRadius480, ExemptInternational480, ExemptFlying480, Exempt480, ControlledGDP480] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP480 = assignSlotsGDP(slots, ControlledGDP480, Exempt480, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP480, GroundDelayGDP480, AirDelayGDP480, TotalGroundDelayGDP480, TotalAirDelayGDP480] = computeCTA_GDP(ETA, ETD, slotsGDP480, Hfile);
    CTD_GDP480 = computeCTD_GDP(ETD, GroundDelayGDP480, CTA_GDP480);
    UnrecDelay480 = ComputeUnrecoverableDelay(CTD_GDP480, ETD, Hfile, Hstart, GroundDelayGDP480);

    %Hfile = 9:00 (0 h before Hstart)
    Hfile = 540;
    [NotAffectedGDP540, ExemptRadius540, ExemptInternational540, ExemptFlying540, Exempt540, ControlledGDP540] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
    slotsGDP540 = assignSlotsGDP(slots, ControlledGDP540, Exempt540, ETA, StartSlotIndex, EndSlotIndex);
    [CTA_GDP540, GroundDelayGDP540, AirDelayGDP540, TotalGroundDelayGDP540, TotalAirDelayGDP540] = computeCTA_GDP(ETA, ETD, slotsGDP540, Hfile);
    CTD_GDP540 = computeCTD_GDP(ETD, GroundDelayGDP540, CTA_GDP540);
    UnrecDelay540 = ComputeUnrecoverableDelay(CTD_GDP540, ETD, Hfile, Hstart, GroundDelayGDP540);

    %We plot all the computed results
    figure
    x = categorical({'5:00','6:00','7:00','8:00', '9:00'});
    y = [TotalAirDelayGDP300 TotalGroundDelayGDP300 UnrecDelay300; TotalAirDelayGDP360 TotalGroundDelayGDP360 UnrecDelay360; TotalAirDelayGDP420 TotalGroundDelayGDP420 UnrecDelay420; TotalAirDelayGDP480 TotalGroundDelayGDP480 UnrecDelay480; TotalAirDelayGDP540 TotalGroundDelayGDP540 UnrecDelay540];
    b2 = bar(x, y);
    ylabel("Number of planes")
    xlabel("Hfile [h:min]")
    ylim([0 15000])
    legend("Air delay", "Ground delay", "Unrecoverable delay");
    hold on

    xtips1 = b2(1).XEndPoints;
    ytips1 = b2(1).YEndPoints;
    labels1 = string(b2(1).YData);
    text(xtips1, ytips1, labels1, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')
    xtips2 = b2(2).XEndPoints;
    ytips2 = b2(2).YEndPoints;
    labels2 = string(b2(2).YData);
    text(xtips2, ytips2, labels2, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')
    xtips3 = b2(3).XEndPoints;
    ytips3 = b2(3).YEndPoints;
    labels3 = string(b2(3).YData);
    text(xtips3, ytips3, labels3, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')

    
    % Parameters with our original radius and Hfile

    % Ground delay
    TotalGD = TotalGroundDelayGDP2000;
    MaxGD = max(GroundDelayGDP2000(:,2));
    AverageGD = TotalGD/length(GroundDelayGDP2000);
    StdGD = std(GroundDelayGDP2000(:,2));
    NumberGD = length(GroundDelayGDP2000);
    fprintf("========= GDP =========\n");
    fprintf("===== Ground Delay =====\n");
    fprintf("Max Ground Delay %g min\n", MaxGD);
    fprintf("Average Ground Delay %g min\n", AverageGD);
    fprintf("Standard Deviation of the Ground Delay %g\n", StdGD);
    fprintf("Number of flights affected %g\n", NumberGD);

    i = 1;
    NumberGDOver15 = 0;

    while i <= length(GroundDelayGDP2000)
        if GroundDelayGDP2000(i,2) > 15
            NumberGDOver15 = NumberGDOver15 + 1;
        end
        i = i + 1;
    end

    % Air delay
    TotalAD = TotalAirDelayGDP2000;
    MaxAD = max(AirDelayGDP2000(:,2));
    AverageAD = TotalAD/length(AirDelayGDP2000);
    StdAD = std(AirDelayGDP2000(:,2));
    NumberAD = length(AirDelayGDP2000);

    fprintf("===== Air Delay =====\n");
    fprintf("Total air delay %g min\n", TotalAD);
    fprintf("Max Air Delay %g min\n", MaxAD);
    fprintf("Average Air Delay %g min\n", AverageAD);
    fprintf("Standard Deviation of the Air Delay %g\n", StdAD);
    fprintf("Number of flights affected %g\n", NumberAD);

    i = 1;
    NumberADOver15 = 0;

    while i <= length(AirDelayGDP2000)
        if AirDelayGDP2000(i,2) > 15
            NumberADOver15 = NumberADOver15 + 1;
        end
        i = i + 1;
    end
end