function [copiae,angulos] = alignE(e, alinearcon)

copiae = e; %creamos una copia de e y borramos los campos innecesarios con rmfield
angulos = [copiae.trial.anguloRotacion];
%camposI = {'anguloInicio','anguloRotacion','velocidad','tiempo','tiempoMedido','categoria','anguloTarg','respuesta','correcto','digitalInfo','timeStamp','robSignal','robTimeSec'};
% copiae.trial = rmfield(copiae.trial,camposI);
%campos = fieldnames(copiae.trial); %En la variable campos guardamos los nombres de todo los campos que existen en copiae.trial
campos = {'waitCueIni','manosFijasIni','cmdIni','waitCueFin','touchCueIni','manosFijasFin','touchIni','cmdStim','movIni','movFin','stimFin','touchCueFin','touchFin','waitRespIni','targOn','waitRespFin','targOff'};

ensayofinal = length([e.trial.waitCueIni]); %elegimos el ensayo final a graficar
possibleNeurons = fields(e.spikes);%;fields(copiae.spikes);
inicio = [copiae.trial.(alinearcon)]; %creamos una copia de lo que vayamos a usar PARA alinear
for i = 1:ensayofinal %este for alinea cada ensayo utilizando inicio
    for k = 1:length(possibleNeurons)
        copiae.spikes(i).(possibleNeurons{k}) = copiae.spikes(i).(possibleNeurons{k}) - inicio(i);
    end
%     try
%         copiae.spikes(i).spike11 = copiae.spikes(i).spike11 - inicio(i);
%     catch
%         i
%         pause()
%     end
    for j = 1:size(campos,1)%este for alinea cada campo del ensayo
        copiae.trial(i).(campos{j}) = copiae.trial(i).(campos{j}) - inicio(i);%a waitCueIni lo alineamos usando inicio 
        %pause()
    end
end


