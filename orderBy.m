function [eOut,y] = orderBy(e,orderVar)

vals = [e.trial.(orderVar)]; %vals = round(vals.*10)/10;
[~,I] = sort(vals);
for j = 1:length(I)
    eOut.trial(j) = e.trial(I(j));
    eOut.spikes(j) = e.spikes(I(j));
end
