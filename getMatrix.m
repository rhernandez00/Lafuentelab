function [x,y] = getMatrix(tbl,vargin)
filterVar = getArgumentValue('filterVar' ,'keep', varargin{:});
%%
clearvars -except tbl
filterVar = 'discard';

tbl = tbl(tbl.(filterVar)==0,:);

%%
windowIndx = 1;
maxIndx = 40;
X = []; 
Y = [];

fileToLoad = tbl.file{1};
neuron = tbl.neuron{1};
[X,Y] = getColumn(fileToLoad,neuron,windowIndx);
for k = 2:size(tbl,1)
    fileToLoad = tbl.file{k};
    neuron = tbl.neuron{k};
    [x,y] = getColumn(fileToLoad,neuron,windowIndx);
    X = horzcat(X(1:maxIndx,:),x(1:maxIndx));
    Y = horzcat(Y(1:maxIndx,:),y(1:maxIndx));
%     X = padconcatenation(X,x,2);
%     Y = padconcatenation(Y,y,2);
end





%%

windowIndx = 1;
k = 75;
fileToLoad = tbl.file{k};
neuron = tbl.neuron{k};

[x2,y2] = getColumn(fileToLoad,neuron,windowIndx);

%%
x3 = padconcatenation(x2,x,2);

