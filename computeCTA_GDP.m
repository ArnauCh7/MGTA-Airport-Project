function [CTA_GDP, GroundDelayGDP, AirDelayGDP, TotalGroundDelayGDP, TotalAirDelayGDP,TotalDelayGDP] = computeCTA_GDP(ETA, ETD, slotsGDP, Hfile)
    GDPslots = slotsGDP';
    CTA_GDP = [];
    GroundDelayGDP = [];
    AirDelayGDP = [];
    TotalGroundDelayGDP = 0;
    TotalAirDelayGDP = 0;

    for i = GDPslots
        if i(2) ~= 0
            line = [i(2) i(1)];
            CTA_GDP(end+1, :) = line;
        end
    end

    for i = CTA_GDP'
        if ETD(i(1)) < Hfile && ETA(i(1)) > Hfile
            AirDelayGDP(end+1, :) = [i(1) i(2)-ETA(i(1))];
        else
            GroundDelayGDP(end+1, :) = [i(1) i(2)-ETA(i(1))];
        end
    end

    for i = GroundDelayGDP'
        TotalGroundDelayGDP = TotalGroundDelayGDP + i(2);
    end
    for i = AirDelayGDP'
         TotalAirDelayGDP = TotalAirDelayGDP + i(2);
    end
    TotalDelayGDP = TotalAirDelayGDP + TotalGroundDelayGDP;
end