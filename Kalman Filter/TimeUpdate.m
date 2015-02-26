function [out] = TimeUpdate(in, tIn)
% TimeUpdate function has 2 steps processing
% (1) Project the state ahead
% (2) Project the error covariance ahead
% tInputs consists of x_e, P, Q, phi
% tOutputs consists of P_m, x_em for Measurement Update process

% (1) Project the state ahead
x_em = tIn.phi*in.x_e;

% (2) Project the error covariance ahead
P_m = tIn.phi*in.P*tIn.phi' + tIn.Q;

out.x_em = x_em;
out.P_m = P_m;

end
