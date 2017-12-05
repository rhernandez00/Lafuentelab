function [timeVector,performance] = plotRatesAndPredictions(tbl,varargin)
%Takes a tbl and plots the firing rate and the predictions in a timeline
classifier = getArgumentValue('classifier','CSVM', varargin{:});
filterVar = getArgumentValue('filterVar' ,'keep', varargin{:});
minTrials = getArgumentValue('minTrials' ,0, varargin{:});
%variables for getColumn
folder = getArgumentValue('folder' ,'C:\Users\Raul\Desktop\registros\recordings\', varargin{:});
analysisVar = getArgumentValue('analysisVar' ,'anguloInicio', varargin{:});
varsToKeep = getArgumentValue('varsToKeep' ,[-4,4], varargin{:});
alignEvent = getArgumentValue('alignEvent' ,'touchIni', varargin{:});
windowJump = getArgumentValue('windowJump' ,0.05, varargin{:});
timeConstant = getArgumentValue('windowJump' ,0.2, varargin{:});
timeBefore = getArgumentValue('timeBefore' ,1, varargin{:});
timeAfter = getArgumentValue('timeAfter' ,2, varargin{:});
nSamples = getArgumentValue('nSamples' ,10, varargin{:});
desvFromMean = getArgumentValue('desvFromMean' ,2, varargin{:});
filterType = getArgumentValue('filterType' ,'boxcar', varargin{:});



%%

timeVector = -1*timeBefore:windowJump:timeAfter;

windowEnd = length(timeVector);
for windowIndx = 1:windowEnd
    disp(['window: ', num2str(windowIndx), '/', num2str(windowEnd)]);
    [X,Y,tblFilt] = getMatrixFromTable(tbl,windowIndx, 'filterVar', filterVar, ...
        'minTrials', minTrials, 'folder', folder,...
        'analysisVar', analysisVar, 'varsToKeep', varsToKeep, 'alignEvent', alignEvent,...
        'windowJump', windowJump, 'timeConstant', timeConstant,...
        'filterType', filterType,...
        'timeBefore', timeBefore, 'timeAfter', timeAfter);
    kfold = size(X,1)/2;
    Xfull{windowIndx} = X;
    
    [performance(windowIndx),predictions{windowIndx}] = runClassification(X,Y,'classifier',classifier, 'kfold', kfold);
%     for k = 1:size(X,2)
%         rates{k} = X(:,k);
%     end
end

relevant = evaluatePrediction(performance,timeVector,nSamples,desvFromMean);
plot(timeVector,performance);







return
if relevant
    plot(timeVector,performance);
end



% 
% load([folder,fileToLoad]);
% e = alignE(e,alignEvent); 
% hold on
% for k = 1:length(varsToKeep)
%     varsToKeepTmp = varsToKeep(k);
%     [eNeg,yNeg] = filterBy(e,filterVar,varsToKeepTmp,false);
%     [rates,possibleNeurons] = getRates(eNeg,timeBefore,timeAfter,windowJump); %gets the firing rates for each neuron around the alignment event
%     ratesNeg = meanRate(rates,neuron);
%     plot(timeVector,ratesNeg, 'Linewidth', linewidth, 'Color', colors{k}) 
% end
% 
% predictions = [results.(neuron).acc];
% timeVectorPrediction = timeVector(11:end);
% yyaxis right


% ax = axis;
% axis([ax(1),ax(2),0,1])

