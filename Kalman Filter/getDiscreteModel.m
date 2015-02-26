function model = getDiscreteModel(para)
% getDiscreteModel is a function to convert analog model into discrete one
% By using numerical method of Van Loan
% Input includes matrix (F, G) and scalar (W, del_t)
% Output is matrix of phi and Q
% Assign parameters from input args
F = para.F;
G = para.G;
W = para.W;
del_t = para.t;

% Step 1 : Form a matrix A
[n m] = size(F);
I = zeros(n, n);
A = [-F G*W*G';I F']*del_t;

% Step 2 : Form a matrix B
B = expm(A);

% Step 3 : Transpose the lower-right partition of B to get phi_k
[nb mb] = size(B);
phi = B(nb/2+1:nb, nb/2+1:nb)';

% Step 4: Q = phi*[upper-right partition of B]
Q = phi*B(1:nb/2, nb/2+1:nb);

model.phi = phi;
model.Q = Q;

end

