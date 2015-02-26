function [out] = MeasureUpdate(in, mIn)
% MeasureUpdate function has 3 steps processing
% (1) Compute kalman gain
% (2) Update estimate with measurement Z
% (3) Update the error covariance
% mInputs consists of P_m, H, R, x_em, Z
% mOutputs consists of P, x_e for Time Update process
[r c] = size(in.P_m);

% (1) Compute kalman gain
K = in.P_m*(mIn.H)'/(mIn.H*in.P_m*(mIn.H)' + mIn.R);

% (2) Update estimate with measurement Z
x_e = in.x_em + K*(in.Z' - mIn.H*in.x_em);

% (3) Update the error covariance
P = (eye(r) - K*mIn.H)*in.P_m;

out.x_e = x_e;
out.P = P;

end

