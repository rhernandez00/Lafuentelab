function [performance,predictions] = runClassification(X,y,varargin)
%classification with a chosen classifier, the default is CSVM
%Función para hacer entrenamiento y clasificación usando los classificadores 
%disponibles en MATLAB, recibe X y . X es una matriz con los features, mientras 
%que y contiene las etiquetas
classifier = getArgumentValue('classifier','CSVM',varargin{:});

switch classifier
    case 'CSVM'
        model = fitcsvm(X,y);    
    case 'ClassificationDecisionTree'
        model = fitctree(X,y);
    case 'LDA'
        model = fitcdiscr(X,y);
    case 'NaiveBayes'
        model = fitcdiscr(X,y);
    case 'NearestNeighbor'
        model = fitcknn(X,y);
    case 'LogisticRegression'
        model = fitglm(X,y);
    otherwise
        error('wrong classifier')
end


CVModel = crossval(model);
predictions = kfoldPredict(CVModel);
performance = mean(predictions==y);