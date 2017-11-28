function [x,y] = getColumn(e,rates,neuron,windowIndx,analysisVar,varsToKeep)
%x is a column with the firing rate of windowIndx for each trial, y
%contains the labels of the trial
%variableOfTrial denotes the variable used to create the labels in y and
%the order of the trials
TimeConstant = getArgumentValue('TimeConstant' ,0.05, varargin{:}); % Time constant in seconds.


%%

clear
fileToLoad = 'c1608041052.mat';
neuron = 'spike31';

loadingPath = 'C:\Users\Raul\Desktop\registros\recordings\';
load([loadingPath,fileToLoad]);
windowIndx = 1;
analysisVar = 'anguloInicio';
orderVar = 'anguloInicio';
varsToKeep = [-4,4];
alignEvent = 'touchIni';

analysisWindowWidth = 10;
windowJump = 0.01; %size of the window 10 ms
timeBefore = 1;
timeAfter = 2;
windowRange(1) = 1;
windowRange(2) = (timeAfter+timeBefore)/windowJump - analysisWindowWidth + 1;


e = alignE(e,alignEvent); 
e = orderBy(e,orderVar);
[e,y] = filterBy(e,analysisVar,varsToKeep); %filters e and keeps only the trials that complied with the request

[rates,~] = getRates(e,timeBefore,timeAfter,windowJump); %gets the firing rates for each neuron around the alignment event
nTrials = length(rates.(neuron));
x = zeros(nTrials,1);
for trial = 1:nTrials;
    x(trial) = rates.(neuron)(trial).rate(windowIndx);
end
