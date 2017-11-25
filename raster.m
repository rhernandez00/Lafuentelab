function [copiae,angulos] = raster(e, neuron, alinearcon, desplazamiento, graficar, rangoMin, rangoMax)
%graficar indica si quieres que haga el raster o no
if nargin < 5
    rangoMin = 5;
    rangoMax = 5;
    graficar = true;
elseif nargin < 6
    rangoMin = 5;
    rangoMax = 5;
end
%%
%BLOQUE PARA CREAR LA MATRIZ DE COLORES QUE USARA EL RASTER

colores = {[75 172 198],... % azul medio cian
    [255 227 36],... %amarillo mostaza
    [247 150 70],... %naranja
    [155 187 89],... %verde hoja
    [128 100 162],... %morado
    [207 0 91],... % rosa medio mexicano
    [255 0 0]... %rojo normal
    };
coloresmatlab = {};
for c = 1:length(colores)
    coloresmatlab{c} = colores{c}./255;
end
%%
%BLOQUE QUE GENERA EL RASTER

ensayofinal = length([e.trial.waitCueIni]); %elegimos el ensayo final a graficar
letra = 20; %tamaño de la fuente de la letra en el plot
ancholinea = 2;
anchoSpike = 1;



copiae = e; %creamos una copia de e
angulos = [copiae.trial.anguloRotacion];
campos = {'anguloInicio','anguloRotacion','velocidad','tiempo','tiempoMedido','categoria','anguloTarg','respuesta','correcto','digitalInfo','timeStamp','robSignal','robTimeSec'};
copiae.trial = rmfield(copiae.trial,campos); % borramos los campos innecesarios con rmfield
campos = fieldnames(copiae.trial); %En la variable campos guardamos los nombres de todo los campos que existen en copiae.trial


possibleNeurons = fields(e.spikes);%;fields(copiae.spikes);
inicio = [copiae.trial.(alinearcon)]; %creamos una copia de lo que vayamos a usar PARA alinear
for ensayo = 1:ensayofinal %este for alinea cada ensayo utilizando inicio
    for k = 1:length(possibleNeurons)
        copiae.spikes(ensayo).(possibleNeurons{k}) = copiae.spikes(ensayo).(possibleNeurons{k}) - inicio(ensayo);
    end

    for j = 1:size(campos,1)%este for alinea cada campo del ensayo
        copiae.trial(ensayo).(campos{j}) = copiae.trial(ensayo).(campos{j}) - inicio(ensayo) + desplazamiento;%a waitCueIni lo alineamos usando inicio 
    end
end

tiempomaximo = desplazamiento + rangoMax; %el tiempo en segundos maximo que puede durar un ensayo
tiempominimo = desplazamiento - rangoMin;%el tiempo en segundos minimi que puede durar un ensayo
%Grafica cada evento por separado
%rasterplotV, es la función que convierte puntos en rayitas
%[x,y], convierte las filas en columnas magicamente para que rasterplotV las pueda usar

camposagraficar = {'waitCueIni','manosFijasIni', 'cmdIni', 'waitCueFin', 'touchCueIni', 'manosFijasFin',...
    'touchIni', 'cmdStim', 'movIni', 'movFin', 'stimFin', 'touchCueFin', 'touchFin', 'waitRespIni',...
    'targOn', 'waitRespFin', 'targOff'};
coloresagraficar = [1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3];

if graficar
    hold on
    [x2,y2] = rasterplotV({copiae.spikes(1:ensayofinal).(neuron)});
    plot(x2,y2, 'color', [0.5,0.5,0.5], 'LineWidth', anchoSpike);
    for k = 1:length(camposagraficar)
        [x,y] = rasterplotV({copiae.trial(1:ensayofinal).(camposagraficar{k})});
        plot(x,y, 'color', coloresmatlab{coloresagraficar(k)}, 'LineWidth', ancholinea);
    end


    % Aqui se embellece la gráfica (trabajo sin completar)
    axis([tiempominimo tiempomaximo 0 ensayofinal])
    xlabel('Tiempo (s)','FontSize', letra)
    ylabel('Ensayo','FontSize', letra)
    %title(e.ArchivoNEV,'FontSize', letra)
end
