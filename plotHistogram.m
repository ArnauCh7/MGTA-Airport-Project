function plotHistogram(ETA,CTA,AAR,PAAR)
    flights_hourCTA = zeros(24,1);
    hours = 0:23;
    i = 1;
    while i <= 24
        j = 1;
        while j<= length(CTA)
            if (i-1)*60 <= CTA(j) && CTA(j)< i*60
                flights_hourCTA(i) = flights_hourCTA(i)+1;
            end
            j = j+1;
        end
        i = i+1;
    end

    flights_hourETA = zeros(24,1);
    i = 1;
    while i <= 24
        j = 1;
        while j<= length(ETA)
            if (i-1)*60 <= ETA(j) && ETA(j)< i*60
                flights_hourETA(i) = flights_hourETA(i)+1;
            end
            j = j+1;
        end
        i = i+1;
    end
    
    figure
    b = bar(hours, flights_hourETA);
    xtips1 = b(1).XEndPoints;
    ytips1 = b(1).YEndPoints;
    labels = string(b(1).YData);
    text(xtips1, ytips1, labels, "HorizontalAlignment",'center', 'VerticalAlignment','bottom')
    title("Before RBS applied")
    xlabel("Hour of the day");
    ylabel("Number of planes");
    ylim([0 40]);
    
    figure
    b2 = bar(hours, flights_hourCTA);
    xtips2 = b2(1).XEndPoints;
    ytips2 = b2(1).YEndPoints;
    labels2= string(b2(1).YData);
    text(xtips2, ytips2, labels2, 'HorizontalAlignment','center', 'VerticalAlignment','bottom')
    title("After RBS applied")
    hold on
    xgreen1 = [0 (8.5)];
    ygreen1 = [AAR AAR];
    xgreen2 = [13.5 25];
    ygreen2 = [AAR AAR];
    plot(xgreen1, ygreen1, 'green','LineWidth',3);
    hold on
    plot(xgreen2, ygreen2, 'green','LineWidth',3);
    xred1 = [(8.5) 13.5];
    yred1 = [PAAR PAAR];
    plot(xred1, yred1, 'red','LineWidth',3);
    legend({'Planes Per hour', 'Nominal capacity','', 'Reduced Capacity'},'Location','northwest');
    xlabel("Hour of the day");
    ylabel("Number of planes");
    ylim([0 40]);
    hold off

end