function out = fftconv( xn, hn )
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

% If the number of NFFT is over 1024, use Overlap-Add method
if NFFT > 1024
    count = 2;
    Npoint = NFFT;
    % Divide by original signal until N point is less than equal to 1024
    while Npoint > 1024
        newN = floor(N / count);    % N points of signal will be performed at every time except the last one.
        iter = ceil(N / newN);      % Iteration number
        Npoint = 2^nextpow2(newN + M - 1);      % Get the nearest power of 2 for FFT
        count = count + 1;
    end
    
    yn_tmp = zeros(iter, N+M-1);    % Initialize temporary yn variable
    for n = 1 : iter
        % The last iteration should be run exceptionally because the number
        % of sample is not always equal to previous ones.
        if n == iter && mod(N, newN) ~= 0
            % N-point FFT in order to compute FFT fast
            nNFFT = 2^nextpow2(nN + M - 1);
            % Do FFT of signal
            X = fft(xn((newN*(n-1)+1):end), nNFFT);
            % Do FFT of filter
            H = fft(hn, nNFFT);
            % Multiply magnitude responses
            Y = X.*H;
            % Do iFFT of magnitude response of result
            tmp = ifft(Y);
            % Row of tmp : iteration number
            % Col of tmp : time index
            yn_tmp(n, (newN*(n-1)+1):(newN*(n-1)+nN+M-1)) = tmp(1:nN+M-1);
        else
            nN = newN;
            % N-point FFT in order to compute FFT fast
            nNFFT = 2^nextpow2(nN + M - 1);
            % Do FFT of signal
            X = fft(xn((nN*(n-1)+1):nN*n), nNFFT);
            % Do FFT of filter
            H = fft(hn, nNFFT);
            % Multiply magnitude responses
            Y = X.*H;
            % Do iFFT of magnitude response of result
            tmp = ifft(Y);
            % Row of tmp : iteration number
            % Col of tmp : time index
            yn_tmp(n, (nN*(n-1)+1):(nN*n+M-1)) = tmp(1:nN+M-1);
        end
        
    end
    % The values of the same columns should be summed.
    yn = sum(yn_tmp);
    NFFT = nNFFT;
else
    % Execute the convfft when NFFT is not above 1024 points
    X = fft(xn, NFFT);
    H = fft(hn, NFFT);
    Y = X.*H;
    yn = real(ifft(Y));
end

% X-axis index
ynIdx = 0:N+M-2;
xnIdx = 0:N-1;
hnIdx = 0:M-1;
Fd = linspace(0, 1, NFFT);

% Plot figures to check the results
figure(1);
subplot(3,2,1);
stem(xnIdx, xn, '.'); grid on;
title('x[n]'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,2,2);
plot(Fd, abs(X)); grid on;
title('X[k] spectrum'); xlabel('Digital Frequency'); ylabel('Magnitude response');
subplot(3,2,3);
stem(hnIdx, hn, '.'); grid on;
title('h[n]'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,2,4);
plot(Fd, abs(H)); grid on;
title('H[k] spectrum'); xlabel('Digital Frequency'); ylabel('Magnitude response');
subplot(3,2,5);
stem(ynIdx, yn(1:(N+M-1)), '.'); grid on;
title('y[n]'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,2,6);
plot(Fd, abs(Y)); grid on;
title('Y[k] spectrum'); xlabel('Digital Frequency'); ylabel('Magnitude response');

out = yn(1:(N+M-1));

end

