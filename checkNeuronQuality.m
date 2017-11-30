function [discard] = checkNeuronQuality(rates,neuron,varargin)
thr = getArgumentValue('thr' ,5, varargin{:});
minTrials = getArgumentValue('minTrials' ,20, varargin{:});

count = 0;
for trial = 1:length(rates.(neuron))
    
    if mean(rates.(neuron)(trial).rate) < thr
        %mean(rates.(neuron)(trial).rate);
        count = count + 1;
    end
    if count > minTrials
        discard = true;
        return
    end
        
end
discard = false;