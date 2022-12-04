function [NotAffectedRBS, ControlledRBS] = computeAircraftStatusRBS(ETA, Hstart, HNoReg)
    NotAffectedRBS = [];
    ControlledRBS = [];
    i = 1;
    while i<= length(ETA)
        if ETA(i) >= Hstart && ETA(i) <=HNoReg
            ControlledRBS(end+1) = i;
        else
            NotAffectedRBS(end+1) = i;
        end
        i=i+1;
    end
end