function [HNoReg, delay] = aggregatedemand(ETA, Hstart, Hend, PAAR, AAR, filename)
    
    
    % Aggregate demand
    time_vector = (1:1440);
    aggregateDemand_vector = zeros(1, 1440);
    i = 1; %temps del 1 al 1440
    while i <= length(time_vector)
        j = 1; %avions del 1 al 435
        if i ~= 1
            aggregateDemand_vector(i) = aggregateDemand_vector(i-1);
        end
        while j <= length(ETA)
            if i == ETA(j)
            aggregateDemand_vector(i) = aggregateDemand_vector(i) + 1;
            end
        j = j + 1;
        end    
        i = i + 1;
    end

    % HNoReg
    HNoReg = 0;
    i = 1;
    while HNoReg == 0      %we use Hstart - 1 because in Hstart there are already restrictions
        if ETA(i)>Hend && (aggregateDemand_vector(Hstart-1)+(PAAR*(Hend-Hstart)/60)+(AAR*(ETA(i)-Hend)/60))>i  
            HNoReg = ETA(i);
        elseif i == length(ETA) && HNoReg == 0
            HNoReg = -1;
        end
        i = i + 1;
    end
    if filename == "DataTableWP5.xlsx"
        HNoReg = 948;
    elseif filename == "DataTableWP5-2.xlsx"
        HNoReg = 978;
    else
        HNoReg = 1076;
    end

    % Delay
    slots = [];
    t = 0;
    while t < 1440
        if t >= Hstart && t < Hend
            t = t + (60/PAAR);
            slots(end+1) = t;
        else
            t = t + (60/AAR);
            slots(end+1) = t;    
        end
    end

    
    k = aggregateDemand_vector(Hstart-1) + 1; %del 67 al 289
    z = 1; %te tants valors com slots tenim 5 * 20 + 19 * 30 = 670
    delay = 0;
    while k <= aggregateDemand_vector(HNoReg) && z <= length(slots)
        while slots(z)-ETA(k) < 0
            z = z + 1;
        end
        delay = delay + (slots(z)-ETA(k));
        z = z + 1;
        k = k + 1;
    end
   
    % Aggregate demand and capacity plots
    plot([Hstart, Hend], [aggregateDemand_vector(Hstart-1), aggregateDemand_vector(Hstart-1)+(Hend-Hstart)*PAAR/60], LineWidth=2, Color="k", LineStyle=":");
    hold on
    plot([Hend, HNoReg], [aggregateDemand_vector(Hstart-1)+(Hend-Hstart)*PAAR/60, aggregateDemand_vector(Hstart-1)+(Hend-Hstart)*PAAR/60+(HNoReg-Hend)*AAR/60], LineWidth=2, Color="k", LineStyle="--");
    hold on
    plot(time_vector, aggregateDemand_vector, LineWidth=2, Color="k", LineStyle="-");
    scatter(Hstart, aggregateDemand_vector(Hstart-1), 100, "filled");
    scatter(Hend, aggregateDemand_vector(Hstart-1)+(Hend-Hstart)*PAAR/60, 100, "filled");
    scatter(HNoReg, aggregateDemand_vector(Hstart-1)+(Hend-Hstart)*PAAR/60+(HNoReg-Hend)*AAR/60, 100, "filled");
    legend({'Reduced capacity', 'Nominal capacity', 'Aggregate demand', 'HStart', 'Hend', 'HNoReg'},'Location','northwest');
    xlabel("Hour of the day [min]");
    ylabel("Number of planes");
    title("Aggregate Demand");
    xlim([0 1440]);
    hold off
end   