function [cenn] = CellularNeuralNetwork(cenn, train_x, train_y, val_x, val_y, opts)

m = size(train_x, 3);

cenn.batchsize = opts.batchsize;

%%step1 Initialization
[cenn] = cennInitial(cenn);

[cenn.valAccuracy] = cennEvaluation(cenn, train_x, train_y, val_x, val_y, cenn.lambda);

disp([' Original Val accurate is ' num2str(cenn.valAccuracy)]);


%% step2 Training
numepochs = opts.numepochs;
numbatches = m / cenn.batchsize;
cenn.testvalAccuracy = [ ];

n = 1;
for i = 1 : numepochs
    tic;
    kk = randperm(m);
    
    for l = 1 : numbatches
        batch_x = train_x(:,:,kk((l - 1) * cenn.batchsize + 1 : l * cenn.batchsize));        
        batch_y = train_y(:,kk((l - 1) * cenn.batchsize + 1 : l * cenn.batchsize));
        
        cenn = cennFeedForward(cenn, batch_x);
        cenn = cennBackPropagation(cenn, batch_x, batch_y);
        cenn = cennApplyGrads(cenn);
        n = n + 1;
    end
    
    t = toc;
    
    cenn.valAccuracy = [cenn.valAccuracy, cennEvaluation(cenn, train_x, train_y, val_x, val_y, cenn.lambda)];
    
    cenn.trainval_acc = cennEvaluationB(cenn,  train_x, train_y);
    cenn.testval_acc= [cenn.testval_acc; cennEvaluationB(cenn,  val_x, val_y)];
    
    if mod(i,1)==0
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs) '. Took ' num2str(t) ' seconds'...
            '.Train Error is ' num2str(cenn.error)  '. Val accurate is ' num2str(cenn.testval_acc(i))]);
    end
    
    cenn.learningRate = cenn.learningRate * cenn.scaling_learningRate;
    
end
end
