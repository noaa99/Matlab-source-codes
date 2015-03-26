% Project 11 - Equalizer test script
clc; clear all; close all;

[xn, Fs] = audioread('ZaraExcerpt.wav'); 

% Center frequency [62.5 125 250 500 1000 2000 4000 8000 16000]
% input_value = [12 12 12 -12 -12 -12 -12 -12 -12];
input_value = [12 -6 -12 -12 -6 12 -6 12 -6];
% input_value = [0 0 0 0 0 0 0 0 0];
% input_value = [8 2.4 0 -2 -2 0 2 4 6];


[ yn hn ] = Equalizer( input_value, xn, Fs );
soundsc(yn, Fs);
% soundsc(xn, Fs);



%% FFT of sound signal

% L = length(xn);       % Length of signal
% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
% Y = fft(xn,NFFT)/L;
% f = Fs/2*linspace(0,1,NFFT/2+1);
% % Plot single-sided amplitude spectrum.
% figure(400);
% plot(f,2*abs(Y(1:NFFT/2+1))) 
% title('Single-Sided Amplitude Spectrum of y(t)')
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|')