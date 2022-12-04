function [slotsRBS, GroundDelay, AirDelay] = assignSlotsRBS(slots, ControlledRBS, ETA, ETD, Hfile)
    slotallocation = [];
    reducedslots = slots(:,1)';
    
    n=0;
    for i = reducedslots
        j = 1+n;
        filled_slot = 0;
        while j < length(ETA)
            if filled_slot ~=1
                if ETA(j) <= i
                    line = [i j];
                    slotallocation(end+1, :) = line;
                    filled_slot = 1;
                    n=n+1;%when a flight is set to a slot the next check will start after that flight
                end
            end
            j = j+1;
        end
        if filled_slot ~= 1
            slotallocation(end+1, :) = [i 0];
        end
    end
    slotsRBS = slotallocation;



%     AirDelay = [];
%     GroundDelay = [];
%     for i = slotsRBS(270:489, :)'
%         if ETD(i(2)) < Hfile && ETA(i(2)) > Hfile
%             AirDelay(end+1, :) = [i(2) i(1)-ETA(i(2))];
%         else
%             GroundDelay(end+1, :) = [i(2) i(1)-ETA(i(2))];
%         end
%     end

    GroundPositions = [];
    AirPositions = [];
    m = 1;
    while m <= length(ETD)
        if ETD(m) < Hfile && ETA(m) > Hfile
            AirPositions(end+1) = m;
        else
            GroundPositions(end+1) = m;
        end
        m = m+1;
    end

   AirDelay = [];
   GroundDelay = [];
    i=1;
    while i < length(reducedslots)
        j = 1;
        while j <= length(GroundPositions)
            if GroundPositions(j) == slotsRBS(i,2)
                delay1 = slotsRBS(i,1) - ETA(GroundPositions(j));
                GroundDelay(end+1, :) = [GroundPositions(j) delay1];
            end
            j=j+1;
        end
        z=1;
        while z<=length(AirPositions)
            if AirPositions(z) == slotsRBS(i,2)
                delay2 = slotsRBS(i,1) - ETA(AirPositions(z));
                AirDelay(end+1, :) = [AirPositions(z) delay2];
            end
            z=z+1;
        end
        i=i+1;
    end
    
end