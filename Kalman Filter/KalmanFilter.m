function out = KalmanFilter(model, mData, initPara)
% function out = KalmanFilter(model, mData, initPara);
% 
% Description : This function is to do Kalman filtering with input data,
% initial parameters, and system model
%
% Notations
% K : Kalman gain
% x_e : Updated estimate
% x_em : A priori estimate
% Z : measurement vector
% H : measurement matrix
% P_m : A priori error covariance
% P : Error covariance
% phi : state transition matrix
% Q : Process noise
% R : Measurement noise
% 
%   Input parameters : 
%       model : System model
%       mData : Measurement data
%       initPara : Initial parameters
%
%   Output parameters :
%       out : Includes core matrices values
%
%   Author : Hyunjong Choi, 12/10/2014


global dimFlag

%% Step 1. Set initial values and variables
[t dim] = size(mData);
[r c] = size(model.F);

% Setting initial parameters for measurement update and time update
tOutputs.P_m = initPara.P_m;
tOutputs.x_em = initPara.x_em;
mInputs.H = model.H;
mInputs.R = initPara.R;

% Define variables to save data
x_estimate = zeros(r, t);       % Estimate state variable     
prevPos = mData(1,:);           % Previous position
curVel = zeros(1, dim);         % Current velocity
prevVel = zeros(1, dim);        % Previous velocity
acc = zeros(1, dim);            % Accerlation   
vel = zeros(dim, t);            
accel = zeros(dim, t); 

%% Step 2. Iteration
for k = 1 : t 
    % Current measurement data
    tOutputs.Z = mData(k,:);
    
    % Calculate the current velocity with the measured position data
    curVel = (mData(k,:) - prevPos)/model.t;
    
    % Calculate Acceration and update it to parameter W, and G
    if (k >= 3)
        % Calculate the accelration with the measured velocity
        acc = (curVel - prevVel)/model.t;
        % Update W which is an accelration
        model.W = diag(abs(acc));
        % Update G based on the updated W value
        if ~dimFlag
            model.G = [0 0; sqrt(acc(1,1)) 0; 0 0; 0 sqrt(acc(1,2))];
        else
            model.G = [0 0 0; sqrt(acc(1,1)) 0 0; 0 0 0; 0 sqrt(acc(1,2)) 0; 0 0 0; 0 0 sqrt(acc(1,3))];
        end
    end
    
    % Find a discrete model by using analog model parameters.
    % This is updated according to the value W
    disModel = getDiscreteModel(model);
    % phi and Q matrices are used for 'Time update' procedure
    tInputs.phi = disModel.phi;
    tInputs.Q = disModel.Q;

    % (1) Measurement Update("Correct")
    mOutputs = MeasureUpdate(tOutputs, mInputs);

    % (2) Time Update("Predict")
    tOutputs = TimeUpdate(mOutputs, tInputs);
    
    % Save the current measurement position and velocity to the previous
    % ones
    prevPos = mData(k,:);
    prevVel = curVel;

    % Save estimation values
    x_estimate(:,k) = mOutputs.x_e;
    % Save velocity of measurement
    vel(:,k) = curVel';
    % Save accelration of measurement
    accel(:,k) = acc';  
end

% Output of KalmanFilter function
out.x_e = mOutputs.x_e;
out.P = mOutputs.P;
out.x_estimate = x_estimate;
out.vel = vel;
out.acc = accel;

end
