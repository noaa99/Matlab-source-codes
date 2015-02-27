%% Create noisy tones
clc; close all; clear all;

load touchtones.mat;

noise_power = 5;
% Noise1 : periods = N/8000 sec, N = number of points
noise1 = wgn(1, 5000, noise_power);
% Noise2 : periods = N/8000 sec, N = number of points
noise2 = wgn(1, 10000, noise_power);
% Noise3 : periods = N/8000 sec, N = number of points
noise3 = wgn(1, 15000, noise_power);
noise4 = wgn(1, 800, noise_power);
noise5 = wgn(1, 100000, noise_power);

% Zero noise
zeros1 = zeros(1, 5000);
zeros2 = zeros(1, 10000);
zeros3 = zeros(1, 15000);

% Phone number with noise between each keypress
% test 1
% phonenumber_noisy = [tone_4_noisy noise1 tone_1_noisy noise2 tone_5_noisy noise3...
%     tone_5_noisy noise2 tone_0_noisy noise3 tone_9_noisy noise1 tone_6_noisy noise2 tone_3_noisy noise1 ...
%     tone_8_noisy noise2 tone_7_noisy];

% Phone number without noise between each keypress
% test 2
% phonenumber= [tone_4 zeros1 tone_1 zeros2 tone_5 zeros3...
%     tone_5 zeros2 tone_0 zeros3 tone_9 zeros1 tone_6 zeros2 tone_3 zeros1 ...
%     tone_8 zeros2 tone_7];

% test 3
% phonenumber_noisy = [tone_4_noisy noise4 tone_9_noisy noise4 tone_6_noisy];

% test 4
% phonenumber_noisy = [tone_1_noisy noise5 tone_5_noisy noise5 tone_8_noisy];

% test 5
phonenumber_noisy = [tone_3 tone_3 tone_3_noisy tone_3_noisy noise4 ...
    tone_6_noisy tone_6_noisy tone_6_noisy tone_6_noisy tone_6_noisy tone_6_noisy tone_6_noisy ...
    noise5 tone_7_noisy tone_7_noisy noise4];
%% Pre-processing
% phonenumber_noisy = [tone_7_noisy];
sound_sample = phonenumber_noisy;
% sound_sample = phonenumber;
L = length(sound_sample);

% Load filter coefficients
load hn2.mat;
% Do filtering
sound_sample_filtered = fftconv(sound_sample, hn2);

%% DTMF Decoding
% mode 1 : processing overap the input signal
% mode 0 : does not overap processing
p_mode = 0;
out = DTMF_Decoder_v2(sound_sample_filtered(1:L), p_mode)


% Plot results
t = linspace(0,L/8000, L);
figure(2); 
plot(t, sound_sample, t, sound_sample_filtered(1:L), 'r'); grid on;
xlabel('Time[sec]'); ylabel('Amplitude'); title('Test signal 5');
legend('Original signal', 'Filtered signal');

% Plot spectrogram with result data
% [r c] = size(out.mag);
% figure(3);
% mesh(0:c-1, out.f, out.mag);
% xlabel('Time[index]'); ylabel('Frequency[Hz]'); zlabel('Magnitude');
% title('Spectrogram');
% view([-90 90]);