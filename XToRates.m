%function XToRates(Xfull,Y)
%%
%esta repitiendo trial, debería tener algún tipo de contador para no poner
%una sola fila cada length(Yvals) trial
clear
load('Xfull.mat')
X = Xfull{1};
YVals = unique(Y);
neurons = size(X,2);
rates = cell(length(YVals),neurons);
for window = 1:length(Xfull)
    X = Xfull{window};
    for trial = 1:size(X,1)        
        for YType = 1:length(YVals)
            for neuron = 1:size(X,2)
                rates{YType,neuron}(size(rates{YType,neuron},1)+1,window) = X(trial,neuron);
            end
        end 
    end
end


%%

clear
load('Xfull.mat')
X = Xfull{1};
YVals = unique(Y);
neurons = size(X,2);
rates = cell(length(YVals),neurons);

window = 1;
X = Xfull{window};
trial = 1;
YType = 1;
neuron = 1;


rates{YType,neuron}(size(rates{YType,neuron},1),window) = 10;

%(size(rates{YType,neuron},1)+1,window) = X(trial,neuron);