function tbl = getFileMetadata(fileName,varargin)
% gets metadata from a file and gives it back as a table. One row for each neuron
% analysisVar: Variable used to partition the data from a neuron recorded.
% It is the variable used to generate the categories to be classified

% default variables
analysisVar = getArgumentValue('analysisVar' ,'anguloInicio', varargin{:});
folder = getArgumentValue('folder' ,'C:\Users\Raul\Desktop\registros\recordings\', varargin{:});

load([folder,fileName]); %loads e
neuron = fields(e.spikes); %gets the available neurons

%gets the data from e and places it in variables
coordenadaX = e.canulas.coordenadas(1) * ones(length(neuron),1);
coordenadaY = e.canulas.coordenadas(2) * ones(length(neuron),1);
coordenadaZ = e.canulas.coordenadas(3) * ones(length(neuron),1);
contacto = e.canulas.contacto * ones(length(neuron),1);

%orientation
orientacion = cell(length(neuron),1);
[orientacion{:}] = deal(e.canulas.orientacion); %this function is used to assign

%one string to various cells
monkey = cell(length(neuron),1);
[monkey{:}] = deal(fileName(1));
monkey = categorical(monkey);
dateRegistered = cell(length(neuron),1);
[dateRegistered{:}] = deal(strtok(e.Fecha));

file = cell(length(neuron),1);
[file{:}] = deal(fileName);

%corrdinates
cortezaX = e.electrodos.corteza(1) * ones(length(neuron),1);
cortezaY = e.electrodos.corteza(2) * ones(length(neuron),1);
cortezaZ = e.electrodos.corteza(3) * ones(length(neuron),1);
profundidadX = e.electrodos.profundidad(1) * ones(length(neuron),1);
try 
    profundidadY = e.electrodos.profundidad(2) * ones(length(neuron),1);
catch
    profundidadY = NaN * ones(length(neuron),1);
end
try
    profundidadZ = e.electrodos.profundidad(3) * ones(length(neuron),1);
catch
    profundidadZ = NaN * ones(length(neuron),1);
end
%number of trials
nTrials = length(e.trial)* ones(length(neuron),1);

%analysisVariable
 analizedVariable = cell(length(neuron),1);
[analizedVariable{:}] = deal(analysisVar);


%calculates the number of trials for a specific type of analysis var
windowIndx = 1;
discard = zeros(length(neuron),1);
for j = 1:length(neuron)
    [x,y,discard(j)] = getColumn(fileName,neuron{j},windowIndx);
end
analysisVarTrials = (length(x)/length(unique(y))) * ones(length(neuron),1);
keep = ~discard;

%assigns the data to a table
tbl = table(dateRegistered,neuron,coordenadaX,coordenadaY,coordenadaZ,...
    contacto,cortezaX,cortezaY,cortezaZ,...
    orientacion,profundidadX,profundidadY,profundidadZ,...
    nTrials,monkey,file,analizedVariable,analysisVarTrials,keep);
