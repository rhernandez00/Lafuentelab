
trials = 50;
y1 = 1;
y2 = 2;
y = [ones(trials,1)*y1;ones(trials,1)*y2];


for j = 1:length(y)
    X(j,1) = y(j) + randn(1); %feature 1
    X(j,2) = y(j) + randn(1)*2; %feature 2
    X(j,3) = y(j) + randn(1)*3; %feature 3
    X(j,4) = y(j) + randn(1)*4; %feature 4
    X(j,5) = y(j) + randn(1)*5; %feature 5
    X(j,6) = y(j) + randn(1)*6; %feature 6
end




[performance,predictions] = runClassification(X,y,'classifier', 'CSVM');
