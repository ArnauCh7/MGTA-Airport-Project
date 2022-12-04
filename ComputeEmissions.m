function [TravelEmissions, TotalEmissionsRBS, DelayEmissionsRBS, TotalEmissionsGDP, DelayEmissionsGDP, TotalEmissionsGHP, DelayEmissionsGHP, FlightEmissions, AirEmissionsRBS, GroundEmissionsRBS, AirEmissionsGDP, GroundEmissionsGDP, AirEmissionsGHP, GroundEmissionsGHP ] = ComputeEmissions(AirDelayRBS, GroundDelayRBS, AirDelayGDP, GroundDelayGDP, AirDelayGHP, GroundDelayGHP, ETA, ETD, Seats, ControlledGHP)

TravelEmissions = 0;
DelayEmissionsRBS = 0;
DelayEmissionsGDP = 0;
DelayEmissionsGHP = 0;
FlightEmissions = []; %Vector of the flight time emissions for each flight on our regulation
EmpassminAIR = 0.88763;%Emissions per passenger per minute in air [kg/min*pass]
EmpassminGROUND = 0.047436; %Emissions per passenger per minute in ground [kg/min*pass]
lf = 0.823;

i = 1;
while i <= length(ControlledGHP) %Calculates Travel Emissions
    flytime = ETA(ControlledGHP(i)) - ETD(ControlledGHP(i));
    emissions = EmpassminAIR * Seats(ControlledGHP(i)) * lf * flytime;
    FlightEmissions(end+1, :) = [ControlledGHP(i) (emissions/1000)];%given in tones of CO2
    TravelEmissions = TravelEmissions + emissions;
    i = i+1;
end

%RBS emissions calculation

AirEmissionsRBS = 0;
i = 1;
while i <= length(AirDelayRBS) %Computes AirDelay emissions in RBS
    delay  = AirDelayRBS(i, 2);
    emissions = EmpassminAIR * Seats(AirDelayRBS(i, 1))* lf * delay;
    DelayEmissionsRBS = DelayEmissionsRBS + emissions;
    AirEmissionsRBS = AirEmissionsRBS + emissions;
    i = i+1;
end

GroundEmissionsRBS = 0;
i = 1;
while i <= length(GroundDelayRBS) %Computes GroundDelay emissions in RBS
    delay  = GroundDelayRBS(i, 2);
    emissions = EmpassminGROUND * Seats(GroundDelayRBS(i, 1))* lf * delay;
    DelayEmissionsRBS = DelayEmissionsRBS + emissions;
    GroundEmissionsRBS = GroundEmissionsRBS + emissions;
    i = i+1;
end

TotalEmissionsRBS = TravelEmissions + DelayEmissionsRBS;

%GDP emissions calculation

AirEmissionsGDP = 0;
i = 1;
while i <= length(AirDelayGDP) %Computes AirDelay emissions in GDP
    delay  = AirDelayGDP(i, 2);
    emissions = EmpassminAIR * Seats(AirDelayGDP(i, 1))* lf * delay;
    DelayEmissionsGDP = DelayEmissionsGDP + emissions;
    AirEmissionsGDP = AirEmissionsGDP + emissions;
    i = i+1;
end

GroundEmissionsGDP = 0;
i = 1;
while i <= length(GroundDelayGDP) %Computes GroundDelay emissions in GDP
    delay  = GroundDelayGDP(i, 2);
    emissions = EmpassminGROUND * Seats(GroundDelayGDP(i, 1))* lf * delay;
    DelayEmissionsGDP = DelayEmissionsGDP + emissions;
    GroundEmissionsGDP = GroundEmissionsGDP + emissions;
    i = i+1;
end

TotalEmissionsGDP = TravelEmissions + DelayEmissionsGDP;

%GHP emissions calculation

AirEmissionsGHP = 0;
i = 1;
while i <= length(AirDelayGHP) %Computes AirDelay emissions in GHP
    delay  = AirDelayGHP(i, 2);
    emissions = EmpassminAIR * Seats(AirDelayGHP(i, 1))* lf * delay;
    DelayEmissionsGHP = DelayEmissionsGHP + emissions;
    AirEmissionsGHP = AirEmissionsGHP + emissions;
    i = i+1;
end

GroundEmissionsGHP = 0;
i = 1;
while i <= length(GroundDelayGHP) %Computes GroundDelay emissions in GHP
    delay  = GroundDelayGHP(i, 2);
    emissions = EmpassminGROUND * Seats(GroundDelayGHP(i, 1))* lf * delay;
    DelayEmissionsGHP = DelayEmissionsGHP + emissions;
    GroundEmissionsGHP = GroundEmissionsGHP + emissions;
    i = i+1;
end

TotalEmissionsGHP = TravelEmissions + DelayEmissionsGHP;