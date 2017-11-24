function [eOut,y] = filterBy(e,filterVar,varsToKeep,simetrical)
if nargin < 4
    simetrical = true;
end


vals = [e.trial.(filterVar)]; vals = round(vals.*10)/10;
if simetrical
    vals = abs(vals);
end

fil = zeros(1,length(vals));
for i = 1:length(varsToKeep)
    addToFil = vals == varsToKeep(i);
    fil = fil + addToFil;
end
indx = find(fil);
for i = 1:length(indx)
    y{i,1} = num2str(sign(e.trial(indx(i)).(filterVar)));
end

eOut.trial = e.trial(indx);
eOut.spikes = e.spikes(indx);



