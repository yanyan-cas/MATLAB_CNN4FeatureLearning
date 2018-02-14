clear
load('yaleB.mat')
 train_size = 10;
[x,y,val_x,val_y] = make_data(yaleB,train_size);


cenn.lambda = 10;
cenn.learningRate = 1;

%xtrain = [xtrain, xvalidate];
%ytrain = [ytrain, yvalidate];
%mTrain = size(xtrain, 2);

% Learning rate parameters
opts.batchsize = 38*train_size; % power of 2 for faster matrix operation
opts.numepochs = 10;
opts.mu = 0.9; % Momentum update for faster converge
opts.epsilon = 0.01; % Initialize learning rate
opts.gamma = 0.0001;
opts.power = 0.75;
opts.weightDecay = 0.0005; % Decaying weight to avoid over-shooting at the later stage of GDS

cenn.equ = 1;
cenn.complex = 0;
cenn.t = 0.5;
cenn.momentum = 0;
cenn.weightPenaltyL2 = 0;
cenn.layers = {
          struct('type', 'CeNN');
         struct('type', 'CeNN');
   % struct('type', 's', 'scale', 2,'function','mean') %sub sampling layer
         struct('type', 'CeNN');
         struct('type', 'CeNN');
         struct('type', 'CeNN');
};

cenn.beta = 1;

cenn.n = numel(cenn.layers) + 1;
[cenn] = CellularNeuralNetwork(cenn, x, y, val_x, val_y, opts);
