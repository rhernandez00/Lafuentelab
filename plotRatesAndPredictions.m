function plotRatesAndPredictions
%Takes a tbl and predictions and plots the firing rate and the predictions
%in a timeline
folder = getArgumentValue('folder' ,'C:\Users\Raul\Desktop\registros\recordings\', varargin{:});
fileToLoad = 'c1608041052.mat';
neuron = 'spike31';


%%
folder = 'C:\Users\Raul\Desktop\registros\recordings\';
fileToLoad = ;
load([folder,fileToLoad]);
e = alignE(e,alignEvent); 
hold on
for k = 1:length(varsToKeep)
    varsToKeepTmp = varsToKeep(k);
    [eNeg,yNeg] = filterBy(e,filterVar,varsToKeepTmp,false);
    [rates,possibleNeurons] = getRates(eNeg,timeBefore,timeAfter,windowJump); %gets the firing rates for each neuron around the alignment event
    timeVector = -1*timeBefore:windowJump:timeAfter;
    ratesNeg = meanRate(rates,neuron);
    plot(timeVector,ratesNeg, 'Linewidth', linewidth, 'Color', colors{k}) 
end

predictions = [results.(neuron).acc];
timeVectorPrediction = timeVector(11:end);
yyaxis right

plot(timeVectorPrediction,predictions)
ax = axis;
axis([ax(1),ax(2),0,1])

