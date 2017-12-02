function [X,Y,tbl,windowLength] = getMatrixFromTable(tbl,windowIndx,varargin)
%minTrials minimum number of trials for the neuron to be considered
%nTrials number of trials per condition to be used
filterVar = getArgumentValue('filterVar' ,'keep', varargin{:});
minTrials = getArgumentValue('minTrials' ,0, varargin{:});

tbl = tbl(tbl.(filterVar)==1,:);
tbl = tbl(tbl.analysisVarTrials > minTrials,:);
nTrials = getArgumentValue('nTrials' ,min(tbl.analysisVarTrials), varargin{:});
if nTrials > min(tbl.analysisVarTrials)
    error(['Not enough trials to fullfil the input requested, maxTrials should be equal or below than ', num2str(min(tbl.analysisVarTrials))]);
end


X = []; 
Y = [];

fileToLoad = tbl.file{1};
neuron = tbl.neuron{1};
[X,Y,~,windowLength] = getColumn(fileToLoad,neuron,windowIndx);
Y = Y(1:nTrials);
X = X(1:nTrials);
for k = 2:size(tbl,1)
    fileToLoad = tbl.file{k};
    neuron = tbl.neuron{k};
    [x,y] = getColumn(fileToLoad,neuron,windowIndx);
    X = horzcat(X,x(1:nTrials));
    for j = 1:nTrials
        if Y(j) ~= y(j)
            warning('Labels must be the same');
            X = y;
            return
        end
    end
    
end
