clear;
close all;
%When computing the normal version of the regulation (with all aircrafts)
%the filename is "taulaDades.xlsx"
%When computing for the intermodality (WP5) version the filename is
%"DataTableWP5" and since we did our hypothesis and it has less cancelled
%flights there is an option for that one too "DataTableWP5-2"
filename = "taulaDades.xlsx";
T = readtable(filename);

Hfile = 420;
Hstart = 540; %Start regulation
Hend = 840;%End regulation
PAAR = 20;%Reduced Capacity
AAR = 30;%Normal Capacity
radius = 2000; %radius of exemnption
StartSlotIndex = 270;
if filename == "taulaDades.xlsx"
    EndSlotIndex = 488;
elseif filename == "DataTableWP5.xlsx"
    EndSlotIndex = 423;
elseif filename == "DataTableWP5-2.xlsx"
    EndSlotIndex = 438;
end

%Slots: function computes the matrix of slots from Hstart to HNoReg
% Each slot line information should include: initial time of the slot, and ID of 
% the assigned flight to that slot, initially set to zero. 
% Size of the slots will vary according to the reduced (PAAR) and nominal 
% capacity (AAR) of the airport

[HNoReg, delay] = aggregatedemand(T.ETA, Hstart, Hend, PAAR, AAR, filename);
slots = computeSlots(Hstart, Hend, HNoReg, PAAR, AAR);

% From the arrival demand at the airport, this function computes which flights:
% • are not affected by the GDP because their ETA is earlier than the initial time of 
% the GDP (Hstart) or because their ETA is after the hour when the regulation 
% is not active (HNoReg),
% • are controlled
% Each set of flights (NotAffected and ControlledRBS) is a vector containing 
% the ID of each flight.

[NotAffectedRBS, ControlledRBS] = computeAircraftStatusRBS(T.ETA, Hstart, HNoReg);

% This function will assign slots to the flights that are arriving to the airport. 
% For RBS, this is only first-in first served rule, 
% AirDelay is considered as the delay to apply to a flight already flying when 
% the regulation is set (that is already flying at FileTime Hfile)
% GroundDelay is considered for flights that have not taken off when the 
% regulation is set (not flying yet at FileTime Hfile)

[slotsRBS, GroundDelay, AirDelay] = assignSlotsRBS(slots, ControlledRBS, T.ETA, T.ETD, Hfile);

% Compute the CTA of all flights from the original ETA list of traffic and the 
% delay assigned. CTA is the same as ETA but with the delay added to the 
% flights that have to do delay
[CTA_RBS, GroundDelayRBS, AirDelayRBS, TotalAirDelayRBS, TotalGroundDelayRBS] = computeCTA(T.ETA, GroundDelay, AirDelay, HNoReg, Hstart);


% Generate two histograms, one for arrival traffic before regulation 
% and 1 for arrivals once traffic has been regulated

plotHistogram(T.ETA,CTA_RBS,AAR,PAAR);

% This is similar to what was done in WP2 for NotAffected and 
% ControlledRBS flights, but on top of these 2 categories, there are now 
% categories of flights exempt from the GDP (flights that are within the 
% regulation, but are given priority)
% From the arrival demand at the airport, this function computes which 
% flights:
% • are not affected by the GDP because their ETA is earlier than the initial 
% time of the GDP (Hstart) or because their ETA is after the hour when 
% the regulation is not active (HNoReg). 
% • are exempt because their origin airport is further than the radius of the 
% GDP
% • are exempt because are already flying when the GDP is defined. That 
% is, their ETD is earlier than the file time of the regulation (Hfile). 
% Consider a margin (30 min for example) to exempt as well the flights 
% ready to depart at Hfile (already boarded, door closed, etc)
% • are exempt because they come from international airports
% • are controlled (included in the GDP)

[NotAffectedGDP, ExemptRadius, ExemptInternational, ExemptFlying, Exempt, ControlledGDP] = computeAircraftStatusGDP(T.ETA,T.ETD,T.Distance_km_,T.ECACAREA,Hfile,Hstart,HNoReg,radius);

% Compute the assignment of the aircraft to the slots and the delay assigned 
% to each flight

slotsGDP = assignSlotsGDP(slots, ControlledGDP, Exempt, T.ETA, StartSlotIndex, EndSlotIndex);

%Computes the Calculated time of Arrival of each flight with the applied
%GDP and gives the Air, Ground and Total delays
[CTA_GDP, GroundDelayGDP, AirDelayGDP, TotalGroundDelayGDP, TotalAirDelayGDP, TotalDelayGDP] = computeCTA_GDP(T.ETA, T.ETD, slotsGDP, Hfile);

%Computes the Calculated time of departure with the GDP applied
CTD_GDP = computeCTD_GDP(T.ETD, GroundDelayGDP, CTA_GDP);

%Computed the Unrecoverable Delay if the GDP is cancelled at Hstart
UnrecDelay = ComputeUnrecoverableDelay(CTD_GDP, T.ETD, Hfile, Hstart, GroundDelayGDP);

