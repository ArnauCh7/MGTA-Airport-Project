function UnrecDelay = ComputeUnrecoverableDelay(CTD, ETD, Hfile, Hstart, GroundDelayGDP)
    UnrecDelay = 0;
    for i = CTD'
            if (i(2) - ETD(i(1))) ~= 0
                if ETD(i(1)) > Hstart
                elseif i(2) < Hstart
                    UnrecDelay = UnrecDelay + (i(2)-ETD(i(1)));
                elseif ETD(i(1)) < Hstart && i(2) > Hstart
                    UnrecDelay = UnrecDelay + (Hstart - ETD(i(1)));
                end
            end
    end
end
