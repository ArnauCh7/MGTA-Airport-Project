function threeDimPlots(ETA, ETD, Distances, International, Hstart, Hend, HNoReg, StartSlotIndex, EndSlotIndex, PAAR, AAR, slots)
    
    AirDelayMatrix = zeros(31, 55);
    GroundDelayMatrix = zeros(31, 55);
    UnrecDelayMatrix = zeros(31, 55);

    i = 0; %Radius up to 2000
    
    while i <= 3000
        radius = i;
        j = 0; %Hile up to 540 

        while j <= 540
            Hfile = j;
            
            [NotAffectedGDP, ExemptRadius, ExemptInternational, ExemptFlying, Exempt, ControlledGDP] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius);
            slotsGDP = assignSlotsGDP(slots, ControlledGDP, Exempt, ETA, StartSlotIndex, EndSlotIndex);
            [CTA_GDP, GroundDelayGDP, AirDelayGDP, TotalGroundDelayGDP, TotalAirDelayGDP] = computeCTA_GDP(ETA, ETD, slotsGDP, Hfile);
            CTD_GDP = computeCTD_GDP(ETD, GroundDelayGDP, CTA_GDP);
            UnrecDelay = ComputeUnrecoverableDelay(CTD_GDP, ETD, Hfile, Hstart, GroundDelayGDP);

            AirDelayMatrix(i/100 + 1, j/10 + 1) = TotalAirDelayGDP;
            GroundDelayMatrix(i/100 + 1, j/10 + 1) = TotalGroundDelayGDP;
            UnrecDelayMatrix(i/100 + 1, j/10 + 1) = UnrecDelay;

            j = j + 10;
        end
        
        i = i + 100;
    end
    x = [0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 310 320 330 340 350 360 370 380 390 400 410 420 430 440 450 460 470 480 490 500 510 520 530 540];
    y = [0 100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 28000 2900 3000];
    
    figure
    m1 = mesh(x,y,AirDelayMatrix);
    zlabel('Air delay [min]', FontSize=16)
    colormap("winter")

    xlabel('Hfile [min]', FontSize=16)
    xlim([0 540])

    ylabel('Radius [km]', FontSize=16)
    ylim([0 3000])

    figure  
    m2 =  mesh(x,y,GroundDelayMatrix);
    zlabel('Ground delay [min]', FontSize=16)
    colormap("winter")
  
    xlabel('Hfile [min]', FontSize=16)
    xlim([0 540])

    ylabel('Radius [km]', FontSize=16)
    ylim([0 3000])


    figure
    m3 = mesh(x,y,UnrecDelayMatrix);
    zlabel('Unrecoverable delay [min]', FontSize=16)
    colormap("winter")
    
    xlabel('Hfile [min]', FontSize=16)
    xlim([0 540])

    ylabel('Radius [km]', FontSize=16)
    ylim([0 3000])

end

