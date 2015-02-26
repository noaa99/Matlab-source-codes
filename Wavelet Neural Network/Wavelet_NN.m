function [ outputs ] = Wavelet_NN( inputs, weights, H, translation, dilation, y_bar )
% function [ outputs ] = Wavelet_NN( inputs, weights, translation, dilation);
% Description of function : This function is to get output of wavelet
% neural network with trained weighting factors and parameters of wavelet
% function
%
% Input parameters (arguments) are:
%     inputs : input vectors (N X M), N:elements, M:# of input sets
%     weights : weights factors 
%     H : hidden layer & the number of neurons
%     translation : parameters of wavelet function
%     dilation : parameters of wavelet function
%     y_bar : bias for output layer
% 
% Output values returned are:
%     outputs : outputs of WNN
% 
% Developed by: Hyunjong Choi
% Revised: 2/16/2015

numOfHiddenLayer = size(H, 2);
numOfTotalLayer = numOfHiddenLayer + 2;

% Execute the number of input sets
for in = 1 : size(inputs, 2)    
    vec_input = inputs(:, in);
    % input is placed at the first cell of output
    outputs{1}(:,in) = vec_input;
    for n = 1 : (numOfTotalLayer-1)
        sumOutputs{n}(:,in) = weights{n}*outputs{n}(:,in);
        if n ~= (numOfTotalLayer-1)
            % Hidden layer output is the output of activation function
            outputs{n+1}(:,in) = wavelets(sumOutputs{n}(:,in), translation{n}, dilation{n}, '');
        else
            % Output layer is summation of multiplication of weights
            outputs{n+1}(:,in) = sumOutputs{n}(:,in) + y_bar(:, in);
        end
    end
end

end

