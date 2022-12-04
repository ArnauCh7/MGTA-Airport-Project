function slotsGDP = assignSlotsGDP(slots, ControlledGDP, Exempt, ETA, StartSlotIndex, EndSlotIndex)
    slotallocation = [];
    reducedslots = slots(:,1)';
    n=0;
    for i = reducedslots
        j = 1+n;
        filled_slot = 0;
        while j <= length(Exempt)
            if filled_slot ~=1
                if ETA(Exempt(j)) <= i
                    line = [i Exempt(j)];
                    slotallocation(end+1, :) = line;
                    filled_slot = 1;
                    n = n+1;%when a flight is set to a slot the next check will start after that flight
                end
            end
            j=j+1;
        end
        if filled_slot ~= 1
            slotallocation(end+1, :) = [i 0];
        end
    end

    slotsWithExempts = slotallocation;
    slotsGDP = [];
     n=0;
     for i = slotsWithExempts'
         j=1+n;
         while j <= length(ControlledGDP)
             if i(2) == 0
                 if ETA(ControlledGDP(j)) <= i(1)
                     i(2) = ControlledGDP(j);
                     n=n+1;
                 end
             end
             j=j+1;
         end
         slotsGDP(end+1, :) = i';
     end
    slotsGDP = slotsGDP(StartSlotIndex:EndSlotIndex, :);
end