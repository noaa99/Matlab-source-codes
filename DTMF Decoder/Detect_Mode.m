function out = Detect_Mode ( in, Fs )
% function out = Detect_Mode ( in, Fs );
% Lab 3 - Part 4. DTMF signal decoder
% Determine whether the input sequence is tones or not.
%
% Input parameters (arguments) are:
%     in = input sequence
%     Fs : sampling frequency
%
% Output values returned are:
%     out.mode = mode ( 1 : tone, 0 : pause )
%     out.mag = magnitude response of FFT
% 
% Developed by: Hyunjong Choi and Chris Paige
% Revised: 2/2/2015

L = length(in);
NFFT = 2^nextpow2(L);

% Do FFT of signal
Y = fft(in, NFFT);
% Frequency domain
f = Fs/2*linspace(0,1,NFFT/2+1);
% Find max of magnitude response
[peak idx] = max(abs(Y(1:NFFT/2+1)));

freq = f(idx);

% if (((freq >= 680 && freq <= 717)|(freq >= 750 && freq <= 790)|(freq >= 832 && freq <= 872)|(freq >= 921 && freq <= 961)|...
%     (freq >= 1189 && freq <= 1229)|(freq >= 1316 && freq <= 1356)|(freq >= 1457 && freq <= 1497)|(freq >= 1613 && freq <= 1653)) && (peak >= 200))
if freq >= 680 && freq <= 1653 && peak >= 200
    mode = 1;
else
    mode = 0;
end
% output
out.mode = mode;
out.mag = Y;
out.f = f;

end

