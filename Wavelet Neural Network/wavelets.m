function out = wavelets(u, t, d, mode)
% function out = wavelets( inVect, t, d, mode);
% The function is a wavelet functions to be used as an activation function
% As a default, the wavelet is a Mexican Hat Wavelet

% Input parameters are :
%   u : is the neuron an input vector of dimension
%   t : is a translation
%   d : is a dilation, which set the width of hat
%   mode ('de' or default(none)): to determine whether it use a derivative mode or not.

% Output is a result of wavelet function :
%   psi : is the output of wavelet function

% Mexican Hat Wavelet equation
% psi(tao) = 2/sqrt(3)*pi^(-1/4)*(1-?^2)*exp(-tao^2/2)
% tao = (u - t)/d

tau = (u - t)./d;

% if strcmp(mode, 'de')
%     out = 2/sqrt(3)*pi^(-1/4)*tau*(3-tau^2)*exp(-tau^2/2)/d;
% else
%     out = 2/sqrt(3)*pi^(-1/4)*(1-tau^2)*exp(-tau^2/2);
% end

if strcmp(mode, 'de')
    out = -exp(-tau.^2./2).*(5.*sin(5*tau)+tau.*cos(5*tau));
else
    out = exp(-tau.^2./2).*cos(5*tau);
end

end

