function plotCostperDelay

Seats = 170;
lf = 0.823;
Distance = 1481;
Delay = 0:300;
Air = [];
Ground = [];

airdelay = 0;
while airdelay <= 300
    rfpass = 0.00563*airdelay + 0.122; %cost per minute per passenger
    costminpass = rfpass + 0.376121;
    cost = costminpass * Seats * lf * airdelay;

    Air(end+1) = cost; 
    airdelay = airdelay +1;
end


grounddelay = 0;
while grounddelay <= 300
    rfpass = 0.00563*grounddelay + 0.122; %cost per minute per passenger
    costminpass = rfpass;
    cost = costminpass * Seats * lf * grounddelay;
    
    if grounddelay > 180
        if Distance <= 1500
            cost = cost + 250 * 0.2 * lf * Seats;
        elseif Distance < 1500 && Distances <= 3500
            cost = cost + 400 * 0.2 * lf * Seats;
        elseif Distances > 3500
            cost = cost + 600 * 0.2 * lf * Seats;
        end
    end
    Ground(end+1) = cost;
    grounddelay = grounddelay +1;
end

figure
plot(Delay, Air, LineWidth=1.5);
hold on
ylabel("Cost [€]");
plot(Delay, Ground, LineWidth=1.5);
title("Cost Per Delay");
xlabel("Delay [min]");
legend({'Air Delay', 'Ground Delay'},'Location','northwest');
