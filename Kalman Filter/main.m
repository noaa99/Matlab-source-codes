%% Main to run kalman filter
% (1) Load measurement data
% (2) Set model parameters in continuous time
% (3) Set initial parameters for Kalman filter iteration
% (4) Run the Kalman filter
% (5) Plot the result
clc; clear all; close all

% dimFlag : 0 => 2D model, 1 => 3D modelPlo
global dimFlag
dimFlag = 0;

%% Load measurement data
if ~dimFlag
    data = load('2Ddata.txt');
    mData = data(:,2:3);
else
    data = load('3Ddata.txt');
    mData = data;
end

%% Set initial parameters
W = 1;      % PSD of input (It could be an accelration)
del_t = 1;  % Sampling time

% Set model parameters in continuous time
% X' = FX + Gu, Y = HX
if ~dimFlag
    % 2D model
    F = [0 1 0 0; 0 0 0 0; 0 0 0 1; 0 0 0 0]; 
    G = [0 0; sqrt(W) 0; 0 0; 0 sqrt(W)];
    H = [1 0 0 0; 0 0 1 0];
else
    % 3D model
    F = [0 1 0 0 0 0 ; 0 0 0 0 0 0 ; 0 0 0 1 0 0; 0 0 0 0 0 0; 0 0 0 0 0 1; 0 0 0 0 0 0]; 
    G = [0 0 0; sqrt(W) 0 0; 0 0 0; 0 sqrt(W) 0; 0 0 0; 0 0 sqrt(W)];
    H = [1 0 0 0 0 0; 0 0 1 0 0 0; 0 0 0 0 1 0];
end

model.F = F;
model.G = G;
model.W = W;
model.H = H;
model.t = del_t;
[n m] = size(F);
[mr mc] = size(H);

% Set initial value of error covariance(P_m) and estimated state(x_em)
initPara.P_m = 10e10*eye(n);
initPara.x_em = zeros(n, 1);
initPara.R = 100000*eye(mr);


%% Run kalman filter
result = KalmanFilter(model, mData, initPara);


%% Plot the result
figure(1)
if ~dimFlag
    plot(mData(:,1), mData(:,2), 'b'); hold on; grid on;
    plot(result.x_estimate(1,:)', result.x_estimate(3,:)', 'r', 'LineWidth', 1);
    xlabel('X position'); ylabel('Y position');
    title('Kalman filter 2D', 'fontSize', 15);
    legend('Raw data', 'Filtered');
    
%     figure(2);
%     time = 1:del_t:length(data);
%     plot(time, mData(:,1), 'b', time, result.x_estimate(1,:)', 'r'); grid on;
%     title('X-axis', 'fontSize', 15); xlabel('Time[sec]'); ylabel('Position');
%     figure(3);
%     plot(time, mData(:,2), 'b', time, result.x_estimate(3,:)', 'r'); grid on;
%     title('Y-axis', 'fontSize', 15); xlabel('Time[sec]'); ylabel('Position');
%     
%     figure(4);
%     plot(time, (mData(:,1)-result.x_estimate(1,:)'), 'b', time, (mData(:,2)-result.x_estimate(3,:)'), 'r'); grid on;
%     title('Error [Measurement - Estimate]', 'fontSize', 15); xlabel('Time[sec]'); ylabel('Position Error');
    
else
    plot3(mData(:,1), mData(:,2), mData(:,3), 'b'); hold on; grid on;
    plot3(result.x_estimate(1,:)', result.x_estimate(3,:)', result.x_estimate(5,:), 'r', 'LineWidth', 2);
    view(-82, 26);
    xlabel('X position'); ylabel('Y position'); zlabel('Z position');
    title('Kalman filter 3D', 'fontSize', 15);
    legend('Raw data', 'Filtered');
    
    figure(2);
    time = 1:del_t:length(data);
    plot(time, mData(:,1), 'b', time, result.x_estimate(1,:)', 'r'); grid on;
    title('X-axis', 'fontSize', 15); xlabel('Time[sec]'); ylabel('Position');
    figure(3);
    plot(time, mData(:,2), 'b', time, result.x_estimate(3,:)', 'r'); grid on;
    title('Y-axis', 'fontSize', 15); xlabel('Time[sec]'); ylabel('Position');
    figure(4);
    plot(time, mData(:,3), 'b', time, result.x_estimate(5,:)', 'r'); grid on;
    title('Z-axis', 'fontSize', 15); xlabel('Time[sec]'); ylabel('Position');

end