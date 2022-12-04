function finalPlots(TotalDelayGDP, TotalDelayRBS, TotalAirDelayGDP, TotalGroundDelayGDP, TotalGroundDelayRBS, TotalAirDelayRBS, GroundDelayGDP, AirDelayGDP, AirDelayRBS, GroundDelayRBS, delay)
    y = [TotalAirDelayRBS TotalGroundDelayRBS; TotalAirDelayGDP TotalGroundDelayGDP];
    bar(y,'stacked')
end