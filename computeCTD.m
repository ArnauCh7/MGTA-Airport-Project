function CTD = computeCTD(ETD, GroundDelay)  
    CTD = zeros(length(ETD), 1);  %GD i AD maxim arriben a 429      CTA a 435
    i = 1;
    j = 1;

    while i <= length(CTD)
        if i == GroundDelay(j,1) && j < length(GroundDelay)
            CTD(i) = ETD(i) + GroundDelay(j,2);
            j = j + 1;
        else
            CTD(i) = ETD(i);
        end
        i = i + 1;
    end
end