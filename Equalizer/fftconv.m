function out = fftconv( xn, hn, fignum )
% function yn = fftconv( xn, hn );

% Description:
% The objective of this function is to perform convolution using FFT

% The input arguments are :
%     xn = time domain samples of a discrete-time input sequence
%     hn = time domain samples of a discrete-time filter sequence

% The output arguments are :
%     yn = time domain samples of output sequence of convolution

% Length of signal
N = length(xn);
% Length of filter
M = length(hn);

% N-point FFT in order to compute FFT fast
NFFT = 2^nextpow2(N + M - 1);

% Execute the convfft
X = fft(xn, NFFT);
H = fft(hn, NFFT);
Y = X.*H;
yn = real(ifft(Y));

% X-axis index
ynIdx = 0:N+M-2;
xnIdx = 0:N-1;
hnIdx = 0:M-1;
Fd = linspace(0, 1, NFFT);

% Plot figures to check the results
figure(fignum);
subplot(3,2,1);
stem(xnIdx, xn, '.'); grid on;
title('x[n]'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,2,2);
plot(Fd(1:round(length(Fd)/2)), abs(X(1:round(length(Fd)/2)))); grid on; xlim([0 0.5]);
title('X[k] spectrum'); xlabel('Digital Frequency'); ylabel('Magnitude response');
subplot(3,2,3);
stem(hnIdx, hn, '.'); grid on;
title('h[n]'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,2,4);
plot(Fd(1:round(length(Fd)/2)), abs(H(1:round(length(Fd)/2)))); grid on; xlim([0 0.5]);
title('H[k] spectrum'); xlabel('Digital Frequency'); ylabel('Magnitude response');
subplot(3,2,5);
stem(ynIdx, yn(1:(N+M-1)), '.'); grid on;
title('y[n]'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,2,6);
plot(Fd(1:round(length(Fd)/2)), abs(Y(1:round(length(Fd)/2)))); grid on; xlim([0 0.5]);
title('Y[k] spectrum'); xlabel('Digital Frequency'); ylabel('Magnitude response');

out = yn(1:(N+M-1));

end

