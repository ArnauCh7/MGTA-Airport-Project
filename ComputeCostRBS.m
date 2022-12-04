function [GroundCostRBS, AirCostRBS, TotalCostRBS, TotalAirCostRBS, TotalGroundCostRBS] = ComputeCostRBS(GroundDelayRBS,AirDelayRBS, Seats, Distances, radius, International)

    GroundCostRBS = [];
    AirCostRBS = [];
    lf = 0.823;
    
    
    i = 1;
    while i<= length(GroundDelayRBS)
        delay = GroundDelayRBS(i, 2);
        rfpass = 0.00563*delay + 0.122; %cost per minute per passenger
        costminpass = rfpass;
        cost = costminpass * Seats(GroundDelayRBS(i, 1)) * lf * delay;
        if International(GroundDelayRBS(i, 1)) == "YES" || Distances(GroundDelayRBS(i, 1)) > radius
            cost = cost*1.15;
        end
        if delay > 180
            if Distances(GroundDelayRBS(i, 1)) <= 1500
                cost = cost + 250 * 0.2 * lf * Seats(GroundDelayRBS(i, 1));
            elseif Distances(GroundDelayRBS(i, 1)) < 1500 && Distances(GroundDelayRBS(i, 1)) <= 3500
                cost = cost + 400 * 0.2 * lf * Seats(GroundDelayRBS(i, 1));
            elseif Distances(GroundDelayRBS(i, 1)) > 3500
                cost = cost + 600 * 0.2 * lf * Seats(GroundDelayRBS(i, 1));
            end
        end
        GroundCostRBS(end+1, :) = [GroundDelayRBS(i, 1) cost];
        i=i+1;
    end
    
    i = 1;
    while i<= length(AirDelayRBS)
        delay = AirDelayRBS(i, 2);
        rfpass = 0.00563*delay + 0.122; %cost per minute per passenger
        costminpass = rfpass + 0.376121;
        cost = costminpass * Seats(AirDelayRBS(i, 1)) * lf * delay;
        if International(AirDelayRBS(i, 1)) == "YES" || Distances(AirDelayRBS(i, 1)) > radius
            cost = cost*1.15;
        end
        AirCostRBS(end+1, :) = [AirDelayRBS(i, 1) cost];
        i=i+1;
    end
    
    i = 1;
    TotalAirCostRBS = 0;
    while i <= length(AirCostRBS)
        TotalAirCostRBS = TotalAirCostRBS + AirCostRBS(i, 2);
        i = i+1;
    end
    
    i = 1;
    TotalGroundCostRBS = 0;
    while i <= length(GroundCostRBS)
        TotalGroundCostRBS = TotalGroundCostRBS + GroundCostRBS(i, 2);
        i = i+1;
    end
    
    TotalCostRBS = TotalAirCostRBS + TotalGroundCostRBS;
end