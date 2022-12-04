function [NotAffectedGDP, ExemptRadius, ExemptInternational, ExemptFlying, Exempt, ControlledGDP] = computeAircraftStatusGDP(ETA,ETD,Distances,International,Hfile,Hstart,HNoReg,radius)
    NotAffectedGDP = [];
    ControlledGDP = [];
    ExemptRadius = [];
    ExemptFlying = [];
    ExemptInternational = [];
    Exempt =[];
    i = 1;
    while i<= length(ETA)
        ex = 0;
        if ETA(i) >= Hstart && ETA(i) <HNoReg
            if Distances(i) >= radius
                ExemptRadius(end+1) = i;
                if ex ~= 1
                    Exempt(end+1)=i;
                end
                ex = 1; 
            end
            if string(International(i)) == "NO"
                ExemptInternational(end+1) = i;
                if ex ~= 1
                    Exempt(end+1)=i;
                end
                ex = 1;
            end
            if ETD(i) < Hfile+30
                ExemptFlying(end+1) = i;
                if ex ~= 1
                    Exempt(end+1)=i;
                end
                ex = 1;
            end
            if ex ~= 1
                ControlledGDP(end+1) = i;
            end
        else
            NotAffectedGDP(end+1) = i;
        end
        i=i+1;
    end
end