function plotNeuron(fileToLoad,neuron)



timeBefore = 1; %tiempo antes del evento
timeAfter = 2; %tiempo despu�s del evento
varsToKeep = [-4,4]; %variables a ocupar para filtrar los ensayos

alignEvent = 'touchIni'; %evento con el que se va a alinear
filterVar = 'anguloInicio'; %variable que se ocupar� para filtrar los datos
graficar = true; %variable booleana que decide si se va a graficar o no
desplazamiento = 0; %desplazamiento de la alineaci�n del raster
loadingPath = 'C:\Users\Raul\Desktop\registros\recordings\'; %path que contiene los datos en .mat
windowJump = 0.01; %size of the window 10 ms %tama�o de las ventanas para calcular la tasa de disparo 
linewidth = 3; %grueso de la l�nea usada para graficar

colors = getColors(1); %obtiene los colores para graficar la tasa de disparo


load([loadingPath,fileToLoad]); %carga e utilizando el nombre del archivo utilizado para llamar la funci�n
subplot(2,1,1) %genera un subplot

[e] = filterBy(e,filterVar,varsToKeep,true); %filtra e usando la variable que desees 
e = orderBy(e,filterVar); %ordena los datos utilizando filterVar

%genera el raster de la neurona elegida con los eventos en e
raster(e, neuron, alignEvent, desplazamiento, graficar,timeBefore,timeAfter);

%Grafica la tasa de disparo
subplot(2,1,2)
load([loadingPath,fileToLoad]); %carga de nuevo e
e = alignE(e,alignEvent); %alinea e de acuerdo a un evento particular

hold on
for k = 1:length(varsToKeep)%separa los eventos utilizando las variables a mantener
    varsToKeepTmp = varsToKeep(k);
    [eNeg] = filterBy(e,filterVar,varsToKeepTmp,false);
    [rates] = getRates(eNeg,timeBefore,timeAfter,windowJump); %gets the firing rates for each neuron around the alignment event
    timeVector = -1*timeBefore:windowJump:timeAfter;
    ratesNeg = meanRate(rates,neuron);
    plot(timeVector,ratesNeg, 'Linewidth', linewidth, 'Color', colors{k}) 
end