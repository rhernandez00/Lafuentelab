function [eOut,y] = filterBy(e,filterVar,varsToKeep,varargin)
%filters out trials from e
simetrical = getArgumentValue('simetrical' ,true, varargin{:});
signOnly = getArgumentValue('signOnly' ,true, varargin{:});


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
if signOnly
    for i = 1:length(indx)
        y(i,1) = (sign(e.trial(indx(i)).(filterVar)));
    end
else
    for i = 1:length(indx)
        y(i,1) = (e.trial(indx(i)).(filterVar));
    end
end

eOut.trial = e.trial(indx);
eOut.spikes = e.spikes(indx);