%ParameterChangesPlots_GDP(T.ETA, T.ETD, T.Distance_km_, T.ECACAREA, Hstart, Hend, HNoReg, StartSlotIndex, EndSlotIndex, PAAR, AAR)
[TotalDelayRBS] = totals(TotalGroundDelayRBS, TotalAirDelayRBS);
radiusDependentPlot(T,Hfile, slots, StartSlotIndex, EndSlotIndex, HNoReg, Hstart)
HfileDependentPlot(T,radius, slots, StartSlotIndex, EndSlotIndex, HNoReg, Hstart)
threeDimPlots(T.ETA, T.ETD, T.Distance_km_, T.ECACAREA, Hstart, Hend, HNoReg, StartSlotIndex, EndSlotIndex, PAAR, AAR, slots);

%Assigns the new slots with the GHP algorithm and computes the total delay
%of the GHP

[slotsGHP,TotalCostGHP,TotalDelayGHP, ControlledGHP, NotAffectedGHP, delayGHP, TotalAirDelayGHP, TotalGroundDelayGHP, costvectorGHP, AirDelayGHP, GroundDelayGHP, TotalAirCostGHP, TotalGroundCostGHP] = GHP(slots, T.ETA, StartSlotIndex, EndSlotIndex, Hstart, HNoReg, T.ETD, T.Seats, T.ECACAREA, T.Distance_km_, Hfile, radius);

%Computes the cost that would have had our regulation if we apply the
%same cost function to the RBS and GDP models
[GroundCostRBS, AirCostRBS, TotalCostRBS, TotalAirCostRBS, TotalGroundCostRBS] = ComputeCostRBS(GroundDelayRBS,AirDelayRBS, T.Seats, T.Distance_km_, radius, T.ECACAREA);
[GroundCostGDP, AirCostGDP, TotalCostGDP, TotalAirCostGDP, TotalGroundCostGDP] = ComputeCostGDP(GroundDelayGDP,AirDelayGDP, T.Seats, T.Distance_km_, radius, T.ECACAREA);

%Computation of the CO2 emissions for each solution and travel time
[TravelEmissions, TotalEmissionsRBS, DelayEmissionsRBS, TotalEmissionsGDP, DelayEmissionsGDP, TotalEmissionsGHP, DelayEmissionsGHP, FlightEmissions, AirEmissionsRBS, GroundEmissionsRBS, AirEmissionsGDP, GroundEmissionsGDP, AirEmissionsGHP, GroundEmissionsGHP] = ComputeEmissions(AirDelayRBS, GroundDelayRBS, AirDelayGDP, GroundDelayGDP, AirDelayGHP, GroundDelayGHP, T.ETA, T.ETD, T.Seats, ControlledGHP);

%Calculation of different interesting metrics to compare each solution
[CostperPaxRBS,CostperPaxGDP, CostperPaxGHP, maxCostpaxRBS, maxCostpaxGDP, maxCostpaxGHP,refundsRBS, refundsGDP, refundsGHP, avgempaxRBS, avgempaxGDP, avgempaxGHP, avgemflightRBS, avgemflightGDP, avgemflightGHP ] = ExtraMetrics(TotalCostRBS,TotalCostGDP, TotalCostGHP, ControlledGHP, T.Seats, GroundCostRBS, AirCostRBS, GroundCostGDP, AirCostGDP,costvectorGHP, GroundDelayRBS, GroundDelayGDP, GroundDelayGHP, DelayEmissionsRBS, DelayEmissionsGDP, DelayEmissionsGHP );

%Plot of the air and ground cost depending on the delay
plotCostperDelay

%Prints the all the final values in the console
FinalValues(TotalGroundDelayRBS, GroundDelayRBS, TotalAirDelayRBS, AirDelayRBS,TotalDelayRBS, TotalCostRBS, TotalAirCostRBS, TotalGroundCostRBS, TotalGroundDelayGDP, GroundDelayGDP, TotalAirDelayGDP, AirDelayGDP, TotalDelayGDP,TotalCostGDP, TotalAirCostGDP, TotalGroundCostGDP, TotalGroundDelayGHP, GroundDelayGHP, TotalAirDelayGHP, AirDelayGHP, TotalDelayGHP, TotalCostGHP, TotalAirCostGHP, TotalGroundCostGHP, TravelEmissions, TotalEmissionsRBS, TotalEmissionsGDP, TotalEmissionsGHP, DelayEmissionsRBS, DelayEmissionsGDP, DelayEmissionsGHP, AirEmissionsRBS, GroundEmissionsRBS, AirEmissionsGDP, GroundEmissionsGDP, AirEmissionsGHP, GroundEmissionsGHP, CostperPaxRBS,CostperPaxGDP, CostperPaxGHP, maxCostpaxRBS, maxCostpaxGDP, maxCostpaxGHP,refundsRBS, refundsGDP, refundsGHP, avgempaxRBS, avgempaxGDP, avgempaxGHP, avgemflightRBS, avgemflightGDP, avgemflightGHP )





