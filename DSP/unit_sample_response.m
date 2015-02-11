function [hn, n] = unit_sample_response(Bk, Ak, number_of_samples, figure_number)
% function [hn, n] = unit_sample_response(Bk, Ak, number_of_samples,
% figure_number);
% Bk = a list of the Bk coefficients of the filter difference equation (coefficients of the ?x? terms)
% Ak = a list of the Ak coefficients of the filter difference equation (coefficients of the ?y? terms)
% number_of_samples = # of unit sample response sequence samples to find figure_number = # figure for the hn sequence plot

% Create unit samples
[un n] = unit_sample(number_of_samples);

% Filtering
hn = filter(Bk, Ak, un);

% Plot stem figure
figure(figure_number);
stem(n, hn, '.'); grid on;
title('Unit Sample Response'); xlabel('Sample Index'); ylabel('Response Value');

end

