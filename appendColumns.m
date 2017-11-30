function [x,y] = appendColumns(tbl,vargin)
filterVar = getArgumentValue('filterVar' ,'discard', varargin{:});
%%
clearvars -except tbl
filterVar = 'discard';

tbl = tbl(tbl.(filterVar)==1,:);

%%
windowIndx = 1;
k = 1;
fileToLoad = tbl.file{k};
neuron = tbl.neuron{k};

[x,y] = getColumn(fileToLoad,neuron,windowIndx);


%%

windowIndx = 1;
k = 75;
fileToLoad = tbl.file{k};
neuron = tbl.neuron{k};

[x2,y2] = getColumn(fileToLoad,neuron,windowIndx);

%%
x3 = horzcat(x2,x);