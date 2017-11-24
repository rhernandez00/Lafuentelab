function plotNeuron(fileToLoad,neuron)


%fileToLoad = 'c1608041052.mat';
%neuron = 'spike31';

timeBefore = 1;
timeAfter = 2;
varsToKeep = [-4,4];
alignEvent = 'touchIni';
filterVar = 'anguloInicio';
graficar = true;
desplazamiento = 0;
loadingPath = 'C:\Users\Raul\Desktop\registros\recordings\';
predictionsPath = 'C:\Users\Raul\Dropbox\varios\registro\MachineLearning\results\touchIni2\';
analysisWindowWidth = 10; %in ms, 100 ms = 10 samples
windowJump = 0.01; %size of the window 10 ms
linewidth = 3;
colors = getColors(1);


load([loadingPath,fileToLoad]);
load([predictionsPath,'ML_',fileToLoad], 'results');
subplot(2,1,1)

[e,y] = filterBy(e,filterVar,varsToKeep,true);
e = orderBy(e,filterVar);
raster(e, neuron, alignEvent, desplazamiento, graficar,timeBefore,timeAfter);


subplot(2,1,2)
load([loadingPath,fileToLoad]);
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

return



%%

for j = 1:length(rates.(neuron))
    rateVals = [rates.(neuron)(j).rate];
    newMat(j,:) = rateVals;
end




%%
e = alignE(e,alignEvent); %al poner el último argumento en false
%e = orderBy(e,filterVar);

[rates,possibleNeurons] = getRates(e,timeBefore,timeAfter,windowJump); %gets the firing rates for each neuron around the alignment event




clc

j = 1;
neuron = possibleNeurons{j};
[discard] = checkNeuronQuality(rates,neuron)

%%

subplot(2,1,1)
rasterB(e, neuron, alignEvent, desplazamiento, graficar)

%getting X1
varsToKeep = -4;
[eNeg,yNeg] = filterBy(e,filterVar,varsToKeep,false);
[ratesNeg,possibleNeurons] = getRates(eNeg,timeBefore,timeAfter,windowJump); %gets the firing rates for each neuron around the alignment event



windowStartX = -1;
analysisWindowWidthX = 300; %100ms *30
[X] = getMatrix(rates,neuron,windowStartX,windowJump,analysisWindowWidthX);


%%
varsToKeep = [-4];
[eNeg,y] = filterBy(e,filterVar,varsToKeep,false);




%%

windowStartX = -1;
analysisWindowWidthX = 300; %100ms *30
[X] = getMatrix(rates,neuron,windowStartX,windowJump,analysisWindowWidthX);




%%
subplot(2,1,1)
rasterB(eOut, neuron, alignEvent, desplazamiento, graficar)
subplot(2,1,2)







