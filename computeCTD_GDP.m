function CTD_GDP = computeCTD_GDP(ETD, GroundDelayGDP, CTA_GDP)  
    CTD_GDP = [];

    for i = CTA_GDP'
        j = 1;
        gd = 0;
        while j <= length(GroundDelayGDP)
            if i(1) == GroundDelayGDP(j, 1)
                gd = 1;
                CTD_GDP(end+1, :) = [i(1) ETD(i(1))+GroundDelayGDP(j, 2)];
            end
            j=j+1;
        end
        if gd ~= 1
            CTD_GDP(end+1, :) = [i(1) ETD(i(1))];
        end
    end

end