function [x,y] = getColumn(fileToLoad,neuron,windowIndx,varargin)
%x is a column with the firing rate of windowIndx for each trial, y contains the labels of the trial
%variableOfTrial denotes the variable used to create the labels in y and
%the order of the trials
folder = getArgumentValue('folder' ,'C:\Users\Raul\Desktop\registros\recordings\', varargin{:});
analysisVar = getArgumentValue('analysisVar' ,'anguloInicio', varargin{:});
varsToKeep = getArgumentValue('varsToKeep' ,[-4,4], varargin{:});
alignEvent = getArgumentValue('alignEvent' ,'touchIni', varargin{:});
analysisWindowWidth = getArgumentValue('analysisWindowWidth',10, varargin{:});
windowJump = getArgumentValue('windowJump' ,0.01, varargin{:});
timeBefore = getArgumentValue('timeBefore' ,1, varargin{:});
timeAfter = getArgumentValue('timeAfter' ,2, varargin{:});
rates = getArgumentValue('rates' ,[], varargin{:});
test = getArgumentValue('test' ,false, varargin{:});
orderVar = analysisVar;


load([folder,fileToLoad]);
e = alignE(e,alignEvent); 
e = orderBy(e,orderVar);
[e,y] = filterBy(e,analysisVar,varsToKeep); %filters e and keeps only the trials that complied with the request

if isempty(rates)
    [rates] = getRates(e,timeBefore,timeAfter,windowJump,neuron); %gets the firing rates for each neuron around the alignment event
end


nTrials = length(rates.(neuron));
x = zeros(nTrials,1);
for trial = 1:nTrials;
    x(trial) = rates.(neuron)(trial).rate(windowIndx);
end