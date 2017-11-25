function tbl = getFileMetadata(fileName,folder)
% gets metadata from a file and gives it back as a table. One row for each neuron

load([folder,fileName]); %loads e
neuron = fields(e.spikes); %gets the available neurons

%gets the data from e and places it in variables
coordenadaX = e.canulas.coordenadas(1) * ones(length(neuron),1);
coordenadaY = e.canulas.coordenadas(2) * ones(length(neuron),1);
coordenadaZ = e.canulas.coordenadas(3) * ones(length(neuron),1);
contacto = e.canulas.contacto * ones(length(neuron),1);

orientacion = cell(length(neuron),1);
[orientacion{:}] = deal(e.canulas.orientacion);

monkey = cell(length(neuron),1);
[monkey{:}] = deal(fileName(1));

dateRegistered = cell(length(neuron),1);
[dateRegistered{:}] = deal(strtok(e.Fecha));

file = cell(length(neuron),1);
[file{:}] = deal(fileName);

cortezaX = e.electrodos.corteza(1) * ones(length(neuron),1);
cortezaY = e.electrodos.corteza(2) * ones(length(neuron),1);
cortezaZ = e.electrodos.corteza(3) * ones(length(neuron),1);
profundidadX = e.electrodos.profundidad(1) * ones(length(neuron),1);
profundidadY = e.electrodos.profundidad(2) * ones(length(neuron),1);
profundidadZ = e.electrodos.profundidad(3) * ones(length(neuron),1);
nTrials = length(e.trial)* ones(length(neuron),1);


%assigns the data to a table
tbl = table(dateRegistered,neuron,coordenadaX,coordenadaY,coordenadaZ,...
    contacto,cortezaX,cortezaY,cortezaZ,...
    orientacion,profundidadX,profundidadY,profundidadZ,...
    nTrials,monkey,file);

