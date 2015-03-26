function [ yn hn ] = Equalizer( eq_set, in_snd, Fs )
% function filtered_output = Equalizer( setting );

% Description:
% The objective of this function is to filter sound file with input dB magnitude values at 
% its frequency

% The input arguments are :
%     eq_set = equalizer setting (values at nine frequency in dB scale)
%     in_snd = input sound file
%     Fs = sampling rate of sound file

% The output arguments are :
%     yn = time domain samples of output sequence of equalized result
%     yn = Equalizer filter coefficients

% Equalizer center frequencies
equal_range = [62.5 125 250 500 1000 2000 4000 8000 16000];

firstE = equal_range(1);
ft_set = 6.25;              % Frequency sampling, it should be divided by integer of FirstE
M = round(1/ft_set*Fs);     % Get the filter length
if mod(M,2) == 0
    M = M + 1;
end
ft = 1/M*Fs;                % Get frequency sampling

% Initialize magnitude samples of linear/dB scales, respectively
HF_mag_samples = zeros(1, M);
HF_mag_samples_dB = zeros(1, M);

% Assign dB values at each frequency indexes range from 0 to 1, it is
% symmetric on the center frequency (0.5)
for i = 1 : length(eq_set)
    index_low(i) = floor(equal_range(i)/ft)+1;
    HF_mag_samples_dB(1, index_low(i)) = eq_set(i); 
    index_high(i) = M - (floor(equal_range(i)/ft) - 1); 
    HF_mag_samples_dB(1, index_high(i)) = eq_set(i);
end

% Interpolation with dB values in HF_mag_samples_dB array
prevIndex = 0; nextIndex = index_low(1); k = 1;
for n = 1 : round(M/2)
    if (n > nextIndex)
        % Update indexes
        prevIndex = index_low(k);
        if (k+1 <= length(index_low))
            nextIndex = index_low(k+1);
        else
            nextIndex = round(M/2);
        end
        k = k + 1;
    end
    
    if prevIndex ~= 0
        slope_p = HF_mag_samples_dB(1, prevIndex);
    else
        slope_p = 0;
    end
    slope_n = HF_mag_samples_dB(1, nextIndex);
    numIdx = nextIndex - prevIndex;
    slope = (slope_n - slope_p)/numIdx;
    if n ~= nextIndex && n~= 1
        HF_mag_samples_dB(1, n) = slope + HF_mag_samples_dB(1, n-1);
        HF_mag_samples_dB(1, M - (n-2)) = slope + HF_mag_samples_dB(1, n-1);
    end
end

% Convert magnitude values into linear scale
HF_mag_samples = 10.^(HF_mag_samples_dB./20);

% Design a FIR filter by frequency sampling method
[hn, HF, F] = FIR_Filter_By_Freq_Sample(HF_mag_samples, 1);
len = length(HF);

% Plot frequency response of one-sided
F_half = F(1:round(len/2));
HF_half = HF(1:round(len/2));
plot_freq_responses(F_half, HF_half, Fs, 10);

% Check whether the sound file is stereo or not
dim = size(in_snd);
if dim(1,2) > 1
    filtered_1 = fftconv(in_snd(:,1), hn', 100);
    filtered_2 = fftconv(in_snd(:,2), hn', 200);
    yn(:,1) = filtered_1;
    yn(:,2) = filtered_2;
else
    yn = fftconv(in_snd, hn', 100);
end

end

