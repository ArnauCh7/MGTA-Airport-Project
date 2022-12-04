function [slotsGHP,TotalCostGHP,TotalDelayGHP, ControlledGHP, NotAffectedGHP, delayGHP, TotalAirDelayGHP, TotalGroundDelayGHP, costvectorGHP, AirDelayGHP, GroundDelayGHP, TotalAirCostGHP, TotalGroundCostGHP ] = GHP(slots, ETA, StartSlotIndex, EndSlotIndex, Hstart, HNoReg, ETD, Seats, International, Distances, Hfile, radius)

    slots = slots(StartSlotIndex : EndSlotIndex);
    ControlledGHP = [];
    NotAffectedGHP = [];
    lf = 0.823;

    i = 1;
    while i<= length(ETA)
        if ETA(i) >= Hstart && ETA(i) <=HNoReg
            ControlledGHP(end+1) = i;
        else
            NotAffectedGHP(end+1) = i;
        end
        i=i+1;
    end

    i = 1; %Number of flight we are looking
    c= []; % Vector with the Costs (Cf) for each flight going on any possible slot
    while i <= length(ControlledGHP)
        j = 1; %Number of slots we are looking
        while j <= length(slots)
                delay = (slots(j)-ETA(ControlledGHP(i)));
                rfpass = 0.00563*delay + 0.122; %cost per minute per passenger
                ground = 0;
                air = 0;
                if ETD(ControlledGHP(i)) < Hfile
                    costminpass = rfpass + 0.376121;
                    air = 1;
                else
                    costminpass = rfpass;
                    ground = 1;
                end

                cost = costminpass * Seats(ControlledGHP(i)) * lf * delay;

                if International(ControlledGHP(i)) == "YES" || Distances(ControlledGHP(i)) > radius
                    cost = cost*1.15;
                end

                if air  == 1 && delay > 30
                    cost = cost + 9999999999;
                elseif ground == 1 && delay > 180
                    if Distances(ControlledGHP(i)) <= 1500
                        cost = cost + 250 * 0.2 * lf * Seats(ControlledGHP(i));
                    elseif Distances(ControlledGHP(i)) < 1500 && Distances(ControlledGHP(i)) <= 3500
                        cost = cost + 400 * 0.2 * lf * Seats(ControlledGHP(i));
                    elseif Distances(ControlledGHP(i)) > 3500
                        cost = cost + 600 * 0.2 * lf * Seats(ControlledGHP(i));
                    end
                end
                c(end+1) = cost;
            j=j+1;
        end
        i=i+1;
    end
    
    %Matrix A,b,Aeq,beq
    
    Aeq = []; %Matrix of equalities
    
    i = 1; % Number of flight we are looking
    n = 1; % Since the nº columns in Aeq will be length(ControlledGHP)*length(slots), i and j don't reach this number so we use n
    while i <= length(ControlledGHP)
        j = 1;
        Aeq(end+1, :) = zeros(1, length(c));
        while j<= length(slots) % Sum up all the binary variables for flight i on all slots
            if ETA(ControlledGHP(i)) <= slots(j) %only of the flight can go on that slot teh binary variable will be 1, elsewise it will be 0
                Aeq(i , n) = 1;
            else
                Aeq(i, n) = 0;
            end
            n = n+1;
            j = j+1;
        end
        i = i+1;
    end
    
    beq = ones(1, length(Aeq(:, 1)')); % The sum of the binary variables on all the possible slots for that flight must be 1 since it can only fill 1
    
    A = []; %Matrix of inequalities
    i = 1; % Number of the slot we are looking
    while i <= length(slots)
        n = i; %We will be looking on the position of each slot wich is separated length(ControlledGHP) 
        j = 1; %Number of the flight we are looking
        A(end+1, :) = zeros(1, length(c));
        while j <= length(ControlledGHP) %Sum up all the binary variables for slot i having all flights
            if ETA(ControlledGHP(i)) <= slots(i) %Since there are some flights that cannot go on that slot, those will not be added here
                A(i, n) = 1;
            else
                A(i, n) = 0;
            end
            n = n + length(slots);
            j = j+1;
        end
        i = i+1;
    end
    
    b = ones(1, length(A(:, 1)')); %The sum of binary variables of the slot used by all the aircrafts must be 1
    
    ub = ones(1, length(c)); % Upper bound of the binary variables is 1
    lb = zeros(1, length(c));% Lower bound of the binary variables is 0
    int = 1:length(c);

    [X, TotalCostGHP] = intlinprog(c, int, A, b, Aeq, beq, lb, ub);

    slotsGHP = []; %Matrix which will contain the slot hour with each aircraft

    i = 1; %index to go through slotsGHP_beta
    n = 1; %number of the flight
    while n <= length(ControlledGHP)
        j = 1; %number of the slots we will asign the flight
        while j <= length(slots)
            if X(i) == 1
                slotsGHP(end+1, :) = [ControlledGHP(n) slots(j)];
            end
            j=j+1;
            i=i+1;
        end
        n=n+1;
    end

    delayGHP = [];
    i = 1;
    while i <= length(slotsGHP)
        if ETD(slotsGHP(i, 1)) < Hfile
            delayGHP(end+1, :) = [slotsGHP(i,1) (slotsGHP(i,2)-ETA(slotsGHP(i,1))) 1];
        else
            delayGHP(end+1, :) = [slotsGHP(i,1) (slotsGHP(i,2)-ETA(slotsGHP(i,1))) 0];
        end
        i = i+1;
    end
    
    TotalDelayGHP = 0;
    TotalAirDelayGHP = 0;
    TotalGroundDelayGHP = 0;
    AirDelayGHP = [];
    GroundDelayGHP = [];

    i = 1;
    while i <= length(delayGHP)
        TotalDelayGHP = TotalDelayGHP + delayGHP(i, 2);
        if delayGHP(i, 3) == 1
            TotalAirDelayGHP = TotalAirDelayGHP + delayGHP(i, 2);
            AirDelayGHP(end+1, :) = [delayGHP(i, 1) delayGHP(i, 2)];

        elseif delayGHP(i, 3) == 0
            TotalGroundDelayGHP = TotalGroundDelayGHP + delayGHP(i, 2);
            GroundDelayGHP(end+1, :) = [delayGHP(i, 1) delayGHP(i, 2)];
        end
        i = i+1;
    end

    costvectorGHP = [];
    i = 1;
    TotalAirCostGHP = 0;
    TotalGroundCostGHP = 0;
    while i <= length(delayGHP)
        delay = delayGHP(i, 2);
        rfpass = 0.00563*delay + 0.122; %cost per minute per passenger
        if delayGHP(i, 3) == 1
            costminpass = rfpass + 0.376121;
        else
            costminpass = rfpass;
        end

        cost = costminpass * Seats(delayGHP(i, 1)) * lf * delay;

        if International(delayGHP(i, 1)) == "YES" || Distances(delayGHP(i, 1)) > radius
            cost = cost*1.15;
        end

        if delayGHP(i, 3) == 1 && delay > 30
            cost = cost + 9999999999;
        elseif delayGHP(i, 3) == 0 && delay > 180
            if Distances(delayGHP(i,1)) <= 1500
                cost = cost + 250 * 0.2 * lf * Seats(delayGHP(i,1));
            elseif Distances(delayGHP(i,1)) < 1500 && Distances(delayGHP(i,1)) <= 3500
                cost = cost + 400 * 0.2 * lf * Seats(delayGHP(i,1));
            elseif Distances(delayGHP(i,1)) > 3500
                cost = cost + 600 * 0.2 * lf * Seats(delayGHP(i,1));
            end
        end
        costvectorGHP(end+1, :) = [delayGHP(i, 1) cost];
        if delayGHP(i, 3) == 1
            TotalAirCostGHP = TotalAirCostGHP + cost;
        elseif delayGHP(i, 3) == 0
            TotalGroundCostGHP = TotalGroundCostGHP + cost;
        end
        i = i+1;
    end
end