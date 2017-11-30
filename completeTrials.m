function [x,y] = completeTrials(x,y)
%fills unbalanced trials by using the mean of the remaining trials
yVals = sort(unique(y));

for j = 1:length(yVals)
    yValsRep(j) = sum(yVals(j)== y);
end
maxY = max(yValsRep);

for j = 1:length(yValsRep)
    while yValsRep(j) < maxY
        indx = (yVals(j) == y);
        meanVal = mean(x(indx));
        y(length(x)+1) = yVals(j);
        x(length(x)+1) = meanVal;
        yValsRep(j) = sum(yVals(j)== y);
    end
end