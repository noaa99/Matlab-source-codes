%% WNN Test script
clc; clear all;
%% Train Network
% Hidden layer define
% column is the number of hidden layers
% values are the number of neurons at each hidden layer
H = [4 3 4];

% Inputs to train
inputs = rand(3, 3);
outputs = rand(10, 3);  % Target outputs

iteration = 200;    % Number of iteration for learning
rate = 0.5;         % Learning rate

% Train weighting factors and parameters
[ weights, actOutputs, translation, dilation, y_bar ] = ...
    Wavelet_NN_Train(inputs, outputs, H, iteration, rate);

targetOutput = outputs
actualOutput = actOutputs{size(H, 2)+2}

%% Running Network
testInputs = inputs;

[ results ] = Wavelet_NN(testInputs, weights, H, translation, dilation, y_bar);

runningOutputwithSameInput = results{size(H, 2)+2}
