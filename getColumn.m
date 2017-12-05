function [x,y,discard,windowMax] = getColumn(fileToLoad,neuron,windowIndx,varargin)
%x is a column with the firing rate of windowIndx for each trial, y contains the labels of the trial
%variableOfTrial denotes the variable used to create the labels in y and
%the order of the trials, if not enough trials to complete the same number 
folder = getArgumentValue('folder' ,'C:\Users\Raul\Desktop\registros\recordings\', varargin{:});
analysisVar = getArgumentValue('analysisVar' ,'anguloInicio', varargin{:});
varsToKeep = getArgumentValue('varsToKeep' ,[-4,4], varargin{:});
alignEvent = getArgumentValue('alignEvent' ,'touchIni', varargin{:});
windowJump = getArgumentValue('windowJump' ,0.05, varargin{:});
filterType = getArgumentValue('filterType', 'boxcar', varargin{:});
timeConstant = getArgumentValue('timeConstant', 0.2, varargin{:});
timeBefore = getArgumentValue('timeBefore' ,1, varargin{:});
timeAfter = getArgumentValue('timeAfter' ,2, varargin{:});
rates = getArgumentValue('rates' ,[], varargin{:});
test = getArgumentValue('test' ,false, varargin{:});
onlyWindowMax = getArgumentValue('onlyWindowMax' ,false, varargin{:});
orderVar = analysisVar;


load([folder,fileToLoad]);
e = alignE(e,alignEvent); 
e = orderBy(e,orderVar);
[e,y] = filterBy(e,analysisVar,varsToKeep, 'signOnly', false); %filters e and keeps only the trials that complied with the request

if isempty(rates)
    [rates] = getRates(e, 'timeBefore',timeBefore, 'timeAfter',timeAfter,...
        'windowJump',windowJump, 'timeConstant', timeConstant, 'neuron', neuron); %gets the firing rates for each neuron around the alignment event
end
windowMax = length(rates.(neuron)(1).rate);
if onlyWindowMax
    x = [];
    y = [];
    discard = [];
    return
end

[discard] = checkNeuronQuality(rates,neuron);%checks wheter a neuron should be discarded or not

nTrials = length(rates.(neuron));
x = zeros(nTrials,1);
for trial = 1:nTrials;
    x(trial) = rates.(neuron)(trial).rate(windowIndx);
end


%Gets the same number of trials for each category by creating new rows with
%a firing rate calculated with the mean of the other trials
[x,y] = completeTrials(x,y);
[y,I] = sortInterleave(y);
x = x(I);
