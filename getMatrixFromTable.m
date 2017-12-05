function [X,Y,tbl,windowMax] = getMatrixFromTable(tbl,windowIndx,varargin)
%minTrials minimum number of trials for the neuron to be considered
%nTrials number of trials per condition to be used
filterVar = getArgumentValue('filterVar' ,'keep', varargin{:});
minTrials = getArgumentValue('minTrials' ,0, varargin{:});
onlyWindowMax = getArgumentValue('onlyWindowMax' ,false, varargin{:});
%variables for getColumn
folder = getArgumentValue('folder' ,'C:\Users\Raul\Desktop\registros\recordings\', varargin{:});
analysisVar = getArgumentValue('analysisVar' ,'anguloInicio', varargin{:});
varsToKeep = getArgumentValue('varsToKeep' ,[-4,4], varargin{:});
alignEvent = getArgumentValue('alignEvent' ,'touchIni', varargin{:});
windowJump = getArgumentValue('windowJump' ,0.01, varargin{:});
timeConstant = getArgumentValue('timeConstant', 0.2, varargin{:});
timeBefore = getArgumentValue('timeBefore' ,1, varargin{:});
timeAfter = getArgumentValue('timeAfter' ,2, varargin{:});
filterType = getArgumentValue('filterType' ,'boxcar', varargin{:});


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
%this will run only a part of the code and return windowMax for other uses
if onlyWindowMax
    [~,~,~,windowMax] = getColumn(fileToLoad,neuron,1, 'folder', folder,...
    'analysisVar', analysisVar, 'varsToKeep', varsToKeep, 'alignEvent', alignEvent,...
    'windowJump', windowJump, 'timeConstant', timeConstant,...
    'filterType', filterType,...
    'timeBefore', timeBefore, 'timeAfter', timeAfter);
    X = [];
    Y = [];
    tbl = [];
    return
end

%gets the first neuron
[X,Y,~,windowMax] = getColumn(fileToLoad,neuron,1, 'folder', folder,...
    'analysisVar', analysisVar, 'varsToKeep', varsToKeep, 'alignEvent', alignEvent,...
    'windowJump', windowJump, 'timeConstant', timeConstant,...
    'filterType', filterType,...
    'timeBefore', timeBefore, 'timeAfter', timeAfter);
%initializes X and Y
Y = Y(1:nTrials);
X = X(1:nTrials);
%gets the remaining neurons
for k = 2:size(tbl,1)
    fileToLoad = tbl.file{k};
    neuron = tbl.neuron{k};
    [x,y] = getColumn(fileToLoad,neuron,windowIndx, 'folder', folder,...
    'analysisVar', analysisVar, 'varsToKeep', varsToKeep, 'alignEvent', alignEvent,...
    'windowJump', windowJump, 'timeConstant', timeConstant,...
    'filterType',filterType,...
    'timeBefore', timeBefore, 'timeAfter', timeAfter);

    X = horzcat(X,x(1:nTrials));
    %This is a check to make sure that the neurons match between labels
    for j = 1:nTrials
        if Y(j) ~= y(j)
            warning('Labels must be the same');
            X = y;
            return
        end
    end
    
end
