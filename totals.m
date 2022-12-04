function [TotalDelayRBS] = totals(TotalGroundDelayRBS, TotalAirDelayRBS)
TotalDelayRBS = 0;
TotalDelayRBS = TotalAirDelayRBS + TotalGroundDelayRBS;
end