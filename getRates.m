function [rates,possibleNeurons] = getRates(e,varargin)
timeBefore = getArgumentValue('timeBefore' ,1, varargin{:});
timeAfter = getArgumentValue('timeAfter' ,2, varargin{:});
windowJump = getArgumentValue('windowJump' ,0.05, varargin{:}); %gap entre ventanas (0.05 = 50 ms)
neuron = getArgumentValue('neuron', [], varargin{:});
timeConstant = getArgumentValue('timeConstant', 0.2, varargin{:});%constante de tiempo, de esta depende el suavizado de la tasa de disparo
filterType = getArgumentValue('filterType', 'boxcar', varargin{:});
%calcula la tasa de disparo de las neuronas disponibles para cada ensayo y
%lo devuelve como rates
if sign(timeBefore) < 0
    error('timeBefore should go from 0 on');
end
%% Calculates the firing rate and assigns it to e.trial
rangoMin = -1*timeBefore;
rangoMax = timeAfter;


%genera la ventana de tiempo que se va a ocupar para calcular la tasa de
%disparo



%funcion que calcula la tasa de disparo
if isempty(neuron)
    possibleNeurons = fields(e.spikes);
else
    possibleNeurons{1} = neuron;
end
timeSamples = rangoMin:windowJump:rangoMax;


for i = 1:length(possibleNeurons)
    for j = 1:length(e.trial)
        trial = j;
        neuron = [e.spikes(trial).(possibleNeurons{i})];
        rate = firingrate(neuron, timeSamples, 'TimeConstant', timeConstant, 'FilterType', filterType);
        rates.(possibleNeurons{i})(trial).rate = rate;
    end
end