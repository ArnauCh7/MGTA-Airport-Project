function [CTA_RBS, GroundDelayRBS, AirDelayRBS, TotalAirDelayRBS, TotalGroundDelayRBS] = computeCTA(ETA, GroundDelay, AirDelay, HNoReg, HStart)  
    CTA_RBS = zeros(length(ETA), 1);  %GD i AD maxim arriben a 429      CTA a 435
    i = 1;
    j = 1;
    k = 1;
    GroundDelayRBS = [];
    AirDelayRBS = [];
    TotalAirDelayRBS = 0;
    TotalGroundDelayRBS = 0;
    
    while i <= length(CTA_RBS)
        if i == GroundDelay(j,1) && j < length(GroundDelay)
            CTA_RBS(i) = ETA(i) + GroundDelay(j,2);
            j = j + 1;
        elseif i == AirDelay(k,1) && k < length(AirDelay)
            CTA_RBS(i) = ETA(i) + AirDelay(k,2);
            k = k + 1;
        else 
            CTA_RBS(i) = -1; %els avions que arriben el dia seguent tenen un -1
        end
        i = i + 1;
    end

    for n = GroundDelay'
        if ETA(n(1)) >= HStart && ETA(n(1)) < HNoReg
            GroundDelayRBS(end+1, :) = n';
        end
    end

    for n = AirDelay'
        if ETA(n(1)) >= HStart && ETA(n(1)) < HNoReg
            AirDelayRBS(end+1, :) = n';
        end
    end

    for i = GroundDelayRBS'
        TotalGroundDelayRBS = TotalGroundDelayRBS + i(2);
    end

    for i = AirDelayRBS'
         TotalAirDelayRBS = TotalAirDelayRBS + i(2);
    end
end