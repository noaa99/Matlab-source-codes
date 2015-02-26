function [ weights, actOutputs, translation, dilation, y_bar ] = Wavelet_NN_Train( inputs, outputs, H, iteration, rate )
% function [ weights, actOutputs, translation, dilation ] =
% Wavelet_NN_Train( inputs, outputs, H, iteration, rate );
% Description of function : The function is to train weights and parameters
% of wavelet neural network.
%
% Input parameters (arguments) are:
%     inputs : input vectors (N X M), N:elements, M:# of input sets
%     outputs : output vectors (K X M), K:elements, M:# of input sets
%     H : hidden layer & the number of neurons
%     iteration : the number of iteration to execute
%     rate : learning rate
% 
% Output values returned are:
%     weights : weights factors    
%     actOutputs : outputs of each layers ( first cell: input, last cell:
%     output
%     translation : parameters of wavelet function
%     dilation : parameters of wavelet function
%     y_bar : bias values for output layer
%
% Developed by: Hyunjong Choi
% Revised: 2/15/2015

rand('seed', 1);

numOfHiddenLayer = size(H, 2);
numOfTotalLayer = numOfHiddenLayer + 2;
y_bar = rand(size(outputs, 1), size(outputs, 2));

% Initialize weights factor for each layer
for l = 1 : numOfTotalLayer-1
    if l == 1
        % Weights factors between input layer and hidden layer
        weights{l} = rand(H(l), size(inputs, 1));
    elseif l == (numOfTotalLayer-1)
        % Weights factors between output layer and hidden layer
        weights{l} = rand(size(outputs, 1), H(l-1));
    else
        % Weights factors between hidden layers, if it exits
        weights{l} = rand(H(l), H(l-1));
    end
end

% Initalize wavelet network parameters (dilation, translation)
d1 = 0; d2 = 1;
% Each layer is a cell of translation{}, dilation{}
for l = 1 : numOfHiddenLayer
    % Define parameters for neurons at each layer
    for n = 1 : H(l)
        scale = rand(1);
        if n == 1
            translation{l}(n,1) = (d2 - d1)*scale;
            dilation{l}(n,1) = 0.5*(d2 - d1);
        elseif mod(n, 2) == 0
            translation{l}(n,1) = translation{l}(n/2)*(d2 - d1)*scale;
            dilation{l}(n,1) = 0.5*(translation{l}(n/2) - d1);
        else
            translation{l}(n,1) = d2 - translation{l}((n-1)/2)*scale;
            dilation{l}(n,1) = 0.5*(d2 - translation{l}((n-1)/2));
       end
    end
end

% Execute iteration
for i = 1 : iteration
    
    % For one iteration, it includes the number of input SETs
    % A set of inputs has the number of input elements
    for in = 1 : size(inputs, 2)
    
        vec_input = inputs(:, in);
        vec_output = outputs(:, in);
        
        actOutputs{1}(:,in) = vec_input;
        actOutputsDer{1}(:,in) = vec_input;   % Derivative of first cell is dummy for input
        
        for n = 1 : (numOfTotalLayer-1)
            sumOutputs{n}(:,in) = weights{n}*actOutputs{n}(:,in);
            if n ~= (numOfTotalLayer-1)
                actOutputs{n+1}(:,in) = wavelets(sumOutputs{n}(:,in), translation{n}, dilation{n}, '');
                actOutputsDer{n+1}(:,in) = wavelets(sumOutputs{n}(:,in), translation{n}, dilation{n}, 'de');
            else
                actOutputs{n+1}(:,in) = sumOutputs{n}(:,in) + y_bar(:, in);
            end
        end
    
        % Update weights factors by using propagation algorithm
        for w = 1 : (numOfTotalLayer-1)
            % When w is equal to '1', it is the last layer, which is the final output layer
            if w == 1
                % Error = Output_target - Output_actual
                error{numOfTotalLayer-w}(:,in) = vec_output - actOutputs{numOfTotalLayer-w+1}(:,in);
                y_bar(:, in) = y_bar(:, in) + error{numOfTotalLayer-w}(:,in);
            else
            % Apply BP algorithm to the hidden layers
                % Calculate hidden layer error : e = wavelet_derivative*error_output*weights
                tmp_error = error{numOfTotalLayer-w+1}(:,in)'*weights{numOfTotalLayer-w+1};
                error{numOfTotalLayer-w}(:,in) = tmp_error'.*actOutputsDer{numOfTotalLayer-w+1}(:,in);
            end
            
            if w ~= (numOfTotalLayer-1)
                % tau = (u - t)/d
                tau = (sumOutputs{numOfTotalLayer-(w+1)}(:,in) - translation{numOfTotalLayer-(w+1)})./dilation{numOfTotalLayer-(w+1)};
                % Update translation : t_new = t_old - learningRate*Error*weights*1/dilation*psi_derivative;
                translation{numOfTotalLayer-(w+1)} = translation{numOfTotalLayer-(w+1)} - rate*(error{numOfTotalLayer-w}(:,in)'*weights{numOfTotalLayer-w})'*1./dilation{numOfTotalLayer-(w+1)}.*actOutputsDer{numOfTotalLayer-w}(:,in);
                % Update dilation : d_new = d_old - learningRate*Error*weights*1/dilation*tau*psi_derivative;
                dilation{numOfTotalLayer-(w+1)} = dilation{numOfTotalLayer-(w+1)} - rate*(error{numOfTotalLayer-w}(:,in)'*weights{numOfTotalLayer-w})'*1./dilation{numOfTotalLayer-(w+1)}.*tau.*actOutputsDer{numOfTotalLayer-w}(:,in);
            end
            
            % Update weights : W_new = W_old + learningRate*Error*Output;
            weights{numOfTotalLayer-w} = weights{numOfTotalLayer-w} + rate*error{numOfTotalLayer-w}(:,in)*actOutputs{numOfTotalLayer-w}(:,in)';
        end
    end
end

end     % End of function

