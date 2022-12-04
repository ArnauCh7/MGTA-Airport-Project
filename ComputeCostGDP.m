function [GroundCostGDP, AirCostGDP, TotalCostGDP, TotalAirCostGDP, TotalGroundCostGDP] = ComputeCostGDP(GroundDelayGDP,AirDelayGDP, Seats, Distances, radius, International)
    GroundCostGDP = [];
    AirCostGDP = [];
    lf = 0.823;
    
    
    i = 1;
    while i<= length(GroundDelayGDP)
        delay = GroundDelayGDP(i, 2);
        rfpass = 0.00563*delay + 0.122; %cost per minute per passenger
        costminpass = rfpass;
        cost = costminpass * Seats(GroundDelayGDP(i, 1)) * lf * delay;
        if International(GroundDelayGDP(i, 1)) == "YES" || Distances(GroundDelayGDP(i, 1)) > radius
            cost = cost*1.15;
        end
        if delay > 180
            if Distances(GroundDelayGDP(i, 1)) <= 1500
                cost = cost + 250 * 0.2 * lf * Seats(GroundDelayGDP(i, 1));
            elseif Distances(GroundDelayGDP(i, 1)) < 1500 && Distances(GroundDelayGDP(i, 1)) <= 3500
                cost = cost + 400 * 0.2 * lf * Seats(GroundDelayGDP(i, 1));
            elseif Distances(GroundDelayGDP(i, 1)) > 3500
                cost = cost + 600 * 0.2 * lf * Seats(GroundDelayGDP(i, 1));
            end
        end
        GroundCostGDP(end+1, :) = [GroundDelayGDP(i, 1) cost];
        i=i+1;
    end
    
    i = 1;
    while i<= length(AirDelayGDP)
        delay = AirDelayGDP(i, 2);
        rfpass = 0.00563*delay + 0.122; %cost per minute per passenger
        costminpass = rfpass + 0.376121;
        cost = costminpass * Seats(AirDelayGDP(i, 1)) * lf * delay;
        if International(AirDelayGDP(i, 1)) == "YES" || Distances(AirDelayGDP(i, 1)) > radius
            cost = cost*1.15;
        end
        AirCostGDP(end+1, :) = [AirDelayGDP(i, 1) cost];
        i=i+1;
    end
    
    i = 1;
    TotalAirCostGDP = 0;
    while i <= length(AirCostGDP)
        TotalAirCostGDP = TotalAirCostGDP + AirCostGDP(i, 2);
        i = i+1;
    end
    
    i = 1;
    TotalGroundCostGDP = 0;
    while i <= length(GroundCostGDP)
        TotalGroundCostGDP = TotalGroundCostGDP + GroundCostGDP(i, 2);
        i = i+1;
    end
    
    TotalCostGDP = TotalAirCostGDP + TotalGroundCostGDP;
end