function slots  = computeSlots(Hstart, Hend, HNoReg, PAAR, AAR)
%This creates a vector of the starting hour of each new slot
    %filename = 'taulaDades.xlsx';
    %T = readtable(filename);

    slots = [];
    i=0;
    while i< 1440
        if i >= Hstart && i < Hend
            slots(end+1, :) = [i+(60/PAAR) 0];
            i = i+3;
        else
            slots(end+1, :) = [i+(60/AAR) 0];
            i = i+2;
        end
    end
end
    
%     slotallocation = [];
%     n=0;
%     for slot = reducedSlots
%         j = 1+n;
%         filled_slot = 0;
%         while j < length(T.HMIN)
%             if filled_slot ~=1
%                 if T.HMIN(j) <= slot
%                     line = [slot j];
%                     slotallocation(end+1, :) = line;
%                     filled_slot = 1;
%                     n=n+1;%when a flight is set to a slot the next check will start after that flight
%                 end
%             end
%             j = j+1;
%         end
%         if filled_slot ~= 1
%             slotallocation(end+1, :) = [slot 0];
%         end
%     end
%     slots = slotallocation;
