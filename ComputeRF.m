function [ControlledGHP, NotAffectedGHP] = ComputeRF(slots, ETA, StartSlotIndex, EndSlotIndex, Hstart, HNoReg, Seats, ETD)

ControlledGHP = [];
NotAffectedGHP = [];
lf = 0.823; %Mean load factor
ADcost = 0; %Cost air delay per minute and per passanger
GDcost = 0; %Cost ground delay per minute and per passanger


i = 1;
while i<= length(ETA)
    if ETA(i) >= Hstart && ETA(i) <=HNoReg
        ControlledGHP(end+1) = i;
    else
        NotAffectedGHP(end+1) = i;
    end
    i=i+1;
end

Rf = [];

i = 1;
while i <= length(ControlledGHP)
    if ETD(ControlledGHP(i)) < Hfile
        Rf(end+1) = ADcost * Seats(Controlle(i))* lf;
    else
        Rf(end+1) = GDcost * Seats(ControlledGHP(i)) * lf;
    end
    

end