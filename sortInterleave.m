function [xOrdered,I] = sortInterleave(x)
%Sorts x interleaving the elements on it. Must have the same number of elements

xVals = sort(unique(x));
xMatrix = zeros(sum(xVals(1) == x),length(xVals));
xIndx = zeros(sum(xVals(1) == x),length(xVals));
for j = 1:length(xVals)
   xMatrix(:,j) = x(xVals(j) == x);
   xIndx(:,j) = find(xVals(j) == x);
end
xMatrix = xMatrix';
xIndx = xIndx';
xOrdered = xMatrix(:); 
I = xIndx(:); 