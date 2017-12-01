function [discard] = checkNeuronQuality(rates,neuron,varargin)
%Toma rates y neuron. Determina si la neurona tiene una tasa de disparo superior a thr en un min de ensayos de minTrials. Devuelve un boolean
thr = getArgumentValue('thr' ,5, varargin{:});
minTrials = getArgumentValue('minTrials' ,10, varargin{:});

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