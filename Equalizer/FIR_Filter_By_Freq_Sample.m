function [ hn, HF, F ] = FIR_Filter_By_Freq_Sample( HF_mag_samples, figurenum )
% function [ hn, HF, F ] = FIR_Filter_By_Freq_Sample( HF_mag_samples, figurenum )
%
%   Input parameters:
%       HF_mag_samples - H[k] Magnitude response samples for desired filter
%       figurenum - Figure # to plot frequency responses
% 
%   Output parameters:
%       hn - Impulse response of filter (same length as HF_mag_samples)
%       HF - Complex frequency response of filter.(estimated by FFT or
%       freqz)
% 

M = length(HF_mag_samples); % Length of filter
NFFT = 262144;    % For FFT

for k = 1 : M
    %  Generate phase when M is from '0' to 'M-1/2'
    if k <= ((M-1)/2+1)
        phase(k) = exp(-j*pi*(k-1)*(M-1)/M);
    else
        % If else, phase should be symmetry
        phase(k) = conj(phase(M-k+2));
    end
    H(k) = abs(HF_mag_samples(k))*phase(k);
    Hf(k) = 1/M*(k-1);
end

% for n = 1 : M
%     tmp = 0;
%     for k = 1 : M
%     
%         tmp = tmp + H(k)*exp(j*2*pi*(n-1)*(k-1)/M);
%         
%     end
%     hh(n) = tmp/M;
% end


% Find impulse response of the filter in time-domain
hnn = ifft(H);
hnn = hnn.*hamming(length(hnn))';

hn = real(hnn);
% Perform FFT with NFFT
HF = fft(hnn, NFFT);
F = linspace(0, 1, NFFT);

% Plot Frequency response results
figure(figurenum);
subplot(2,1,1);
plot(F, abs(HF), 'b', 'LineWidth', 2); hold on; grid on;
stem(Hf, abs(H), 'ro', 'LineWidth', 2);
xlabel('Digital Frequency F (cycle/sample)'); ylabel('Magnitude Response');
title('Frequency Response of FIR Filter');
subplot(2,1,2);
plot(F, angle(HF)/pi, 'b', 'LineWidth', 2); hold on; grid on;
stem(Hf, angle(phase)/pi, 'ro', 'LineWidth', 2);
xlabel('Digital Frequency F (cycle/sample)'); ylabel('Phase / pi');

end

