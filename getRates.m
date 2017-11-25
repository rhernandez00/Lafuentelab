function [rates,possibleNeurons] = getRates(e,timeBefore,timeAfter,windowJump)
if nargin < 2
    timeBefore = 2;
    timeAfter = 2;
    windowJump = 0.01; %10 ms window
elseif nargin < 4
    windowJump = 0.01;
end
if sign(timeBefore) < 0
    error('timeBefore should go from 0 on');
end
%% Calculates the firing rate and assigns it to e.trial
rangoMin = -1*timeBefore;
rangoMax = timeAfter;


%genera la ventana de tiempo que se va a ocupar para calcular la tasa de
%disparo


timeConstant = 0.2; %constante de tiempo, de esta depende el suavizado de la tasa de disparo
%funcion que calcula la tasa de disparo

possibleNeurons = fields(e.spikes);
timeSamples = rangoMin:windowJump:rangoMax;


for i = 1:length(possibleNeurons)
    for j = 1:length(e.trial)
        trial = j;
        neuron = [e.spikes(trial).(possibleNeurons{i})];
        %size(neuron)
        
%         timeSamples = min([e.spikes.(possibleNeurons{i})]):ventana:max([e.spikes.(possibleNeurons{i})]);
        rate = firingrate(neuron, timeSamples, 'TimeConstant', timeConstant, 'FilterType', 'exponential');
        
        rates.(possibleNeurons{i})(trial).rate = rate;
    end
end